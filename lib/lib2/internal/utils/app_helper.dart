import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DateTime? clickTime;

class AppHelper {

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// set status bar overlay style
  static SystemUiOverlayStyle statusBarOverlayUI(Brightness? androidBrightness) {
    late SystemUiOverlayStyle statusBarStyle;
    if (Platform.isIOS) {
      statusBarStyle = (androidBrightness == Brightness.light)
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    }
    if (Platform.isAndroid) {
      statusBarStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: androidBrightness ?? Brightness.light);
    }
    return statusBarStyle;
  }

  static void distinctClick({required Function action}) {
    DateTime now = DateTime.now();
    if (clickTime == null) {
      clickTime = now;
      action();
    }
    if (now.difference(clickTime!).inSeconds < 1) return;
    clickTime = now;
    action();
  }
  
}