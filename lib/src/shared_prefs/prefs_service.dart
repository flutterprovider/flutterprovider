import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger_utils.dart';

class PrefsService {
  PrefsService._();
  static final PrefsService instance = PrefsService._();

  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    AppLogger.info('✅ SharedPreferences initialized');
  }

  SharedPreferences get _p {
    if (_prefs == null) throw Exception('PrefsService not initialized!');
    return _prefs!;
  }

  // ─── String ────────────────────────────────────────────────────────────────
  Future<bool> setString(String key, String value) => _p.setString(key, value);
  String? getString(String key) => _p.getString(key);

  // ─── Bool ─────────────────────────────────────────────────────────────────
  Future<bool> setBool(String key, bool value) => _p.setBool(key, value);
  bool? getBool(String key) => _p.getBool(key);

  // ─── Int ──────────────────────────────────────────────────────────────────
  Future<bool> setInt(String key, int value) => _p.setInt(key, value);
  int? getInt(String key) => _p.getInt(key);

  // ─── Double ───────────────────────────────────────────────────────────────
  Future<bool> setDouble(String key, double value) => _p.setDouble(key, value);
  double? getDouble(String key) => _p.getDouble(key);

  // ─── List<String> ─────────────────────────────────────────────────────────
  Future<bool> setStringList(String key, List<String> value) =>
      _p.setStringList(key, value);
  List<String>? getStringList(String key) => _p.getStringList(key);

  // ─── Remove / Clear ───────────────────────────────────────────────────────
  Future<bool> remove(String key) => _p.remove(key);
  Future<bool> clear() => _p.clear();

  bool containsKey(String key) => _p.containsKey(key);
}
