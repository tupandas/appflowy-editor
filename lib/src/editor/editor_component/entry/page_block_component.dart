import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/block_component/base_component/widget/ignore_parent_gesture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class PageBlockKeys {
  static const String type = 'page';
}

Node pageNode({
  required Iterable<Node> children,
  Attributes attributes = const {},
}) {
  return Node(
    type: PageBlockKeys.type,
    children: children,
    attributes: attributes,
  );
}

class PageBlockComponentBuilder extends BlockComponentBuilder {
  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    return PageBlockComponent(
      key: blockComponentContext.node.key,
      node: blockComponentContext.node,
      header: blockComponentContext.header,
      footer: blockComponentContext.footer,
    );
  }
}

class PageBlockComponent extends BlockComponentStatelessWidget {
  const PageBlockComponent({
    super.key,
    required super.node,
    super.showActions,
    super.actionBuilder,
    super.actionTrailingBuilder,
    super.configuration = const BlockComponentConfiguration(),
    this.header,
    this.footer,
  });

  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    BuildContext? _sliverListContext;
    final editorState = context.read<EditorState>();
    final editorScrollController = context.read<EditorScrollController>();
    final observerController = editorScrollController.observerController;
    final scrollController = editorScrollController.scrollController;
    final items = node.children;

    // int extentCount = 0;
    // if (header != null) extentCount++;
    // if (footer != null) extentCount++;

    return SliverViewObserver(
      controller: observerController,
      sliverContexts: () => [if (_sliverListContext != null) _sliverListContext!],
      onObserveAll: (resultMap) => editorScrollController.resultMapSubject.add(resultMap),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          if (header != null)
            SliverToBoxAdapter(
              child: IgnoreEditorSelectionGesture(
                child: header!,
              ),
            ),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              _sliverListContext ??= context;

              editorState.updateAutoScroller(Scrollable.of(context));

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: editorState.editorStyle.maxWidth ?? double.infinity,
                  ),
                  child: Padding(
                    padding: editorState.editorStyle.padding,
                    child: editorState.renderer.build(
                      context,
                      items[index],
                    ),
                  ),
                ),
              );
            },
          ),
          if (footer != null)
            SliverToBoxAdapter(
              child: IgnoreEditorSelectionGesture(
                child: footer!,
              ),
            ),
        ],
      ),
    );
  }
}
