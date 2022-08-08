import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._private();
  static final LocalStorage instance = LocalStorage._private();


  Future<void> saveLocale(String languageCode) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('languageCode', languageCode);
  }

  Future<String?> getLocale() async {
    final pref = await SharedPreferences.getInstance();
    final languageCode = pref.getString('languageCode');
    return languageCode ?? '';
  }

  Future<void> saveAccessToken(String token) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  Future<String?> getAccessToken() async{
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    return token;
  }
}