import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/firebase/notification_handle.dart';
import 'package:flutter/cupertino.dart';

class FirebaseNotifications {
  FirebaseMessaging? _messaging;
  BuildContext? myContext;

  void setupFirebase(BuildContext context) {
    _messaging;
    NotificationHandler.initNotification(context);
    firebaseCloudMessingListener(context);
    myContext = context;
  }

  void firebaseCloudMessingListener(BuildContext context) {
    _messaging!.requestPermission(
      sound: true, badge: true, alert: true
    );
    _messaging!.getToken().then((value) => print('token: $value'));

    _messaging!.subscribeToTopic('topic demo').whenComplete(() => print('subcrible OK'));

    // Future.delayed(const Duration(seconds: 1),(){
    //  FirebaseMessaging.instance.
    // });
  }
}
