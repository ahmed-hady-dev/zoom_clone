import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static final GetStorage _appBox = GetStorage();

  static Future<void> init() async => await GetStorage.init();

//===============================================================

  static Future<void> cacheTheme({required bool? value}) async {
    await _appBox.write('isDark', value);
  }

  static Future<bool?> get getTheme async {
    bool? isDark;
    if (_appBox.hasData('isDark')) {
      isDark = _appBox.read('isDark');
    }
    return isDark;
  }

//===============================================================
  static Future<void> write({required String key, required dynamic value}) async {
    return await _appBox.write(key, value);
  }

  static dynamic read({required String key}) {
    return _appBox.read(key);
  }

  static bool hasData({required String key}) {
    return _appBox.hasData(key);
  }
}
