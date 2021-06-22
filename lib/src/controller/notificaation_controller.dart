import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();
  late FirebaseMessaging? messaging;
  RemoteMessage? mes;

  @override
  void onInit() {
    super.onInit();
    messaging = FirebaseMessaging.instance;
    messaging!.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      print(message.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      _actionOnNotification(message);
      print("mes : $mes");
    });

    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    print("background message ${message.notification!.body}");
  }

  void _actionOnNotification(RemoteMessage message) {
    mes = message;
    update();
    print(mes);
  }

  void actionOnNotification2() {
    mes = null;
    update();
    print(mes);
  }
}
