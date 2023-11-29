import 'package:fam_story_frontend/pages/family_create_page.dart';
import 'package:fam_story_frontend/pages/family_join_page.dart';
import 'package:fam_story_frontend/pages/role_page.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/screens/loading_screen.dart';
import 'package:fam_story_frontend/pages/family_join_create_page.dart';
import 'package:fam_story_frontend/pages/login_sign_up_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  print('Firebase Messaging Token: $token');
  print('Handling a background message ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification}');
}

// 상단 알림을 위해 AndroidNotificationChannel 생성
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print('Firebase Messaging Token: $token');

    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 포그라운드 메시지를 처리하는 코드
      print('Handling a foreground message ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification}');

      // 포그라운드 메시지를 수신할 때 직접 알림을 표시
      showNotification(message);
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    runApp(FamStory());
  } catch (e, stackTrace) {
    print('Error initializing app: $e\n$stackTrace');
  }
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
        '/': (context) => const LoginSignUpPage(),
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

// 알림을 표시하는 함수 추가
void showNotification(RemoteMessage message) async {
  // AndroidNotificationDetails 초기화
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    channel.id,
    channel.name,
    importance: Importance.max,
    priority: Priority.high,
    // 아이콘 관련 부분은 여기서 제외됨
  );

  NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  // 알림 표시
  await flutterLocalNotificationsPlugin.show(
    message.notification.hashCode,
    message.notification!.title,
    message.notification!.body,
    platformChannelSpecifics,
  );
}
