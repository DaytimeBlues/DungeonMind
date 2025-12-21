import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _VoidColors {
  static const Color voidBlack = Color(0xFF050505);
  static const Color deepSlate = Color(0xFF0A0A0F); // Slightly lighter void for cards
  static const Color starlight = Color(0xFFE0E0E0);
  static const Color starlightDim = Color(0xFFAAAAAA);
  static const Color arcanePurple = Color(0xFF7B2CDA);
  static const Color runeCyan = Color(0xFF00E5FF);
  static const Color bloodRed = Color(0xFFCF6679); // Muted red for errors
  static const Color border = Color(0xFF1E1E24);
}

/// App theme implementing the "Void-Bound Grimoire" aesthetic
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.ebGaramondTextTheme(ThemeData.dark().textTheme);
    final displayTextTheme = GoogleFonts.cinzelDecorativeTextTheme(baseTextTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _VoidColors.voidBlack,
      cardColor: _VoidColors.deepSlate,
      dividerColor: _VoidColors.border,
      
      colorScheme: const ColorScheme.dark(
        primary: _VoidColors.arcanePurple,
        onPrimary: Colors.white,
        secondary: _VoidColors.runeCyan,
        onSecondary: Colors.black, // High contrast on cyan
        surface: _VoidColors.deepSlate,
        onSurface: _VoidColors.starlight,
        error: _VoidColors.bloodRed,
        outline: _VoidColors.border,
      ),

      // Typography
      textTheme: baseTextTheme.copyWith(
        displayLarge: displayTextTheme.displayLarge?.copyWith(color: _VoidColors.starlight),
        displayMedium: displayTextTheme.displayMedium?.copyWith(color: _VoidColors.starlight),
        displaySmall: displayTextTheme.displaySmall?.copyWith(color: _VoidColors.starlight),
        headlineLarge: displayTextTheme.headlineLarge?.copyWith(color: _VoidColors.starlight),
        headlineMedium: displayTextTheme.headlineMedium?.copyWith(color: _VoidColors.starlight),
        headlineSmall: displayTextTheme.headlineSmall?.copyWith(color: _VoidColors.starlight),
        titleLarge: displayTextTheme.titleLarge?.copyWith(color: _VoidColors.runeCyan, fontWeight: FontWeight.bold),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: _VoidColors.starlight, fontSize: 18),
        titleSmall: baseTextTheme.titleSmall?.copyWith(color: _VoidColors.starlightDim, letterSpacing: 1.0),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: _VoidColors.starlight, fontSize: 16),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: _VoidColors.starlightDim),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: _VoidColors.voidBlack,
        foregroundColor: _VoidColors.starlight,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: displayTextTheme.headlineSmall?.copyWith(
          color: _VoidColors.starlight,
          letterSpacing: 1.5,
        ),
        iconTheme: const IconThemeData(color: _VoidColors.starlightDim),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: _VoidColors.deepSlate,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Brutalist sharp corners? Or slight round?
          // Let's go with slight round 4px for "refined" look, not full pill
          side: const BorderSide(color: _VoidColors.border),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _VoidColors.deepSlate,
        labelStyle: TextStyle(color: _VoidColors.starlightDim, fontFamily: GoogleFonts.ebGaramond().fontFamily),
        hintStyle: TextStyle(color: _VoidColors.starlightDim.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: _VoidColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: _VoidColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: _VoidColors.arcanePurple, width: 1.5),
        ),
      ),

      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _VoidColors.arcanePurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))), // Diamond-ish squash
      ),
      
      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: _VoidColors.deepSlate,
        labelStyle: baseTextTheme.bodyMedium?.copyWith(color: _VoidColors.starlight),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: _VoidColors.border),
        ),
        selectedColor: _VoidColors.arcanePurple.withOpacity(0.2),
      ),
      
      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: _VoidColors.deepSlate,
        titleTextStyle: displayTextTheme.headlineSmall?.copyWith(color: _VoidColors.starlight),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: _VoidColors.arcanePurple, width: 0.5),
        ),
      ),
    );
  }
}
