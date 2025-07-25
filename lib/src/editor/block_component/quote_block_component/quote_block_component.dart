import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/block_component/base_component/block_icon_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteBlockKeys {
  const QuoteBlockKeys._();

  static const String type = 'quote';

  static const String delta = blockComponentDelta;

  static const String backgroundColor = blockComponentBackgroundColor;

  static const String textDirection = blockComponentTextDirection;
}

Node quoteNode({
  Delta? delta,
  String? textDirection,
  Attributes? attributes,
  Iterable<Node>? children,
}) {
  attributes ??= {'delta': (delta ?? Delta()).toJson()};
  return Node(
    type: QuoteBlockKeys.type,
    attributes: {
      ...attributes,
      if (textDirection != null) QuoteBlockKeys.textDirection: textDirection,
    },
    children: children ?? [],
  );
}

class QuoteBlockComponentBuilder extends BlockComponentBuilder {
  QuoteBlockComponentBuilder({
    super.configuration,
    this.iconBuilder,
  });

  final BlockIconBuilder? iconBuilder;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return QuoteBlockComponentWidget(
      key: node.key,
      node: node,
      configuration: configuration,
      iconBuilder: iconBuilder,
      showActions: showActions(node),
      actionBuilder: (context, state) => actionBuilder(
        blockComponentContext,
        state,
      ),
      actionTrailingBuilder: (context, state) => actionTrailingBuilder(
        blockComponentContext,
        state,
      ),
    );
  }

  @override
  BlockComponentValidate get validate => (node) => node.delta != null;
}

class QuoteBlockComponentWidget extends BlockComponentStatefulWidget {
  const QuoteBlockComponentWidget({
    super.key,
    required super.node,
    super.showActions,
    super.actionBuilder,
    super.actionTrailingBuilder,
    super.configuration = const BlockComponentConfiguration(),
    this.iconBuilder,
  });

  final BlockIconBuilder? iconBuilder;

  @override
  State<QuoteBlockComponentWidget> createState() =>
      _QuoteBlockComponentWidgetState();
}

class _QuoteBlockComponentWidgetState extends State<QuoteBlockComponentWidget>
    with
        SelectableMixin,
        DefaultSelectableMixin,
        BlockComponentConfigurable,
        BlockComponentBackgroundColorMixin,
        BlockComponentTextDirectionMixin,
        BlockComponentAlignMixin {
  @override
  final forwardKey = GlobalKey(debugLabel: 'flowy_rich_text');

  @override
  GlobalKey<State<StatefulWidget>> get containerKey => widget.node.key;

  @override
  GlobalKey<State<StatefulWidget>> blockComponentKey = GlobalKey(
    debugLabel: QuoteBlockKeys.type,
  );

  @override
  BlockComponentConfiguration get configuration => widget.configuration;

  @override
  Node get node => widget.node;

  @override
  late final editorState = Provider.of<EditorState>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final textDirection = calculateTextDirection(
      layoutDirection: Directionality.maybeOf(context),
    );

    Widget child = Container(
      width: double.infinity,
      alignment: alignment,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          textDirection: textDirection,
          children: [
            widget.iconBuilder != null
                ? widget.iconBuilder!(context, node)
                : const _QuoteIcon(),
            Flexible(
              child: AppFlowyRichText(
                key: forwardKey,
                delegate: this,
                node: widget.node,
                editorState: editorState,
                textAlign: alignment?.toTextAlign ?? textAlign,
                placeholderText: placeholderText,
                textSpanDecorator: (textSpan) => textSpan.updateTextStyle(
                  textStyleWithTextSpan(textSpan: textSpan),
                ),
                placeholderTextSpanDecorator: (textSpan) =>
                    textSpan.updateTextStyle(
                  placeholderTextStyleWithTextSpan(textSpan: textSpan),
                ),
                textDirection: textDirection,
                cursorColor: editorState.editorStyle.cursorColor,
                selectionColor: editorState.editorStyle.selectionColor,
                highlightColor: editorState.editorStyle.highlightColor,
                highlightAreaColor: editorState.editorStyle.highlightAreaColor,
                cursorWidth: editorState.editorStyle.cursorWidth,
              ),
            ),
          ],
        ),
      ),
    );

    child = Container(
      margin: editorState.editorStyle.seperatorPadding ??
          const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ??
            editorState.editorStyle.defaultNodeBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        key: blockComponentKey,
        padding: editorState.editorStyle.inBlockPadding ??
            padding.add(const EdgeInsets.all(8)),
        child: child,
      ),
    );

    child = BlockSelectionContainer(
      node: node,
      delegate: this,
      listenable: editorState.selectionNotifier,
      highlight: editorState.highlightNotifier,
      remoteSelection: editorState.remoteSelections,
      blockColor: editorState.editorStyle.selectionColor,
      highlightColor: editorState.editorStyle.highlightColor,
      highlightAreaColor: editorState.editorStyle.highlightAreaColor,
      supportTypes: const [
        BlockSelectionType.block,
      ],
      child: child,
    );

    if (widget.showActions && widget.actionBuilder != null) {
      child = BlockComponentActionWrapper(
        node: node,
        actionBuilder: widget.actionBuilder!,
        actionTrailingBuilder: widget.actionTrailingBuilder,
        child: child,
      );
    }

    return child;
  }
}

class _QuoteIcon extends StatelessWidget {
  const _QuoteIcon();

  @override
  Widget build(BuildContext context) {
    final textScaleFactor =
        context.read<EditorState>().editorStyle.textScaleFactor;
    return Container(
      alignment: Alignment.center,
      constraints:
          const BoxConstraints(minWidth: 26, minHeight: 22) * textScaleFactor,
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        width: 4 * textScaleFactor,
        color: '#00BCF0'.tryToColor(),
      ),
    );
  }
}
