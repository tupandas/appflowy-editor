import 'package:flutter/painting.dart';

extension ColorExtension2 on Color {
  /// Try to parse the `rgba(red, greed, blue, alpha)`
  /// from the string.
  static Color? tryFromRgbaString(String colorString) {
    final reg = RegExp(r'rgba\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)');
    final match = reg.firstMatch(colorString);
    if (match == null) {
      return null;
    }

    if (match.groupCount < 4) {
      return null;
    }
    final redStr = match.group(1);
    final greenStr = match.group(2);
    final blueStr = match.group(3);
    final alphaStr = match.group(4);

    final red = redStr != null ? int.tryParse(redStr) : null;
    final green = greenStr != null ? int.tryParse(greenStr) : null;
    final blue = blueStr != null ? int.tryParse(blueStr) : null;
    final alpha = alphaStr != null ? int.tryParse(alphaStr) : null;

    if (red == null || green == null || blue == null || alpha == null) {
      return null;
    }

    return Color.fromARGB(alpha, red, green, blue);
  }

  String toRgbaString() {
    final alpha = (a * 255).toInt();
    final red = (r * 255).toInt();
    final green = (g * 255).toInt();
    final blue = (b * 255).toInt();

    return 'rgba($red, $green, $blue, $alpha)';
  }
}
