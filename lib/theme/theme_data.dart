import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColor {
  final Color primary;
  final Color contrast;
  final Color shade;
  final Color tint;

  ThemeColor({
    required this.primary,
    required this.contrast,
    required this.shade,
    required this.tint,
  });
}

final base = ThemeData.light();

ThemeColor primaryColor = ThemeColor(
  primary: const Color(0xFF0F5F72),
  contrast: Colors.white,
  shade: const Color(0xFF02959b),
  tint: const Color(0xFF02959b),
);

ThemeColor secondaryColor = ThemeColor(
  primary: const Color(0xFF02959B),
  contrast: const Color(0xFF02959B),
  shade: const Color(0xFF02959B),
  tint: const Color(0xFF02959B),
);

ThemeColor tertiaryColor = ThemeColor(
  primary: const Color(0xFF42F0C1),
  contrast: Colors.white,
  shade: const Color(0xFF4854e0),
  tint: const Color(0xFF6370ff),
);

ThemeColor successColor = ThemeColor(
  primary: const Color(0xFF04D361),
  contrast: Colors.white,
  shade: const Color(0xFF28ba62),
  tint: const Color(0xFF42d77d),
);

ThemeColor warningColor = ThemeColor(
  primary: const Color(0xFFffc409),
  contrast: Colors.black,
  shade: const Color(0xFFe0ac08),
  tint: const Color(0xFFffca22),
);

ThemeColor dangerColor = ThemeColor(
  primary: const Color(0xFFFF5343),
  contrast: Colors.white,
  shade: const Color(0xFFcf3c4f),
  tint: const Color(0xFFed576b),
);

ThemeData get appThemeData => ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor.primary,
      canvasColor: primaryColor.contrast,
      fontFamily: GoogleFonts.roboto().fontFamily,
      backgroundColor: secondaryColor.primary,
      scaffoldBackgroundColor: Colors.grey.shade300,
      textTheme: TextTheme(
        headline1: const TextStyle(fontSize: 16.0),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: GoogleFonts.roboto().fontFamily),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // Primary Color
        primary: primaryColor.primary,
        onPrimary: primaryColor.contrast,
        // Secondary Color
        secondary: secondaryColor.primary,
        onSecondary: secondaryColor.contrast,
        // Tertiary Color
        tertiary: tertiaryColor.primary,
        onTertiary: tertiaryColor.contrast,
        // Error Color
        error: dangerColor.primary,
        onError: dangerColor.contrast,

        background: secondaryColor.primary,

        inversePrimary: warningColor.primary,
      ),
      cardColor: Color.lerp(Colors.white, Colors.white, 0.2),
      cardTheme: base.cardTheme.copyWith(
        color: Colors.white,
        margin: const EdgeInsets.all(10.0),
        elevation: 0.0,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
            side: const BorderSide(color: Colors.white24, width: 1)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor.primary,
        titleTextStyle: TextStyle(
            color: primaryColor.contrast,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor.primary,
        textTheme: ButtonTextTheme.accent,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: secondaryColor.primary,
            side: BorderSide(width: 2, color: secondaryColor.primary),
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: secondaryColor.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          textStyle: TextStyle(color: secondaryColor.primary, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: tertiaryColor.primary),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: tertiaryColor.primary,
        inactiveTrackColor: secondaryColor.primary,
        activeTrackColor: tertiaryColor.primary,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: secondaryColor.primary,
      ),
    );

ThemeData get appDarkThemeData => ThemeData(
      toggleableActiveColor: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: primaryColor.primary,
      canvasColor: primaryColor.contrast,
      fontFamily: GoogleFonts.roboto().fontFamily,
      backgroundColor: secondaryColor.primary,
      scaffoldBackgroundColor: Colors.black54,
      textTheme: TextTheme(
        headline1: const TextStyle(fontSize: 16.0),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: GoogleFonts.roboto().fontFamily),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          // Primary Color
          primary: primaryColor.primary,
          onPrimary: primaryColor.contrast,
          // Secondary Color
          secondary: secondaryColor.primary,
          onSecondary: secondaryColor.contrast,
          // Tertiary Color
          tertiary: tertiaryColor.primary,
          onTertiary: tertiaryColor.contrast,
          // Error Color
          error: dangerColor.primary,
          onError: dangerColor.contrast,
          background: secondaryColor.primary,
          inversePrimary: warningColor.primary,
          brightness: Brightness.dark),
      cardColor: Color.lerp(Colors.white, Colors.white, 0.2),
      cardTheme: base.cardTheme.copyWith(
        color: Colors.white,
        margin: const EdgeInsets.all(10.0),
        elevation: 0.0,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
            side: const BorderSide(color: Colors.white24, width: 1)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor.primary,
        titleTextStyle: TextStyle(
            color: primaryColor.contrast,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor.primary,
        textTheme: ButtonTextTheme.accent,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: secondaryColor.primary,
            side: BorderSide(width: 2, color: secondaryColor.primary),
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: secondaryColor.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          textStyle: TextStyle(color: secondaryColor.primary, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: tertiaryColor.primary),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: tertiaryColor.primary,
        inactiveTrackColor: secondaryColor.primary,
        activeTrackColor: tertiaryColor.primary,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: secondaryColor.primary,
      ),
    );
