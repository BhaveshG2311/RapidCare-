import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RapidCareTheme {
  // Curated Premium Color Constants (Indigo/Rose/Slate System)
  static const Color primaryIndigo = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryContainer = Color(0xFF4338CA); // Indigo 700
  static const Color secondaryRose = Color(0xFFE11D48); // Rose 600
  static const Color secondaryContainer = Color(0xFFBE123C); // Rose 700
  static const Color tertiaryViolet = Color(0xFF7C3AED); // Violet 600
  static const Color tertiaryContainer = Color(0xFF6D28D9); // Violet 700
  
  static const Color errorRed = Color(0xFFEF4444); // Red 500
  static const Color errorContainer = Color(0xFFFEE2E2); // Red 100

  // Light Mode Colors
  static const Color lightSurface = Color(0xFFF8FAFC); // Slate 50
  static const Color lightSurfaceLow = Color(0xFFF1F5F9); // Slate 100
  static const Color lightSurfaceLowest = Color(0xFFFFFFFF); // White
  static const Color lightSurfaceHigh = Color(0xFFE2E8F0); // Slate 200
  static const Color lightOnSurface = Color(0xFF0F172A); // Slate 900
  static const Color lightOnSurfaceVariant = Color(0xFF475569); // Slate 600
  static const Color lightOutline = Color(0xFF64748B); // Slate 500
  static const Color lightOutlineVariant = Color(0xFFCBD5E1); // Slate 300

  // Dark Mode Colors
  static const Color darkSurface = Color(0xFF0B0F19); // Very deep dark slate
  static const Color darkSurfaceLow = Color(0xFF1E293B); // Slate 800
  static const Color darkSurfaceLowest = Color(0xFF0F172A); // Slate 900
  static const Color darkSurfaceHigh = Color(0xFF334155); // Slate 700
  static const Color darkOnSurface = Color(0xFFF8FAFC); // Slate 50
  static const Color darkOnSurfaceVariant = Color(0xFF94A3B8); // Slate 400
  static const Color darkOutline = Color(0xFF475569); // Slate 600

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryIndigo,
        onPrimary: Colors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: Colors.white,
        secondary: secondaryRose,
        onSecondary: Colors.white,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: Colors.white,
        tertiary: tertiaryViolet,
        onTertiary: Colors.white,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: Colors.white,
        error: errorRed,
        onError: Colors.white,
        errorContainer: errorContainer,
        onErrorContainer: Color(0xFF7F1D1D),
        surface: lightSurface,
        onSurface: lightOnSurface,
        surfaceContainerLow: lightSurfaceLow,
        surfaceContainerLowest: lightSurfaceLowest,
        surfaceContainerHigh: lightSurfaceHigh,
        outline: lightOutline,
        outlineVariant: lightOutlineVariant,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 44,
          fontWeight: FontWeight.w800,
          height: 52 / 44,
          letterSpacing: -1.5,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 38 / 30,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 26 / 20,
          letterSpacing: -0.2,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          height: 25 / 17,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          height: 22 / 15,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 18 / 14,
          letterSpacing: 0.2,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurfaceLowest,
        elevation: 0,
        shadowColor: primaryIndigo.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceLow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryIndigo, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
        floatingLabelStyle: GoogleFonts.plusJakartaSans(color: primaryIndigo, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryIndigo,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryIndigo,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: primaryIndigo, width: 1.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF818CF8), // Slate-indigo bright
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF312E81),
        onPrimaryContainer: Colors.white,
        secondary: Color(0xFFFB7185), // Warm rose
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF881337),
        onSecondaryContainer: Colors.white,
        tertiary: Color(0xFFA78BFA),
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFF4C1D95),
        onTertiaryContainer: Colors.white,
        error: errorRed,
        onError: Colors.white,
        errorContainer: Color(0xFF450A0A),
        surface: darkSurface,
        onSurface: darkOnSurface,
        surfaceContainerLow: darkSurfaceLow,
        surfaceContainerLowest: darkSurfaceLowest,
        surfaceContainerHigh: darkSurfaceHigh,
        outline: darkOutline,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 44,
          fontWeight: FontWeight.w800,
          height: 52 / 44,
          letterSpacing: -1.5,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 38 / 30,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 26 / 20,
          letterSpacing: -0.2,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          height: 25 / 17,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          height: 22 / 15,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 18 / 14,
          letterSpacing: 0.2,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurfaceLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1E293B), width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceLow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF818CF8), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF818CF8),
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF818CF8),
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: Color(0xFF818CF8), width: 1.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
