/// Extend this class in your app to define API endpoints
/// 
/// Example:
/// ```dart
/// class AppEndpoints extends ApiEndpoints {
///   static const String users = '/users';
///   static const String products = '/products';
/// }
/// ```
abstract class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';

  // User
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String changePassword = '/user/change-password';
  static const String uploadAvatar = '/user/avatar';

  // Notifications
  static const String saveFcmToken = '/notifications/token';
  static const String getNotifications = '/notifications';
}
