import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/local/local_storage.dart';

final localeProvider = ChangeNotifierProvider<LocaleManager>((ref) => LocaleManager('ja'));

class LocaleManager extends ChangeNotifier{
  Locale? locale;

  // ignore: non_constant_identifier_names
  LocaleManager(String languageCode) {
    _loadLocale(languageCode);
  }

  Future<void> _loadLocale(String languageCode) async {
    final languageCode = await LocalStorage.instance.getLocale();
    if (languageCode!.isNotEmpty) {
      locale = Locale(languageCode);
    } else {
      locale = const Locale('ja');
    }
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    try{
      await LocalStorage.instance.saveLocale(newLocale.languageCode);
      locale = newLocale;
      notifyListeners();
    }
    catch(error){
      throw StateError("update locale failed ${error.toString()}");
    }
  }
}