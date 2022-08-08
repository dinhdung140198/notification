import 'package:flutter/foundation.dart';
class GlobalLoadingManager {
  final ValueNotifier<bool> _loadingValue = ValueNotifier(false);

  ValueListenable<bool> get value => _loadingValue;

  void show() => _loadingValue.value = true;
  void hide() => _loadingValue.value = false;
  void dispose() => _loadingValue.dispose();
}