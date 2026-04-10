import 'package:flutter/material.dart';

class VoxTheme {
  // Synthwave Palette
  static const Color background = Color(0xFF0D0221); // Deep space purple
  static const Color surface = Color(0xFF190933);    // Darker purple
  static const Color surfaceLight = Color(0xFF261447); 
  
  static const Color neonPink = Color(0xFFFF00D9);
  static const Color neonBlue = Color(0xFF00F0FF);
  static const Color neonPurple = Color(0xFF9D00FF);
  static const Color neonYellow = Color(0xFFFFF200);
  
  static const Color accent = neonBlue;
  static const Color accentLight = Color(0xFF70FAFF);
  static const Color streak = neonPink;
  static const Color success = Color(0xFF00FF94);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0A7C1);
  static const Color divider = Color(0xFF321E59);

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [neonPurple, neonPink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get accentGradient => const LinearGradient(
        colors: [Color(0xFF00F0FF), Color(0xFF0066FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: streak,
          surface: surface,
          onSurface: textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontFamily: 'Courier', // Retro feel
          ),
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 8,
          shadowColor: Colors.black.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: divider, width: 1),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: neonPink,
          foregroundColor: Colors.white,
          elevation: 12,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: surfaceLight,
          selectedColor: accent.withValues(alpha: 0.2),
          secondarySelectedColor: accent.withValues(alpha: 0.2),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        useMaterial3: true,
      );
}