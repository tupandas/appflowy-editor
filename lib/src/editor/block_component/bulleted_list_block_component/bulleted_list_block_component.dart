import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/block_component/base_component/block_icon_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BulletedListBlockKeys {
  const BulletedListBlockKeys._();

  static const String type = 'bulleted_list';

  static const String delta = blockComponentDelta;

  static const String backgroundColor = blockComponentBackgroundColor;

  static const String textDirection = blockComponentTextDirection;
}

Node bulletedListNode({
  String? text,
  Delta? delta,
  String? textDirection,
  Attributes? attributes,
  Iterable<Node>? children,
}) {
  return Node(
    type: BulletedListBlockKeys.type,
    attributes: {
      BulletedListBlockKeys.delta:
          (delta ?? (Delta()..insert(text ?? ''))).toJson(),
      if (attributes != null) ...attributes,
      if (textDirection != null)
        BulletedListBlockKeys.textDirection: textDirection,
    },
    children: children ?? [],
  );
}

class BulletedListBlockComponentBuilder extends BlockComponentBuilder {
  BulletedListBlockComponentBuilder({
    super.configuration,
    this.iconBuilder,
  });

  final BlockIconBuilder? iconBuilder;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return BulletedListBlockComponentWidget(
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

class BulletedListBlockComponentWidget extends BlockComponentStatefulWidget {
  const BulletedListBlockComponentWidget({
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
  State<BulletedListBlockComponentWidget> createState() =>
      _BulletedListBlockComponentWidgetState();
}

class _BulletedListBlockComponentWidgetState
    extends State<BulletedListBlockComponentWidget>
    with
        SelectableMixin,
        DefaultSelectableMixin,
        BlockComponentConfigurable,
        BlockComponentBackgroundColorMixin,
        NestedBlockComponentStatefulWidgetMixin,
        BlockComponentTextDirectionMixin,
        BlockComponentAlignMixin {
  @override
  final forwardKey = GlobalKey(debugLabel: 'flowy_rich_text');

  @override
  GlobalKey<State<StatefulWidget>> get containerKey => widget.node.key;

  @override
  GlobalKey<State<StatefulWidget>> blockComponentKey = GlobalKey(
    debugLabel: BulletedListBlockKeys.type,
  );

  @override
  BlockComponentConfiguration get configuration => widget.configuration;

  @override
  Node get node => widget.node;

  @override
  Widget buildComponent(
    BuildContext context, {
    bool withBackgroundColor = true,
  }) {
    final textDirection = calculateTextDirection(
      layoutDirection: Directionality.maybeOf(context),
    );

    Widget child = Container(
      width: double.infinity,
      alignment: alignment,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        textDirection: textDirection,
        children: [
          widget.iconBuilder != null
              ? widget.iconBuilder!(context, node)
              : _BulletedListIcon(
                  node: widget.node,
                  textStyle: textStyleWithTextSpan(),
                ),
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
    );

    child = Container(
      margin: editorState.editorStyle.seperatorPadding ??
          const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: (withBackgroundColor
            ? backgroundColor ??
                editorState.editorStyle.defaultNodeBackgroundColor
            : null),
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
      remoteSelection: editorState.remoteSelections,
      highlight: editorState.highlightNotifier,
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

class _BulletedListIcon extends StatelessWidget {
  const _BulletedListIcon({
    required this.node,
    required this.textStyle,
  });

  final Node node;
  final TextStyle textStyle;

  static final bulletedListIcons = [
    '●',
    '◯',
    '□',
  ];

  int get level {
    var level = 0;
    var parent = node.parent;
    while (parent != null) {
      if (parent.type == 'bulleted_list') {
        level++;
      }
      parent = parent.parent;
    }
    return level;
  }

  String get icon => bulletedListIcons[level % bulletedListIcons.length];

  @override
  Widget build(BuildContext context) {
    final textScaleFactor =
        context.read<EditorState>().editorStyle.textScaleFactor;

    return ConstrainedBox(
      constraints:
          const BoxConstraints(minWidth: 26, minHeight: 22) * textScaleFactor,
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Center(
          child: Text(
            icon,
            style: textStyle,
            textScaler: TextScaler.linear(0.5 * textScaleFactor),
          ),
        ),
      ),
    );
  }
}
