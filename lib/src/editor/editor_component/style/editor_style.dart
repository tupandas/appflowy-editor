import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The style of the editor.
///
/// You can customize the style of the editor by passing the [EditorStyle] to
///  the [AppFlowyEditor].
///
class EditorStyle extends Equatable {
  const EditorStyle({
    required this.padding,
    required this.cursorColor,
    required this.dragHandleColor,
    required this.selectionColor,
    required this.highlightColor,
    required this.highlightAreaColor,
    required this.defaultNodeBackgroundColor,
    required this.textStyleConfiguration,
    required this.textSpanDecorator,
    this.textSpanOverlayBuilder,
    this.magnifierSize = const Size(72, 48),
    this.mobileDragHandleBallSize = const Size(8, 8),
    this.mobileDragHandleWidth = 2.0,
    this.cursorWidth = 2.0,
    this.defaultTextDirection,
    this.enableHapticFeedbackOnAndroid = true,
    this.textScaleFactor = 1.0,
    this.maxWidth,
    this.mobileDragHandleTopExtend,
    this.mobileDragHandleWidthExtend,
    this.mobileDragHandleLeftExtend,
    this.mobileDragHandleHeightExtend,
    this.autoDismissCollapsedHandleDuration = const Duration(seconds: 3),
    this.seperatorPadding,
    this.inBlockPadding,
  });

  // The padding of the editor.
  final EdgeInsets padding;

  // The max width of the editor.
  final double? maxWidth;

  // The cursor color
  final Color cursorColor;

  // The cursor width
  final double cursorWidth;

  // The drag handle color
  // only works on mobile
  // the drag handle color will be ignored on Android.
  final Color dragHandleColor;

  // The selection color
  final Color selectionColor;

  // The highlight color
  final Color highlightColor;

  // The highlight area color
  final Color highlightAreaColor;

  // The background color of the node.
  final Color defaultNodeBackgroundColor;

  // Customize the text style of the editor.
  //
  // All the text-based components will use this configuration to build their
  //   text style.
  //
  // Notes, this configuration is only for the common config of text style and
  //  it maybe override if the text block has its own [BlockComponentConfiguration].
  final TextStyleConfiguration textStyleConfiguration;

  // Customize the built-in or custom text span.
  //
  // For example, you can add a custom text span for the mention text
  //   or override the built-in text span.
  final TextSpanDecoratorForAttribute? textSpanDecorator;

  /// Customize the text span overlay builder.
  final AppFlowyTextSpanOverlayBuilder? textSpanOverlayBuilder;

  final String? defaultTextDirection;

  // The size of the magnifier.
  // Only works on mobile.
  final Size magnifierSize;

  // mobile drag handler size.
  // Only works on mobile.
  final Size mobileDragHandleBallSize;

  /// The extend of the mobile drag handle.
  ///
  /// By default, the hit test area of drag handle is the ball size.
  /// If you want to extend the hit test area, you can set this value.
  ///
  /// For example, if you set this value to 10, the hit test area of drag handle
  /// will be the ball size + 10 * 2.
  final double? mobileDragHandleTopExtend;
  final double? mobileDragHandleLeftExtend;
  final double? mobileDragHandleWidthExtend;
  final double? mobileDragHandleHeightExtend;

  /// The auto-dismiss time of the collapsed handle.
  ///
  /// The collapsed handle will be dismissed when no user interaction is detected.
  ///
  /// Only works on Android.
  final Duration autoDismissCollapsedHandleDuration;

  final double mobileDragHandleWidth;

  // only works on android
  // enable haptic feedback when updating selection by dragging the drag handler
  final bool enableHapticFeedbackOnAndroid;

  final double textScaleFactor;

  final EdgeInsets? seperatorPadding;

  final EdgeInsets? inBlockPadding;

  const EditorStyle.desktop({
    EdgeInsets? padding,
    Color? cursorColor,
    Color? selectionColor,
    Color? highlightColor,
    Color? highlightAreaColor,
    Color? defaultNodeBackgroundColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    this.textSpanOverlayBuilder,
    this.defaultTextDirection,
    this.cursorWidth = 2.0,
    this.textScaleFactor = 1.0,
    this.maxWidth,
    this.seperatorPadding,
    this.inBlockPadding,
  })  : padding = padding ?? const EdgeInsets.symmetric(horizontal: 100),
        cursorColor = cursorColor ?? const Color(0xFF00BCF0),
        selectionColor =
            selectionColor ?? const Color.fromARGB(53, 111, 201, 231),
        highlightColor =
            highlightColor ?? const Color.fromARGB(53, 209, 14, 154),
        highlightAreaColor =
            highlightAreaColor ?? const Color.fromARGB(53, 209, 14, 154),
        defaultNodeBackgroundColor =
            defaultNodeBackgroundColor ?? const Color(0xFFF5F5F5),
        textStyleConfiguration = textStyleConfiguration ??
            const TextStyleConfiguration(
              text: TextStyle(fontSize: 16, color: Colors.black),
            ),
        textSpanDecorator =
            textSpanDecorator ?? defaultTextSpanDecoratorForAttribute,
        magnifierSize = Size.zero,
        mobileDragHandleBallSize = Size.zero,
        mobileDragHandleWidth = 0.0,
        enableHapticFeedbackOnAndroid = false,
        dragHandleColor = Colors.transparent,
        mobileDragHandleTopExtend = null,
        mobileDragHandleWidthExtend = null,
        mobileDragHandleLeftExtend = null,
        mobileDragHandleHeightExtend = null,
        autoDismissCollapsedHandleDuration = const Duration(seconds: 0);

  const EditorStyle.mobile({
    EdgeInsets? padding,
    Color? cursorColor,
    Color? dragHandleColor,
    Color? selectionColor,
    Color? highlightColor,
    Color? highlightAreaColor,
    Color? defaultNodeBackgroundColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    this.textSpanOverlayBuilder,
    this.defaultTextDirection,
    this.magnifierSize = const Size(72, 48),
    this.mobileDragHandleBallSize = const Size(8, 8),
    this.mobileDragHandleWidth = 2.0,
    this.cursorWidth = 2.0,
    this.enableHapticFeedbackOnAndroid = true,
    this.textScaleFactor = 1.0,
    this.maxWidth,
    this.mobileDragHandleTopExtend,
    this.mobileDragHandleWidthExtend,
    this.mobileDragHandleLeftExtend,
    this.mobileDragHandleHeightExtend,
    this.autoDismissCollapsedHandleDuration = const Duration(seconds: 3),
    this.seperatorPadding,
    this.inBlockPadding,
  })  : padding = padding ?? const EdgeInsets.symmetric(horizontal: 20),
        cursorColor = cursorColor ?? const Color(0xFF00BCF0),
        dragHandleColor = dragHandleColor ?? const Color(0xFF00BCF0),
        selectionColor =
            selectionColor ?? const Color.fromARGB(53, 111, 201, 231),
        highlightColor =
            highlightColor ?? const Color.fromARGB(53, 28, 164, 35),
        highlightAreaColor =
            highlightAreaColor ?? const Color.fromARGB(53, 28, 164, 35),
        defaultNodeBackgroundColor =
            defaultNodeBackgroundColor ?? const Color(0xFFF5F5F5),
        textStyleConfiguration = textStyleConfiguration ??
            const TextStyleConfiguration(
              text: TextStyle(fontSize: 16, color: Colors.black),
            ),
        textSpanDecorator =
            textSpanDecorator ?? mobileTextSpanDecoratorForAttribute;

  EditorStyle copyWith({
    EdgeInsets? padding,
    Color? cursorColor,
    Color? dragHandleColor,
    Color? selectionColor,
    Color? highlightColor,
    Color? highlightAreaColor,
    Color? defaultNodeBackgroundColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    AppFlowyTextSpanOverlayBuilder? textSpanOverlayBuilder,
    String? defaultTextDirection,
    Size? magnifierSize,
    Size? mobileDragHandleBallSize,
    double? mobileDragHandleWidth,
    bool? enableHapticFeedbackOnAndroid,
    double? cursorWidth,
    double? textScaleFactor,
    double? maxWidth,
    double? mobileDragHandleTopExtend,
    double? mobileDragHandleWidthExtend,
    double? mobileDragHandleLeftExtend,
    double? mobileDragHandleHeightExtend,
    Duration? autoDismissCollapsedHandleDuration,
    EdgeInsets? seperatorPadding,
    EdgeInsets? inBlockPadding,
  }) {
    return EditorStyle(
      padding: padding ?? this.padding,
      cursorColor: cursorColor ?? this.cursorColor,
      dragHandleColor: dragHandleColor ?? this.dragHandleColor,
      selectionColor: selectionColor ?? this.selectionColor,
      highlightColor: highlightColor ?? this.highlightColor,
      highlightAreaColor: highlightAreaColor ?? this.highlightAreaColor,
      defaultNodeBackgroundColor:
          defaultNodeBackgroundColor ?? this.defaultNodeBackgroundColor,
      textStyleConfiguration:
          textStyleConfiguration ?? this.textStyleConfiguration,
      textSpanDecorator: textSpanDecorator ?? this.textSpanDecorator,
      textSpanOverlayBuilder:
          textSpanOverlayBuilder ?? this.textSpanOverlayBuilder,
      defaultTextDirection: defaultTextDirection,
      magnifierSize: magnifierSize ?? this.magnifierSize,
      mobileDragHandleBallSize:
          mobileDragHandleBallSize ?? this.mobileDragHandleBallSize,
      mobileDragHandleWidth:
          mobileDragHandleWidth ?? this.mobileDragHandleWidth,
      enableHapticFeedbackOnAndroid:
          enableHapticFeedbackOnAndroid ?? this.enableHapticFeedbackOnAndroid,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxWidth: maxWidth ?? this.maxWidth,
      mobileDragHandleTopExtend:
          mobileDragHandleTopExtend ?? this.mobileDragHandleTopExtend,
      mobileDragHandleWidthExtend:
          mobileDragHandleWidthExtend ?? this.mobileDragHandleWidthExtend,
      mobileDragHandleLeftExtend:
          mobileDragHandleLeftExtend ?? this.mobileDragHandleLeftExtend,
      mobileDragHandleHeightExtend:
          mobileDragHandleHeightExtend ?? this.mobileDragHandleHeightExtend,
      autoDismissCollapsedHandleDuration: autoDismissCollapsedHandleDuration ??
          this.autoDismissCollapsedHandleDuration,
      seperatorPadding: seperatorPadding ?? this.seperatorPadding,
      inBlockPadding: inBlockPadding ?? this.inBlockPadding,
    );
  }

  @override
  List<Object?> get props => [
        padding,
        cursorColor,
        dragHandleColor,
        selectionColor,
        highlightColor,
        highlightAreaColor,
        defaultNodeBackgroundColor,
        textStyleConfiguration,
        textSpanDecorator,
        textSpanOverlayBuilder,
        magnifierSize,
        mobileDragHandleBallSize,
        mobileDragHandleWidth,
        enableHapticFeedbackOnAndroid,
        cursorWidth,
        textScaleFactor,
        maxWidth,
        mobileDragHandleTopExtend,
        mobileDragHandleWidthExtend,
        mobileDragHandleLeftExtend,
        mobileDragHandleHeightExtend,
        autoDismissCollapsedHandleDuration,
        seperatorPadding,
        inBlockPadding,
      ];
}
