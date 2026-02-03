import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // --- Internal App (Student Portal) Colors ---
  // Source: Home Screen.html, Splash.html
  static const Color primary = Color(0xFF002147); // Navy Blue
  static const Color primaryLight = Color(0xFF003366);
  static const Color primaryDark = Color(0xFF00152e);

  static const Color backgroundLight = Color(0xFFF5F7F8);
  static const Color backgroundDark = Color(0xFF0F1823);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  static const Color textMainLight = Color(0xFF101418);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF637588);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Status Colors
  static const Color present = Color(0xFF10B981); // Emerald Green
  static const Color absent = Color(0xFFEF4444); // Red
  static const Color holiday = Color(0xFFCBD5E1); // Slate 300
  static const Color accent = Color(0xFFF59E0B); // Amber

  // --- Public Marketing Site Colors ---
  // Source: Public Landing Home.html
  static const Color publicPrimary = Color(0xFF4F46E5); // Indigo
  static const Color publicSecondary = Color(0xFF06B6D4); // Cyan
  static const Color publicAccent = Color(0xFFF59E0B); // Amber
  static const Color publicBrandPink = Color(0xFFEC4899);
  static const Color publicBrandGreen = Color(0xFF10B981);
  static const Color publicBackgroundLight = Color(0xFFF8FAFC);
  static const Color publicBackgroundDark = Color(0xFF0F172A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF210047)],
  );

  static const LinearGradient publicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [publicPrimary, publicSecondary],
  );
}
