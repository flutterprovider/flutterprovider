import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utils/logger_utils.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize({
    String androidIcon = '@mipmap/ic_launcher',
    Function(NotificationResponse)? onTap,
  }) async {
    tz.initializeTimeZones();

    // ✅ Fix: toString() सभी versions में safely काम करता है
    // चाहे String हो या TimezoneInfo object — दोनों में timezone name मिलेगा
    final timeZoneName = (await FlutterTimezone.getLocalTimezone()).toString();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // ✅ Fix: androidIcon parameter अब actually use हो रहा है
    final androidSettings = AndroidInitializationSettings(androidIcon);
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: onTap,
      // ✅ Background/terminated state में tap handle करने के लिए
      // Note: यह एक top-level function होना चाहिए, इसलिए बाहर define करें
      // onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationResponse,
    );
    AppLogger.info('✅ NotificationService initialized');
  }

  Future<bool> requestPermission() async {
    // ✅ Fix: Android 13+ (API 33) permission भी handle हो रही है
    final androidResult = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    final iosResult = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return androidResult ?? iosResult ?? false;
  }

  // ─── Show Notification ────────────────────────────────────────────────────

  Future<void> show({
    int id = 0,
    required String title,
    required String body,
    String? payload,
    String channelId = 'default_channel',
    String channelName = 'Default',
    Importance importance = Importance.high,
    Priority priority = Priority.high,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: importance,
      priority: priority,
      showWhen: true,
    );
    const iosDetails = DarwinNotificationDetails();

    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );
  }

  // ─── Schedule Notification ─────────────────────────────────────────────────

  Future<void> schedule({
    int id = 0,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    String channelId = 'scheduled_channel',
    String channelName = 'Scheduled',
    // ✅ Optional: daily/weekly repeat के लिए
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  // ✅ Pending notifications देखने के लिए utility method
  Future<List<PendingNotificationRequest>> getPending() =>
      _plugin.pendingNotificationRequests();

  Future<void> cancel(int id) => _plugin.cancel(id);

  Future<void> cancelAll() => _plugin.cancelAll();
}

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import '../utils/logger_utils.dart';
//
// class NotificationService {
//   NotificationService._();
//   static final NotificationService instance = NotificationService._();
//
//   final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initialize({
//     String androidIcon = '@mipmap/ic_launcher',
//     Function(NotificationResponse)? onTap,
//   }) async {
//     tz.initializeTimeZones();
//     final timeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//
//     const androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//
//     await _plugin.initialize(
//       const InitializationSettings(
//           android: androidSettings, iOS: iosSettings),
//       onDidReceiveNotificationResponse: onTap,
//     );
//     AppLogger.info('✅ NotificationService initialized');
//   }
//
//   Future<bool> requestPermission() async {
//     final result = await _plugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//     return result ?? false;
//   }
//
//   // ─── Show Notification ────────────────────────────────────────────────────
//
//   Future<void> show({
//     int id = 0,
//     required String title,
//     required String body,
//     String? payload,
//     String channelId = 'default_channel',
//     String channelName = 'Default',
//     Importance importance = Importance.high,
//     Priority priority = Priority.high,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       channelId,
//       channelName,
//       importance: importance,
//       priority: priority,
//       showWhen: true,
//     );
//     const iosDetails = DarwinNotificationDetails();
//
//     await _plugin.show(
//       id,
//       title,
//       body,
//       NotificationDetails(android: androidDetails, iOS: iosDetails),
//       payload: payload,
//     );
//   }
//
//   // ─── Schedule Notification ─────────────────────────────────────────────────
//
//   Future<void> schedule({
//     int id = 0,
//     required String title,
//     required String body,
//     required DateTime scheduledDate,
//     String? payload,
//     String channelId = 'scheduled_channel',
//     String channelName = 'Scheduled',
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       channelId,
//       channelName,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     const iosDetails = DarwinNotificationDetails();
//
//     await _plugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       NotificationDetails(android: androidDetails, iOS: iosDetails),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//     );
//   }
//
//   Future<void> cancel(int id) => _plugin.cancel(id);
//   Future<void> cancelAll() => _plugin.cancelAll();
// }
