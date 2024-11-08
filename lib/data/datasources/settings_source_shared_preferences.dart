// ignore_for_file: avoid-late-keyword, avoid-collection-mutating-methods

import 'package:birds/domain/datasources/settings_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация источника данных настроек через [FlutterSecureStorage].
class SettingsSourceSharedPreferences extends SettingsSource {
  SharedPreferences? _prefs;
  late Future<void> _initialize;
  bool _isDone = false;

  /// После вызова конструктора, обязательно проверить статус initialize.
  SettingsSourceSharedPreferences() {
    // Так надо.
    // ignore: avoid-async-call-in-sync-function
    _initialize = _init();
  }

  /// Первоначальное считываение данных.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isDone = true;
  }

  @override
  Future<void> get initialize => _initialize;

  @override
  bool get isDone => _isDone;

  @override
  // Не ругайся
  // ignore: no-object-declaration
  Object? get(String key) {
    return _prefs?.get(key);
  }

  @override
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  @override
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  @override
  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  @override
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    return (await _prefs?.setDouble(key, value)) ?? false;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return (await _prefs?.setInt(key, value)) ?? false;
  }

  @override
  Future<bool> setString(String key, String value) async {
    return (await _prefs?.setString(key, value)) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  @override
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}
