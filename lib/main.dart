import 'package:fam_story_frontend/pages/family_create_page.dart';
import 'package:fam_story_frontend/pages/family_join_page.dart';
import 'package:fam_story_frontend/pages/role_page.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/screens/loading_screen.dart';
import 'package:fam_story_frontend/pages/family_join_create_page.dart';
import 'package:fam_story_frontend/pages/login_sign_up_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_core/firebase_core.dart'; //firebase fcm 세팅
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

import 'package:fam_story_frontend/pages/fcm_test_page.dart';

//백그라운드 메시지
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken(vapidKey:"BE46-NFLsOf2G-GidNDD6Bq-gz_ktXKwarsctTAFZFa0E_I081YpdqJVAakadjBDJNNWSKpPX0EIvWS_aS0j1DE");
  print('Firebase Messaging Token: $token');
  print('Handling a background message ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification}');
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  initializeNotification();

  runApp(FamStory());
}

class FamStory extends StatelessWidget {
  const FamStory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamStory',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),

        '/rootPage': (context) => const RootPage(),
        '/loginSignUpPage': (context) => const LoginSignUpPage(),
        '/familyJoinCreatePage': (context) => const FamilyJoinCreatePage(),
        '/familyJoinPage': (context) => const FamilyJoinPage(),
        '/familyCreatePage': (context) => const FamilyCreatePage(),
        '/rolePage': (context) => const RolePage(), // 인자 필요함
      },
    );
  }
}
