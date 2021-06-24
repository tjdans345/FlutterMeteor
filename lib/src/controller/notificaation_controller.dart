import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();
  late FirebaseMessaging? messaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // late FirebaseMessaging messaging2;
  RemoteMessage? mes;

  @override
  void onInit() {
    super.onInit();

    messaging = FirebaseMessaging.instance;
    messaging!.getToken().then((value) {
      print("토큰값 확인 : $value");
    });

    subscribeTest();
    notificationTest();
    _notificationSet();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      showNotification(message.notification!.title!, message.notification!.body!);
      print(message.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      _actionOnNotification(message);
      print("mes : $mes");
    });
    // FirebaseMessaging.onBackgroundMessage(_messageHandler);

  }

  Future<void> _notificationSet() async {
    NotificationSettings settings = await messaging!.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Future<void> _messageHandler(RemoteMessage message) async {
  //   print("background messagezzzzz ${message.notification!.body}");
  // }

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

  void subscribeTest () async {
    // await messaging2.subscribeToTopic('test12');
    await messaging!.subscribeToTopic('test12');
  }

  void notificationTest() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');


    var initializationSettingsIOS = IOSInitializationSettings(
      // requestAlertPermission: false,
      // requestBadgePermission: false,
      // requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);

   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
}

//알림을 눌렀을때 어떤 행동을 할지 정해주는 부분
  Future<void> onSelectNotification(String? payload) async {
    print("payload : $payload");
  }

//await _flutterLocalNotificationPlugin.~ 에서 payload부분은 모두 설정하여 주지 않아도 됩니다.
//버튼을 눌렀을때 한번 알림이 뜨게 해주는 방법입니다.
  Future showNotification(String title, String body) async {
    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      detail,
      payload: 'ㅋㅋㅋ',
    );
  }

//매일 같은 시간 알림을 알려줍니다.
  Future dailyAtTimeNotification() async {
    //시간은 24시간으로 표시합니다아.
    var time = Time(22, 40, 0);
    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      '매일 똑같은 시간의 Notification',
      '매일 똑같은 시간의 Notification 내용',
      time,
      detail,
      payload: 'ㅇㅇ',
    );
  }
//반복적으로 알림을 뜨게 히는 방법입니다.
  Future repeatNotification() async {
    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '반복 Notification 내용',
      //ReapeatInterval.{EveryMinute, Hourly, Daily, Weekly} 중 선택하여 사용할수 있습니다.
      RepeatInterval.everyMinute,
      detail,
      androidAllowWhileIdle: true,
      payload: "ㅇㅇ?",
    );
  }


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
//         android: initializationSettingsAndrois);
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (payload)  async {
//         // 시간이 오래걸리는 연산수행 로직있으면 기기 자체에서 프로세스 종료시킬 수 도있음 주의하기
//         print("접속");
//       },);}
//
//   //알림창 설정 및 알림창 출력
//   void notificationShow(String title, String body) async {
//      print("왔으");
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//         "com.example.fcm_practice", "fcm_test", "channelDescription"
//         , importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false);
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show
//       (0, title, body , platformChannelSpecifics , payload:  'item x');
//   }
//
//


}