import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  // Internal App Font (Lexend)
  static TextTheme get internalTextTheme {
    return GoogleFonts.lexendTextTheme().copyWith(
      displayLarge: GoogleFonts.lexend(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.lexend(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.lexend(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.lexend(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.lexend(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.lexend(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.lexend(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.lexend(fontSize: 11, fontWeight: FontWeight.w500),
    );
  }

  // Public Site Font (Plus Jakarta Sans)
  static TextTheme get publicTextTheme {
    return GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 57,
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
