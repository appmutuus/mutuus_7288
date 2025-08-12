import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
/// Implements Contemporary Spatial Minimalism with Modern Blue Palette
/// inspired by Real Focus app design for a mobile marketplace application.
class AppTheme {
  AppTheme._();

  // Modern Blue Palette - Core Colors (inspired by Real Focus)
  static const Color primaryLight = Color(0xFF1E3A8A); // Deep blue primary
  static const Color secondaryLight = Color(0xFF64748B); // Professional gray
  static const Color successLight = Color(0xFF059669); // Completion feedback
  static const Color warningLight = Color(0xFFD97706); // Deadline alerts
  static const Color errorLight = Color(0xFFDC2626); // Form validation
  static const Color surfaceLight =
      Color(0xFFF1F5F9); // Light blue-tinted background
  static const Color cardLight = Color(0xFFFFFFFF); // Content containers
  static const Color borderLight = Color(0xFFCBD5E1); // Blue-tinted borders
  static const Color textPrimaryLight = Color(0xFF0F172A); // High contrast
  static const Color textSecondaryLight = Color(0xFF475569); // Supporting info
  static const Color accentLight = Color(0xFF3B82F6); // Bright blue accent

  // Dark theme variants with Real Focus inspired colors
  static const Color primaryDark =
      Color(0xFF60A5FA); // Lighter blue for dark mode
  static const Color secondaryDark = Color(0xFF94A3B8); // Light gray
  static const Color successDark = Color(0xFF10B981); // Success green
  static const Color warningDark = Color(0xFFF59E0B); // Warning orange
  static const Color errorDark = Color(0xFFEF4444); // Error red
  static const Color surfaceDark =
      Color(0xFF0F172A); // Real Focus dark background
  static const Color cardDark = Color(0xFF1E293B); // Real Focus card background
  static const Color borderDark = Color(0xFF334155); // Dark borders
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Light text
  static const Color textSecondaryDark = Color(0xFFCBD5E1); // Secondary text
  static const Color accentDark = Color(0xFF93C5FD); // Light blue accent

  // Additional semantic colors
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF0F172A);
  static const Color onCardLight = Color(0xFF0F172A);

  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onCardDark = Color(0xFFF8FAFC);

  // Shadow and divider colors with blue tints
  static const Color shadowLight = Color(0x0D1E3A8A); // Blue-tinted shadow
  static const Color shadowDark = Color(0x0D60A5FA); // Light blue shadow
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  // Gradient colors for modern effects
  static const Color gradientStartLight = Color(0xFF1E3A8A);
  static const Color gradientEndLight = Color(0xFF3B82F6);
  static const Color gradientStartDark = Color(0xFF1E293B);
  static const Color gradientEndDark = Color(0xFF3B82F6);

  /// Light theme implementing Contemporary Spatial Minimalism with Blue Palette
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: onPrimaryLight,
          primaryContainer: primaryLight.withAlpha(26),
          onPrimaryContainer: primaryLight,
          secondary: secondaryLight,
          onSecondary: onSecondaryLight,
          secondaryContainer: secondaryLight.withAlpha(26),
          onSecondaryContainer: secondaryLight,
          tertiary: accentLight,
          onTertiary: onPrimaryLight,
          tertiaryContainer: accentLight.withAlpha(26),
          onTertiaryContainer: accentLight,
          error: errorLight,
          onError: onPrimaryLight,
          errorContainer: errorLight.withAlpha(26),
          onErrorContainer: errorLight,
          surface: surfaceLight,
          onSurface: onSurfaceLight,
          onSurfaceVariant: textSecondaryLight,
          outline: borderLight,
          outlineVariant: borderLight.withAlpha(128),
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: surfaceDark,
          onInverseSurface: onSurfaceDark,
          inversePrimary: primaryDark,
          surfaceTint: primaryLight),
      scaffoldBackgroundColor: surfaceLight,
      cardColor: cardLight,
      dividerColor: dividerLight,

      // AppBar theme with blue gradient
      appBarTheme: AppBarTheme(
          backgroundColor: cardLight,
          foregroundColor: textPrimaryLight,
          elevation: 0,
          shadowColor: shadowLight,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimaryLight,
              letterSpacing: -0.02),
          iconTheme: const IconThemeData(color: textPrimaryLight, size: 24),
          actionsIconTheme:
              const IconThemeData(color: textPrimaryLight, size: 24)),

      // Card theme with blue-tinted shadows
      cardTheme: CardTheme(
          color: cardLight,
          elevation: 1,
          shadowColor: shadowLight,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation with blue accents
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: cardLight,
          selectedItemColor: primaryLight,
          unselectedItemColor: textSecondaryLight,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.4),
          unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4)),

      // FAB with blue gradient treatment
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentLight,
          foregroundColor: onPrimaryLight,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

      // Button themes with blue color scheme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryLight,
              backgroundColor: primaryLight,
              elevation: 2,
              shadowColor: shadowLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: borderLight, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),

      // Typography system using Inter for German language support
      textTheme: _buildTextTheme(isLight: true),

      // Input decoration with blue focus colors
      inputDecorationTheme: InputDecorationTheme(
          fillColor: cardLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: borderLight, width: 1)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: borderLight, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: accentLight, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: errorLight, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: errorLight, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondaryLight, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textSecondaryLight.withAlpha(153), fontSize: 16, fontWeight: FontWeight.w400),
          errorStyle: GoogleFonts.inter(color: errorLight, fontSize: 12, fontWeight: FontWeight.w400)),

      // Interactive elements with blue accents
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return textSecondaryLight;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight.withAlpha(77);
        }
        return borderLight;
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return accentLight;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryLight),
          side: const BorderSide(color: borderLight, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return borderLight;
      })),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: accentLight, linearTrackColor: borderLight, circularTrackColor: borderLight),
      sliderTheme: SliderThemeData(activeTrackColor: accentLight, thumbColor: accentLight, overlayColor: accentLight.withAlpha(51), inactiveTrackColor: borderLight, trackHeight: 4),
      tabBarTheme: TabBarTheme(labelColor: accentLight, unselectedLabelColor: textSecondaryLight, indicatorColor: accentLight, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.1)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryLight.withAlpha(230), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: surfaceLight, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryLight, contentTextStyle: GoogleFonts.inter(color: surfaceLight, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: accentLight, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      dividerTheme: const DividerThemeData(color: dividerLight, thickness: 1, space: 1),
      dialogTheme: DialogThemeData(backgroundColor: cardLight));

  /// Dark theme with Real Focus inspired colors
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          primaryContainer: primaryDark.withAlpha(51),
          onPrimaryContainer: primaryDark,
          secondary: secondaryDark,
          onSecondary: onSecondaryDark,
          secondaryContainer: secondaryDark.withAlpha(51),
          onSecondaryContainer: secondaryDark,
          tertiary: accentDark,
          onTertiary: onPrimaryDark,
          tertiaryContainer: accentDark.withAlpha(51),
          onTertiaryContainer: accentDark,
          error: errorDark,
          onError: onPrimaryDark,
          errorContainer: errorDark.withAlpha(51),
          onErrorContainer: errorDark,
          surface: surfaceDark,
          onSurface: onSurfaceDark,
          onSurfaceVariant: textSecondaryDark,
          outline: borderDark,
          outlineVariant: borderDark.withAlpha(128),
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: surfaceLight,
          onInverseSurface: onSurfaceLight,
          inversePrimary: primaryLight,
          surfaceTint: primaryDark),
      scaffoldBackgroundColor: surfaceDark,
      cardColor: cardDark,
      dividerColor: dividerDark,
      appBarTheme: AppBarTheme(
          backgroundColor: cardDark,
          foregroundColor: textPrimaryDark,
          elevation: 0,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimaryDark,
              letterSpacing: -0.02),
          iconTheme: const IconThemeData(color: textPrimaryDark, size: 24),
          actionsIconTheme:
              const IconThemeData(color: textPrimaryDark, size: 24)),
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 1,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: cardDark,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.4),
          unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentDark,
          foregroundColor: onPrimaryDark,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryDark,
              backgroundColor: primaryDark,
              elevation: 2,
              shadowColor: shadowDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: borderDark, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),
      textTheme: _buildTextTheme(isLight: false),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: cardDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: borderDark, width: 1)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: borderDark, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: accentDark, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: errorDark, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: errorDark, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textSecondaryDark.withAlpha(153), fontSize: 16, fontWeight: FontWeight.w400),
          errorStyle: GoogleFonts.inter(color: errorDark, fontSize: 12, fontWeight: FontWeight.w400)),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return textSecondaryDark;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark.withAlpha(77);
        }
        return borderDark;
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return accentDark;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryDark),
          side: const BorderSide(color: borderDark, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return borderDark;
      })),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: accentDark, linearTrackColor: borderDark, circularTrackColor: borderDark),
      sliderTheme: SliderThemeData(activeTrackColor: accentDark, thumbColor: accentDark, overlayColor: accentDark.withAlpha(51), inactiveTrackColor: borderDark, trackHeight: 4),
      tabBarTheme: TabBarTheme(labelColor: accentDark, unselectedLabelColor: textSecondaryDark, indicatorColor: accentDark, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.1)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryDark.withAlpha(230), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: surfaceDark, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryDark, contentTextStyle: GoogleFonts.inter(color: surfaceDark, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: accentDark, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      dividerTheme: const DividerThemeData(color: dividerDark, thickness: 1, space: 1),
      dialogTheme: DialogThemeData(backgroundColor: cardDark));

  /// Helper method to build text theme with Inter font family
  /// Optimized for German language requirements and mobile readability
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;

    return TextTheme(
        // Display styles for large headings
        displayLarge: GoogleFonts.inter(
            fontSize: 57,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -0.25,
            height: 1.12),
        displayMedium: GoogleFonts.inter(
            fontSize: 45,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.16),
        displaySmall: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.22),

        // Headline styles for section headers
        headlineLarge: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.25),
        headlineMedium: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.29),
        headlineSmall: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.33),

        // Title styles for cards and components
        titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0,
            height: 1.27),
        titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.15,
            height: 1.5),
        titleSmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1,
            height: 1.43),

        // Body text for main content
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.5,
            height: 1.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.25,
            height: 1.43),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            letterSpacing: 0.4,
            height: 1.33),

        // Label styles for buttons and form elements
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1,
            height: 1.43),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.5,
            height: 1.33),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textSecondary,
            letterSpacing: 0.5,
            height: 1.45));
  }

  // Gradient decoration methods for modern card effects
  static BoxDecoration gradientCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [gradientStartDark, gradientEndDark.withAlpha(179)]
            : [gradientStartLight, gradientEndLight.withAlpha(179)],
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? shadowDark : shadowLight,
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration modernCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? cardDark : cardLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDark ? borderDark : borderLight,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? shadowDark : shadowLight,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
