import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../utils/logger_utils.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseService instance = FirebaseService._();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Call this in main() before runApp()
  Future<void> initialize({FirebaseOptions? options}) async {
    try {
      await Firebase.initializeApp(options: options);
      _initialized = true;
      AppLogger.info('✅ Firebase initialized successfully');
    } catch (e) {
      AppLogger.error('❌ Firebase initialization failed: $e');
      rethrow;
    }
  }
}
