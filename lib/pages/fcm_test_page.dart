import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//포그라운드 메시지
class FcmTestPage extends StatefulWidget {
  const FcmTestPage({super.key});

  @override
  State<FcmTestPage> createState() => _FcmTestPageState();
}
class _FcmTestPageState extends State<FcmTestPage> {
  var messagetitle = "";
  var messagebody = "";
  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }
  @override
  void initState() {
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messagetitle = message.notification!.title!;
          messagebody = message.notification!.body!;
          print("Foreground 메시지 제목: $messagetitle");
          print("Foreground 메시지 내용: $messagebody");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("메시지 제목: $messagetitle"),
            Text("메시지 내용: $messagebody"),
          ],
        ),
      ),
    );
  }
}
