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

class PageBlockComponent extends BlockComponentStatefulWidget {
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
  State<PageBlockComponent> createState() => _PageBlockComponentState();
}

class _PageBlockComponentState extends State<PageBlockComponent> {
  BuildContext? _sliverListContext;
  late final editorState = context.read<EditorState>();
  late final editorScrollController = context.read<EditorScrollController>();
  late final observerController = editorScrollController.observerController;
  late final scrollController = editorScrollController.scrollController;
  late final items = widget.node.children;

  @override
  Widget build(BuildContext context) {
    return SliverViewObserver(
      controller: observerController,
      sliverContexts: () => [if (_sliverListContext != null) _sliverListContext!],
      onObserveAll: (resultMap) => editorScrollController.resultMapSubject.add(resultMap),
      triggerOnObserveType: ObserverTriggerOnObserveType.directly,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          if (widget.header != null)
            SliverToBoxAdapter(
              child: IgnoreEditorSelectionGesture(
                child: widget.header!,
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
          if (widget.footer != null)
            SliverToBoxAdapter(
              child: IgnoreEditorSelectionGesture(
                child: widget.footer!,
              ),
            ),
        ],
      ),
    );
  }
}
