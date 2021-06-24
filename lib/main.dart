import 'package:fcm_practice/src/app.dart';
import 'package:fcm_practice/src/controller/local_notification_controller.dart';
import 'package:fcm_practice/src/controller/notificaation_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Get.put(LocalNotificationController());
  Get.put(NotificationController());
  NotificationController.to.showNotification(message.notification!.title!, message.notification!.body!);
  print("background message ${message.notification!.body}");
  // LocalNotificationController.to.notificationShow(message.notification!.title!, message.notification!.body!);

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(NotificationController());
        // Get.put(LocalNotificationController());
      }),
      home: App(),
    );
  }
}
