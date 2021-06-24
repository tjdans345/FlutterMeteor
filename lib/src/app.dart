
import 'dart:convert';

import 'package:fcm_practice/main.dart';
import 'package:fcm_practice/src/controller/notificaation_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.to.mes == RemoteMessage;
                      },
                      child: Text("버튼"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                       Get.to(MyApp());
                      },
                      child: Text("버튼2"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.to.showNotification("test용 타이틀", "test용 바디");
                      },
                      child: Text("Show Notification"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NotificationController.to.dailyAtTimeNotification();
                      },
                      child: Text("Daily At Time Notification"),
                    ),ElevatedButton(
                      onPressed: () {
                       NotificationController.to.repeatNotification();
                      },
                      child: Text("Repeat Notification"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        fcmPush();
                      },
                      child: Text("FCM 보내기 테스트"),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void fcmPush() async {
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    var response = await http.post(url,
        headers: {
      "content-Type": "application/json",
      "Authorization":"key=AAAA20hCDes:APA91bHIIrMLZQOtfTHzgm2CHWhuOPARbY_deHwJFEqbfv-mqnbqh0j_M8FoS2yDbeos9FsVI9a9Tr4LLElEmwJp9CGLU0ZrZ9727K1mxyYRMqwoIyTKcGWVcvLIdijnDdQLYBXBEtil"},
        body: jsonEncode({
          "notification":{"title": "fcm Push","body": "버튼형"},
          "to" : "dN1R7Hw_Q66Mj-mMzdEDsb:APA91bGjFCPyYI5ea_NVVU2xygVF9WVdV4VsA950QufDlQK3MSrrDspo-zvkfFHduuO-uKpfdSGcWJSTv39aYDSqid7dSLd9nWcR3qNhNR9XcfnSyRxf12UA2clfIuK-3deA5qpi2uQd"
        })

    );
    print(response.body);

  }
}
