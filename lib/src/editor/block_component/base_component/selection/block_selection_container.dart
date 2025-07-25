import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/src/editor/block_component/base_component/selection/block_highlight_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlockSelectionContainer extends StatelessWidget {
  const BlockSelectionContainer({
    super.key,
    required this.node,
    required this.delegate,
    required this.listenable,
    required this.highlight,
    this.remoteSelection,
    this.cursorColor = Colors.black,
    this.selectionColor = Colors.blue,
    this.highlightColor = Colors.blue,
    required this.highlightAreaColor,
    this.blockColor = Colors.blue,
    this.supportTypes = const [
      BlockSelectionType.cursor,
      BlockSelectionType.selection,
    ],
    this.selectionAboveBlock = false,
    required this.child,
  });

  // get the cursor rect, selection rects or block rect from the delegate
  final SelectableMixin delegate;

  // get the selection from the listenable
  final ValueListenable<Selection?> listenable;

  // get the highlight from the editor state
  final ValueListenable<Selection?> highlight;

  // remote selection
  final ValueListenable<List<RemoteSelection>>? remoteSelection;

  // the color of the cursor
  final Color cursorColor;

  // the color of the selection
  final Color selectionColor;

  // the color of the highlight
  final Color highlightColor;

  // the color of the highlight area
  final Color highlightAreaColor;

  // the color of the background of the block
  final Color blockColor;

  // the node of the block
  final Node node;

  final List<BlockSelectionType> supportTypes;

  // the selection area should above the block component
  final bool selectionAboveBlock;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final blockSelectionArea = BlockSelectionArea(
      node: node,
      delegate: delegate,
      listenable: listenable,
      cursorColor: cursorColor,
      selectionColor: selectionColor,
      blockColor: blockColor,
      supportTypes: supportTypes
          .where((element) => element != BlockSelectionType.cursor)
          .toList(),
    );

    final blockHighlightArea = BlockHighlightArea(
      node: node,
      delegate: delegate,
      listenable: highlight,
      highlightColor: highlightColor,
      highlightAreaColor: highlightAreaColor,
      cursorColor: cursorColor,
      blockColor: blockColor,
      supportTypes: supportTypes
          .where((element) => element != BlockSelectionType.cursor)
          .toList(),
    );

    return Stack(
      clipBehavior: Clip.none,
      // In RTL mode, if the alignment is topStart,
      //  the selection will be on the opposite side of the block component.
      alignment: Directionality.of(context) == TextDirection.ltr
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.topEnd,

      children: [
        if (remoteSelection != null)
          RemoteBlockSelectionsArea(
            node: node,
            delegate: delegate,
            remoteSelections: remoteSelection!,
            supportTypes: supportTypes
                .where(
                  (element) => element != BlockSelectionType.cursor,
                )
                .toList(),
          ),
        // block selection or selection area
        if (!selectionAboveBlock) blockSelectionArea,
        blockHighlightArea,

        child,

        // block selection or selection area
        if (selectionAboveBlock) blockSelectionArea,

        // cursor
        // remote cursor
        if (supportTypes.contains(BlockSelectionType.cursor) &&
            remoteSelection != null)
          RemoteBlockSelectionsArea(
            node: node,
            delegate: delegate,
            remoteSelections: remoteSelection!,
            supportTypes: const [BlockSelectionType.cursor],
          ),
        // local cursor
        if (supportTypes.contains(BlockSelectionType.cursor))
          BlockSelectionArea(
            node: node,
            delegate: delegate,
            listenable: listenable,
            cursorColor: cursorColor,
            selectionColor: selectionColor,
            blockColor: blockColor,
            supportTypes: const [BlockSelectionType.cursor],
          ),
      ],
    );
  }
}
