import 'package:firebase_messaging/firebase_messaging.dart';
import '../utils/logger_utils.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppLogger.info('Background message: ${message.messageId}');
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? _token;

  String? get token => _token;

  Future<void> initialize({
    Function(RemoteMessage)? onForegroundMessage,
    Function(RemoteMessage)? onMessageOpenedApp,
  }) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestPermission();
    await _getToken();

    // Foreground
    FirebaseMessaging.onMessage.listen((message) {
      AppLogger.info('FCM Foreground: ${message.notification?.title}');
      if (message.notification != null) {
        NotificationService.instance.show(
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? '',
          payload: message.data.toString(),
        );
      }
      onForegroundMessage?.call(message);
    });

    // Opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      AppLogger.info('FCM Opened: ${message.notification?.title}');
      onMessageOpenedApp?.call(message);
    });

    // Token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      _token = newToken;
      AppLogger.info('FCM Token refreshed: $newToken');
    });
  }

  Future<void> _requestPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    AppLogger.info('FCM permission: ${settings.authorizationStatus}');
  }

  Future<void> _getToken() async {
    _token = await _fcm.getToken();
    AppLogger.info('FCM Token: $_token');
  }

  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
  }

  Future<void> deleteToken() async {
    await _fcm.deleteToken();
    _token = null;
  }
}
