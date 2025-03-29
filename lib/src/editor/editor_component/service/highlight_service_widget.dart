import 'dart:developer';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart' hide Overlay, OverlayEntry;
import 'package:appflowy_editor/src/editor/editor_component/service/selection/shared.dart';
import 'package:appflowy_editor/src/service/selection/mobile_selection_gesture.dart';
import 'package:provider/provider.dart';

class HighlightServiceWidget extends StatefulWidget {
  const HighlightServiceWidget({
    super.key,
    this.highlightColor = const Color.fromARGB(53, 215, 205, 17),
    required this.child,
  });

  final Widget child;
  final Color highlightColor;

  @override
  State<HighlightServiceWidget> createState() => _HighlightServiceWidgetState();
}

class _HighlightServiceWidgetState extends State<HighlightServiceWidget> {
  late final EditorState editorState = Provider.of<EditorState>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MobileSelectionGestureDetector(
        onTapUp: _onTripleTapUp,
        child: widget.child,
      ),
    );
  }

  void updateSelection(Selection? selection) {
    if (selection == null) return;
    editorState.updateHighlight(selection);
  }

  Node? getNodeInOffset(Offset offset) {
    final List<Node> sortedNodes = editorState.getVisibleNodes(
      context.read<EditorScrollController>(),
    );

    final node = editorState.getNodeInOffset(
      sortedNodes,
      offset,
      0,
      sortedNodes.length - 1,
    );

    return node;
  }

  void _onTripleTapUp(TapUpDetails details) {
    log('${editorState.scrollableState?.axisDirection}');

    final offset = details.globalPosition;
    final node = getNodeInOffset(offset);
    // select node closest to offset
    final selectable = node?.selectable;
    if (selectable == null) return;

    final selection =
        Selection(start: selectable.start(), end: selectable.end());

    updateSelection(selection);
  }
}
