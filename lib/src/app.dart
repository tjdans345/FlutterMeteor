import 'package:fcm_practice/src/controller/notificaation_controller.dart';
import 'package:fcm_practice/src/page/message_box.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FCM TEST"),
      ),
      body: GetBuilder<NotificationController>(
        builder: (_) {
          if (NotificationController.to.mes != null) {
            return Container(
              color: Colors.green,
              child: ElevatedButton(
                onPressed: () {
                  NotificationController.to.actionOnNotification2();
                },
                child: Text("버튼"),
              ),
            );
          } else {
            return Container(
              child: ElevatedButton(
                onPressed: () {
                  NotificationController.to.mes == RemoteMessage;
                },
                child: Text("버튼"),
              ),
            );
          }
        },
      ),
    );
  }
}
