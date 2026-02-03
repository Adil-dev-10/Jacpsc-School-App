/// App-wide constant values.
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'JACPSC';
  static const String appFullName = 'Jamuna Cantonment Public School & College';
  static const String appVersion = '1.0.0';

  // API Endpoints (Mock)
  static const String baseUrl = 'https://api.jacpsc.edu.bd'; // Placeholder

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String onboardingCompleteKey = 'onboarding_complete';

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 9999.0;
}
