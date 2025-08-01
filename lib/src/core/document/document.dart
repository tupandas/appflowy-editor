import 'dart:collection';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/core/document/table_of_content.dart'
    show TableOfContent;

/// [Document] represents an AppFlowy Editor document structure.
///
/// It stores the root of the document.
///
/// **DO NOT** directly mutate the properties of a [Document] object.
///
class Document {
  Document({
    required this.root,
  }) {
    calculateTableOfContents();
  }

  List<TableOfContent> tableOfContents = [];

  void calculateTableOfContents() {
    final headings = nodes.where((node) => node.type == 'heading');
    if (headings.isEmpty) {
      return;
    }

    final tableOfContents = <TableOfContent>[];

    TableOfContent? currentTableOfContent;

    for (final node in nodes) {
      if (node.type == 'heading') {
        if (currentTableOfContent != null) {
          tableOfContents.add(currentTableOfContent);
          currentTableOfContent = null;
        }

        final text = node.text;

        if (text != null && text.isNotEmpty) {
          currentTableOfContent = TableOfContent(
            text: text,
            level: node.level,
            selection: Selection(
              start: Position(path: node.path, offset: 0),
              end: Position(path: node.path, offset: text.length),
            ),
          );
        }
      } else {
        final currSelection = currentTableOfContent?.selection;
        currentTableOfContent = currentTableOfContent?.copyWith(
          selection: currSelection?.copyWith(
            end: Position(path: node.path, offset: node.text?.length ?? 0),
          ),
        );
      }
    }

    if (currentTableOfContent != null) {
      tableOfContents.add(currentTableOfContent);
    }

    this.tableOfContents = tableOfContents;
  }

  /// Constructs a [Document] from a JSON strcuture.
  ///
  /// _Example of a [Document] in JSON format:_
  /// ```
  /// {
  ///   'document': {
  ///     'type': 'page',
  ///     'children': [
  ///       {
  ///         'type': 'paragraph',
  ///         'data': {
  ///           'delta': [
  ///             { 'insert': 'Welcome ' },
  ///             { 'insert': 'to ' },
  ///             { 'insert': 'AppFlowy!' }
  ///           ]
  ///         }
  ///       }
  ///     ]
  ///   }
  /// }
  /// ```
  ///
  factory Document.fromJson(Map<String, dynamic> json) {
    assert(json['document'] is Map);

    final document = Map<String, Object>.from(json['document'] as Map);
    final root = Node.fromJson(document);
    return Document(root: root);
  }

  /// Creates a empty document with a single text node.
  @Deprecated('use Document.blank() instead')
  factory Document.empty() {
    final root = Node(
      type: 'document',
      children: LinkedList<Node>()..add(TextNode.empty()),
    );
    return Document(
      root: root,
    );
  }

  /// Creates a blank [Document] containing an empty root [Node].
  ///
  /// If [withInitialText] is true, the document will contain an empty
  /// paragraph [Node].
  ///
  factory Document.blank({bool withInitialText = false}) {
    final root = Node(
      type: 'page',
      children: withInitialText ? [paragraphNode()] : [],
    );
    return Document(
      root: root,
    );
  }

  /// The root [Node] of the [Document]
  final Node root;

  /// First node of the document.
  Node? get first => root.children.firstOrNull;

  /// All nodes of the document.
  List<Node> get nodes => root.children;

  /// Last node of the document.
  Node? get last {
    Node? current = root.children.lastOrNull;
    while (current != null && current.children.isNotEmpty) {
      current = current.children.last;
    }
    return current;
  }

  /// Must call this method when the [Document] is no longer needed.
  void dispose() {
    final nodes = NodeIterator(document: this, startNode: root).toList();
    for (final node in nodes) {
      node.dispose();
    }
  }

  /// Returns the node at the given [path].
  Node? nodeAtPath(Path path) {
    return root.childAtPath(path);
  }

  bool insertNodesToEndOfDocument(Iterable<Node> nodes) {
    if (nodes.isEmpty) {
      return false;
    }

    final path = this.nodes.last.path;

    final target = nodeAtPath(path);
    if (target != null) {
      for (final node in nodes) {
        target.insertBefore(node);
      }
      return true;
    }

    final parent = nodeAtPath(path.parent);
    if (parent != null) {
      for (var i = 0; i < nodes.length; i++) {
        parent.insert(nodes.elementAt(i), index: path.last + i);
      }
      return true;
    }

    return false;
  }

  /// Inserts a [Node]s at the given [Path].
  bool insert(Path path, Iterable<Node> nodes) {
    if (path.isEmpty || nodes.isEmpty) {
      return false;
    }

    final target = nodeAtPath(path);
    if (target != null) {
      for (final node in nodes) {
        target.insertBefore(node);
      }
      return true;
    }

    final parent = nodeAtPath(path.parent);
    if (parent != null) {
      for (var i = 0; i < nodes.length; i++) {
        parent.insert(nodes.elementAt(i), index: path.last + i);
      }
      return true;
    }

    return false;
  }

  /// Deletes the [Node]s at the given [Path].
  bool delete(Path path, [int length = 1]) {
    if (path.isEmpty || length <= 0) {
      return false;
    }
    var target = nodeAtPath(path);
    if (target == null) {
      return false;
    }
    while (target != null && length > 0) {
      final next = target.next;
      target.unlink();
      target = next;
      length--;
    }
    return true;
  }

  /// Updates the [Node] at the given [Path]
  bool update(Path path, Attributes attributes) {
    // if the path is empty, it means the root node.
    if (path.isEmpty) {
      root.updateAttributes(attributes);
      return true;
    }
    final target = nodeAtPath(path);
    if (target == null) {
      return false;
    }
    target.updateAttributes(attributes);
    return true;
  }

  /// Updates the [Node] with [Delta] at the given [Path]
  bool updateText(Path path, Delta delta) {
    if (path.isEmpty) {
      return false;
    }
    final target = nodeAtPath(path);
    final targetDelta = target?.delta;
    if (target == null || targetDelta == null) {
      return false;
    }
    target.updateAttributes({'delta': (targetDelta.compose(delta)).toJson()});
    return true;
  }

  /// Returns whether the root [Node] does not contain
  /// any text.
  ///
  bool get isEmpty {
    if (root.children.isEmpty) {
      return true;
    }

    if (root.children.length > 1) {
      return false;
    }

    final node = root.children.first;
    final delta = node.delta;
    if (delta != null && (delta.isEmpty || delta.toPlainText().isEmpty)) {
      return true;
    }

    return false;
  }

  /// Encodes the [Document] into a JSON structure.
  ///
  Map<String, Object> toJson() {
    return {
      'document': root.toJson(),
    };
  }
}
