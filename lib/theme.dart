import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme get textTheme => GoogleFonts.publicSansTextTheme();

const Color isaacPrimary = Color(0xff0033ff);

enum GlobalTheme {
  light,
  dark,
  redLight,
  darkGreen;

  Color get primary {
    switch (this) {
      case GlobalTheme.light:
        return isaacPrimary;
      case GlobalTheme.dark:
        return Color(0xff102b97);
      case GlobalTheme.redLight:
        return Color(0xffe68d97);
      case GlobalTheme.darkGreen:
        return Color(0xff0a731b);
    }
  }

  bool get isDark {
    switch (this) {
      case light:
      case redLight:
        return false;
      default:
        return true;
    }
  }

  Brightness get brightness => isDark ? Brightness.dark : Brightness.light;
}

ValueNotifier<GlobalTheme> useDark = ValueNotifier(GlobalTheme.light);

GlobalTheme get currentTheme => useDark.value;

ColorScheme get colorScheme {
  return ColorScheme.fromSeed(
    seedColor: currentTheme.primary,
    brightness: currentTheme.brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.content,
  );
}

ThemeData get theme =>
    ThemeData.from(colorScheme: colorScheme, textTheme: textTheme);
