import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light()) {
    _initializeWithSystemTheme();
  }

  // Core Brand Colors - Adaptive Orange Professional System
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color primaryOrangeLight = Color(0xFFFF8A5C);
  static const Color primaryOrangeDark = Color(0xFFE55A2B);

  // Background Colors - Optimized for extended mobile viewing
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF2D2D2D);

  // Text Colors - High contrast for mobile clarity
  static const Color textPrimaryLight = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textDark = Color(0xFF212121);
  static const Color textMedium = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);

  // System Status Colors - Platform conventions
  static const Color successGreen = Color(0xFF34C759);
  static const Color errorRed = Color(0xFFFF3B30);

  // Border Colors - Minimal neutral system
  static const Color borderLight = Color(0xFFE5E5E7);
  static const Color borderDark = Color(0xFF38383A);

  // Shadow Colors - Subtle elevation system
  static const Color shadowLight = Color(0x1A000000); // 0.1 opacity
  static const Color shadowDark = Color(0x33000000); // 0.2 opacity

  // Card and elevated surface colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);

  void _initializeWithSystemTheme() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    emit(_buildThemeData(brightness));
  }

  void updateTheme(Brightness brightness) {
    emit(_buildThemeData(brightness));
  }

  void toggleTheme() {
    final isDark = state.brightness == Brightness.dark;
    emit(_buildThemeData(isDark ? Brightness.light : Brightness.dark));
  }

  ThemeData _buildThemeData(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return !isDark ? ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryOrange,
        onPrimary: Colors.black.withAlpha(70),
        primaryContainer: primaryOrangeLight,
        onPrimaryContainer: textPrimaryLight,
        secondary: Colors.white,
        onSecondary: Colors.black,
        secondaryContainer: primaryOrangeLight.withValues(alpha: 0.1),
        onSecondaryContainer: textPrimaryLight,
        tertiary: successGreen,
        onTertiary: Colors.white,
        tertiaryContainer: successGreen.withValues(alpha: 0.1),
        onTertiaryContainer: textPrimaryLight,
        error: errorRed,
        onError: Colors.white,
        surface: surfaceLight,
        onSurface: textPrimaryLight,
        onSurfaceVariant: textSecondary,
        outline: borderLight,
        outlineVariant: borderLight.withValues(alpha: 0.5),
        shadow: shadowLight,
        scrim: Colors.black.withValues(alpha: 0.5),
        inverseSurface: surfaceDark,
        onInverseSurface: textPrimaryDark,
        inversePrimary: primaryOrangeLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: cardLight,
      dividerColor: borderLight,

      // AppBar Theme - Clean professional header
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        foregroundColor: textPrimaryLight,
        elevation: 0,
        shadowColor: shadowLight,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryLight,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryLight,
          size: 24,
        ),
        actionsIconTheme: const IconThemeData(
          color: textPrimaryLight,
          size: 24,
        ),
      ),

      // Card Theme - Subtle elevation system
      cardTheme: CardTheme(
        color: cardLight,
        elevation: 2,
        shadowColor: shadowLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Bottom Navigation Theme - Professional navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundLight,
        selectedItemColor: primaryOrange,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: CircleBorder(),
      ),

      // Button Themes - Consistent interaction patterns
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: shadowLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryOrange,
          side: const BorderSide(color: primaryOrange, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryOrange,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Text Theme - Inter font family for consistency
      textTheme: TextTheme(
        displayLarge: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.ptSans(color: textDark),
        titleLarge: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.ptSans(color: textDark),
        titleSmall: GoogleFonts.ptSans(color: textDark),
        bodyLarge: GoogleFonts.ptSans(color: textDark),
        bodyMedium: GoogleFonts.ptSans(color: textMedium),
        bodySmall: GoogleFonts.ptSans(color: textMedium),
        labelLarge: GoogleFonts.ptSans(color: textDark, fontWeight: FontWeight.w500),
        labelMedium: GoogleFonts.ptSans(color: Colors.black54, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.ptSans(color: textMedium),
      ),

      // Input Decoration Theme - Clean form elements
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceLight,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withAlpha(70), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withAlpha(70), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        labelStyle: GoogleFonts.roboto(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.roboto(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return Colors.grey[300];
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange.withValues(alpha: 0.3);
          }
          return Colors.grey[200];
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return borderLight;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: Colors.black54, width: 2),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return textSecondary;
        }),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryOrange,
        linearTrackColor: borderLight,
        circularTrackColor: borderLight,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryOrange,
        thumbColor: primaryOrange,
        overlayColor: primaryOrange.withValues(alpha: 0.2),
        inactiveTrackColor: borderLight,
        trackHeight: 4,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: primaryOrange,
        unselectedLabelColor: textSecondary,
        indicatorColor: primaryOrange,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: textPrimaryLight.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimaryLight,
        contentTextStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        actionTextColor: primaryOrangeLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ), dialogTheme: DialogThemeData(backgroundColor: cardLight),
    ): ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primaryOrange,
        onPrimary: Colors.white.withAlpha(70),
        primaryContainer: primaryOrangeDark,
        onPrimaryContainer: textPrimaryDark,
        secondary: Colors.black,
        onSecondary: Colors.white,
        secondaryContainer: primaryOrange.withValues(alpha: 0.2),
        onSecondaryContainer: textPrimaryDark,
        tertiary: successGreen,
        onTertiary: Colors.white,
        tertiaryContainer: successGreen.withValues(alpha: 0.2),
        onTertiaryContainer: textPrimaryDark,
        error: errorRed,
        onError: Colors.white,
        surface: surfaceDark,
        onSurface: textPrimaryDark,
        onSurfaceVariant: textSecondary,
        outline: borderDark,
        outlineVariant: borderDark.withValues(alpha: 0.5),
        shadow: shadowDark,
        scrim: Colors.black.withValues(alpha: 0.7),
        inverseSurface: surfaceLight,
        onInverseSurface: textPrimaryLight,
        inversePrimary: primaryOrangeDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: borderDark,

      // AppBar Theme - Clean professional header for dark mode
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: textPrimaryDark,
        elevation: 0,
        shadowColor: shadowDark,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryDark,
        ),
        iconTheme: const IconThemeData(
          color: textPrimaryDark,
          size: 24,
        ),
        actionsIconTheme: const IconThemeData(
          color: textPrimaryDark,
          size: 24,
        ),
      ),

      // Card Theme - Subtle elevation system for dark mode
      cardTheme: CardTheme(
        color: cardDark,
        elevation: 4,
        shadowColor: shadowDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Bottom Navigation Theme - Professional navigation for dark mode
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundDark,
        selectedItemColor: primaryOrange,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: CircleBorder(),
      ),

      // Button Themes - Consistent interaction patterns for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: shadowDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryOrange,
          side: const BorderSide(color: primaryOrange, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryOrange,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Text Theme - Inter font family for consistency
      textTheme: TextTheme(
        displayLarge: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.ptSans(color: Colors.white),
        titleLarge: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.ptSans(color: Colors.white),
        titleSmall: GoogleFonts.ptSans(color: Colors.white),
        bodyLarge: GoogleFonts.ptSans(color: Colors.white),
        bodyMedium: GoogleFonts.ptSans(color: Colors.white70),
        bodySmall: GoogleFonts.ptSans(color: Colors.white70),
        labelLarge: GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w500),
        labelMedium: GoogleFonts.ptSans(color: Colors.white70, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.ptSans(color: Colors.white70),
      ),

      // Input Decoration Theme - Clean form elements for dark mode
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceDark,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withAlpha(70), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withAlpha(70), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        labelStyle: GoogleFonts.roboto(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.roboto(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return Colors.grey[600];
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange.withValues(alpha: 0.3);
          }
          return Colors.grey[800];
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return borderDark;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: Colors.white54, width: 2),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryOrange;
          }
          return textSecondary;
        }),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryOrange,
        linearTrackColor: borderDark,
        circularTrackColor: borderDark,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryOrange,
        thumbColor: primaryOrange,
        overlayColor: primaryOrange.withValues(alpha: 0.2),
        inactiveTrackColor: borderDark,
        trackHeight: 4,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: primaryOrange,
        unselectedLabelColor: textSecondary,
        indicatorColor: primaryOrange,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: textPrimaryDark.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: GoogleFonts.roboto(
          color: backgroundDark,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimaryDark,
        contentTextStyle: GoogleFonts.roboto(
          color: backgroundDark,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        actionTextColor: primaryOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ), dialogTheme: DialogThemeData(backgroundColor: cardDark),
    );
  }
}