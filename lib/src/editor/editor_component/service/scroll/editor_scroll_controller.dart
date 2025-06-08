import 'dart:async';
import 'dart:math';

import 'package:appflowy_editor/appflowy_editor.dart';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

/// This class controls the scroll behavior of the editor.
///
/// It must be provided in the widget tree above the [PageComponent].
///
/// You can use [offsetNotifier] to get the current scroll offset.
/// And, you can use [visibleRangeNotifier] to get the first level visible items.
///
/// If the shrinkWrap is true, the scrollController must not be null
///   and the editor should be wrapped in a SingleChildScrollView.
class EditorScrollController {
  EditorScrollController({required this.editorState}) {
    scrollController = ScrollController();
    observerController = SliverObserverController(controller: scrollController);
    resultMapSubject.listen(_listenItemPositions);
  }

  final BehaviorSubject<Map<BuildContext, ObserveModel>> resultMapSubject = BehaviorSubject.seeded({});

  final EditorState editorState;
  late SliverObserverController observerController;

  final ValueNotifier<double> offsetNotifier = ValueNotifier(0);

  aa(int index) {
    observerController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // provide the first level visible items, for example, if there're texts like this:
  //
  // 1. text1
  // 2. text2 ---
  //  2.1 text21|
  // ...        |
  // 5. text5   | screen
  // ...        |
  // 9. text9 ---
  // 10. text10
  //
  // So the visible range is (2-1, 9-1) = (1, 8), index start from 0.
  final ValueNotifier<(int, int)> visibleRangeNotifier = ValueNotifier((-1, -1));

  // these value is required by SingleChildScrollView
  // notes: don't use them if shrinkWrap is false
  // ------------ start ----------------
  late final ScrollController scrollController;
  // ------------ end ----------------

  // dispose the subscription
  void dispose() {
    scrollController.dispose();
    resultMapSubject.close();
    offsetNotifier.dispose();
    visibleRangeNotifier.dispose();
  }

  Future<void> animateTo({
    required double offset,
    required Duration duration,
    Curve curve = Curves.linear,
  }) async {
    await scrollController.animateTo(
      max(0, offset),
      duration: duration,
      curve: curve,
    );
  }

  void jumpTo({
    required double offset,
  }) async {
    final index = offset.toInt();
    final (start, end) = visibleRangeNotifier.value;

    if (index < start || index > end) {
      observerController.jumpTo(
        index: max(0, index),
        alignment: 0,
      );
    }
  }

  void jumpToTop() => scrollController.jumpTo(0);

  void jumpToBottom() => scrollController.jumpTo(scrollController.position.maxScrollExtent);

  // listen to the visible item positions
  void _listenItemPositions(Map<BuildContext, ObserveModel> resultMap) {
    // notify the listeners
    final model = resultMap.values.firstOrNull;
    if (model != null && model.visible && model is ListViewObserveModel) {
      offsetNotifier.value = model.scrollOffset;

      final displayingChildIndexList = model.displayingChildIndexList;
      if (displayingChildIndexList.isNotEmpty) {
        visibleRangeNotifier.value = (displayingChildIndexList.first, displayingChildIndexList.last);
      } else {
        visibleRangeNotifier.value = (-1, -1);
        throw Exception('The displaying child index list is empty, this should not happen.');
      }
    }
  }
}

extension ValidIndexedValueNotifier on ValueNotifier<(int, int)> {
  /// Returns true if the value is valid.
  bool get isValid => value.$1 >= 0 && value.$2 >= 0 && value.$1 <= value.$2;
}
