import 'package:hive_flutter/hive_flutter.dart';
import '../utils/logger_utils.dart';
import 'hive_keys.dart';

class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();

  // ─── Initialize ────────────────────────────────────────────────────────────

  Future<void> initialize() async {
    await Hive.initFlutter();
    // Open default boxes
    await openBox(HiveKeys.settingsBox);
    await openBox(HiveKeys.cacheBox);
    await openBox(HiveKeys.userBox);
    AppLogger.info('✅ Hive initialized');
  }

  Future<Box> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  Future<LazyBox> openLazyBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openLazyBox(boxName);
    }
    return Hive.lazyBox(boxName);
  }

  // ─── CRUD ─────────────────────────────────────────────────────────────────

  Future<void> put(String boxName, String key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  T? get<T>(String boxName, String key, {T? defaultValue}) {
    if (!Hive.isBoxOpen(boxName)) return defaultValue;
    final box = Hive.box(boxName);
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  Future<void> closeAll() async {
    await Hive.close();
  }

  // ─── Register Adapter ──────────────────────────────────────────────────────

  void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }
}
