import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static BuildContext? myContext;
  static void initNotification(BuildContext context) {
    myContext = context;
    var initAndroid = const AndroidInitializationSettings('defaultIcon');
    var initIOS = const IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initSetting =
        InitializationSettings(android: initAndroid, iOS: initIOS);
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: onSelectNotification);
  }

  static Future onSelectNotification(String? payload) async {}
  static Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: myContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title!,
        ),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('ok'),
          )
        ],
      ),
    );
  }
}
