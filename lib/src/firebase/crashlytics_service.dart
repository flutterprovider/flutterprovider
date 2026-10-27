import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  CrashlyticsService._();
  static final CrashlyticsService instance = CrashlyticsService._();

  Future<void> initialize() async {
    if (!kDebugMode) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  Future<void> logError(dynamic error, StackTrace? stack,
      {String? reason}) async {
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance
          .recordError(error, stack, reason: reason);
    }
  }

  Future<void> setUserId(String userId) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  Future<void> log(String message) async {
    await FirebaseCrashlytics.instance.log(message);
  }
}
