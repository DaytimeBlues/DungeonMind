import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'catppuccin_colors.dart';

/// App theme using Catppuccin colors for ADHD-friendly "Calm Computing"
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: CatppuccinColors.mauve,
        onPrimary: CatppuccinColors.crust,
        secondary: CatppuccinColors.teal,
        onSecondary: CatppuccinColors.crust,
        tertiary: CatppuccinColors.peach,
        onTertiary: CatppuccinColors.crust,
        error: CatppuccinColors.red,
        onError: CatppuccinColors.crust,
        surface: CatppuccinColors.surface0,
        onSurface: CatppuccinColors.text,
        surfaceContainerHighest: CatppuccinColors.surface1,
        outline: CatppuccinColors.overlay0,
        shadow: CatppuccinColors.crust,
      ),
      scaffoldBackgroundColor: CatppuccinColors.base,
      cardColor: CatppuccinColors.surface0,
      dividerColor: CatppuccinColors.surface1,
      
      // Typography using Inter for readability
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: CatppuccinColors.text),
          displayMedium: TextStyle(color: CatppuccinColors.text),
          displaySmall: TextStyle(color: CatppuccinColors.text),
          headlineLarge: TextStyle(color: CatppuccinColors.text),
          headlineMedium: TextStyle(color: CatppuccinColors.text),
          headlineSmall: TextStyle(color: CatppuccinColors.text),
          titleLarge: TextStyle(color: CatppuccinColors.text),
          titleMedium: TextStyle(color: CatppuccinColors.text),
          titleSmall: TextStyle(color: CatppuccinColors.text),
          bodyLarge: TextStyle(color: CatppuccinColors.text),
          bodyMedium: TextStyle(color: CatppuccinColors.subtext1),
          bodySmall: TextStyle(color: CatppuccinColors.subtext0),
          labelLarge: TextStyle(color: CatppuccinColors.text),
          labelMedium: TextStyle(color: CatppuccinColors.subtext1),
          labelSmall: TextStyle(color: CatppuccinColors.subtext0),
        ),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: CatppuccinColors.mantle,
        foregroundColor: CatppuccinColors.text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CatppuccinColors.text,
        ),
      ),

      // Navigation Rail (Desktop)
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: CatppuccinColors.mantle,
        selectedIconTheme: const IconThemeData(color: CatppuccinColors.mauve),
        unselectedIconTheme: const IconThemeData(color: CatppuccinColors.overlay1),
        selectedLabelTextStyle: GoogleFonts.inter(
          color: CatppuccinColors.mauve,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          color: CatppuccinColors.overlay1,
        ),
        indicatorColor: CatppuccinColors.surface1,
      ),

      // Navigation Bar (Mobile)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CatppuccinColors.mantle,
        indicatorColor: CatppuccinColors.surface1,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: CatppuccinColors.mauve);
          }
          return const IconThemeData(color: CatppuccinColors.overlay1);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              color: CatppuccinColors.mauve,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            );
          }
          return GoogleFonts.inter(
            color: CatppuccinColors.overlay1,
            fontSize: 12,
          );
        }),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: CatppuccinColors.surface0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CatppuccinColors.surface1),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: CatppuccinColors.mauve,
        foregroundColor: CatppuccinColors.crust,
        elevation: 2,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CatppuccinColors.surface0,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatppuccinColors.surface1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatppuccinColors.surface1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatppuccinColors.mauve, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CatppuccinColors.red),
        ),
        labelStyle: const TextStyle(color: CatppuccinColors.subtext0),
        hintStyle: const TextStyle(color: CatppuccinColors.overlay0),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: CatppuccinColors.surface1,
        labelStyle: GoogleFonts.inter(color: CatppuccinColors.text),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // List Tiles
      listTileTheme: const ListTileThemeData(
        iconColor: CatppuccinColors.subtext0,
        textColor: CatppuccinColors.text,
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: CatppuccinColors.surface1,
        contentTextStyle: GoogleFonts.inter(color: CatppuccinColors.text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: CatppuccinColors.surface0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: GoogleFonts.inter(
          color: CatppuccinColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
