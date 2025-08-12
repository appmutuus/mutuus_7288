import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme configuration implementing the Mutuus design guideline.
///
/// Colors follow the blue focused palette for both light and dark modes
/// and typography uses Roboto with predefined sizes.
class AppColors {
  // Dark mode colors
  static const Color darkBackground = Color(0xFF1A237E);
  static const Color darkSurface = Color(0xFF303F9F);
  static const Color darkPrimary = Color(0xFF2196F3);
  static const Color darkSecondary = Color(0xFFBBDEFB);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE0E0E0);

  // Light mode colors
  static const Color lightBackground = Color(0xFFE3F2FD);
  static const Color lightSurface = Color(0xFFBBDEFB);
  static const Color lightPrimary = Color(0xFF2196F3);
  static const Color lightSecondary = Color(0xFF90CAF9);
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);

  // Shared colors
  static const Color error = Color(0xFFF44336);
}

class AppTheme {
  AppTheme._();

  /// Light theme with rounded corners and subtle shadows.
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightTextPrimary,
      error: AppColors.error,
      onError: Colors.white,
      background: AppColors.lightBackground,
      onBackground: AppColors.lightTextPrimary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardTheme: CardTheme(
      color: AppColors.lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black.withOpacity(0.1),
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.lightTextPrimary,
      ),
      subtitle1: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: AppColors.lightTextPrimary,
      ),
      bodyText1: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.lightTextPrimary,
      ),
      bodyText2: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.lightTextSecondary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.lightPrimary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all(AppColors.lightPrimary),
        side: MaterialStateProperty.all(
          const BorderSide(color: AppColors.lightPrimary),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );

  /// Dark theme mirroring light theme styles with darker surfaces.
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkTextPrimary,
      error: AppColors.error,
      onError: Colors.white,
      background: AppColors.darkBackground,
      onBackground: AppColors.darkTextPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.white.withOpacity(0.1),
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.darkTextPrimary,
      ),
      subtitle1: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: AppColors.darkTextPrimary,
      ),
      bodyText1: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.darkTextPrimary,
      ),
      bodyText2: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.darkTextSecondary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.darkPrimary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all(AppColors.darkPrimary),
        side: MaterialStateProperty.all(
          const BorderSide(color: AppColors.darkPrimary),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}

