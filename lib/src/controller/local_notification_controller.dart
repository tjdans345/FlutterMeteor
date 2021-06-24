import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

//
// class LocalNotificationController extends GetxController {
//   static LocalNotificationController get to => Get.find();
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     _plugInReset();
//     // _notificationShow();
//   }
//
//
//   void _plugInReset() async {
//     //로컬 메시징 안드로이드 초기화
//     const AndroidInitializationSettings initializationSettingsAndrois = AndroidInitializationSettings("defaultIcon");
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndrois);
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onSelectNotification: (payload)  async {
//           // 시간이 오래걸리는 연산수행 로직있으면 기기 자체에서 프로세스 종료시킬 수 도있음 주의하기
//           print("접속");
//         },);}
//
//   //알림창 설정 및 알림창 출력
//   void notificationShow() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             "com.example.fcm_practice", "fcm_test", "channelDescription"
//         , importance: Importance.max,
//           priority: Priority.high,
//           showWhen: false);
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show
//       (0, 'title', 'body', platformChannelSpecifics, payload:  'item x');
//   }
//
//
//
//
// }