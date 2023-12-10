import 'package:fam_story_frontend/di/provider/id_provider.dart';
import 'package:fam_story_frontend/models/family_member_model.dart';
import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/pages/calendar_page.dart';
import 'package:fam_story_frontend/pages/chat_page.dart';
import 'package:fam_story_frontend/pages/home_page.dart';
import 'package:fam_story_frontend/pages/post_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'style.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late Future<FamilyMemberModel> _familyMember;
  late Future<FamilyModel> _family;
  int _familyMemberId = 0;
  int _familyId = 0;
  int _role = 0;
  String _name = '';
  String _nickname = '';
  String _introMessage = '';

  final List<Widget> _pages = [
    const HomePage(),
    const ChatPage(),
    const PostPage(),
    const CalendarPage()
  ];

  var messagetitle = "";
  var messagebody = "";
  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }

  @override
  void initState() {
    super.initState();
    // Future.microtask(() => _initData());
    _initData();

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
  }

  Future<void> _initData() async {
    _familyMember = FamilyMemberApiService.getFamilyMember();
    _familyMember.then((value) {
      _role = value.role;
      _name = value.name;
      _nickname = value.nickname;
      _introMessage = value.introMessage;
      _familyMemberId = value.familyMemberId;
      _family = FamilyMemberApiService.postAndGetFamily(_familyMemberId);
      _family.then((value) {
        _familyId = value.familyId;
        context.read<IdProvider>().setFamilyMemberId(_familyMemberId);
        context.read<IdProvider>().setFamilyId(_familyId);
        context.read<IdProvider>().setRole(_role);
        context.read<IdProvider>().setName(_name);
        context.read<IdProvider>().setNicKName(_nickname);
        context.read<IdProvider>().setIntroMessage(_introMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: AppColor.backgroudColor,
        ),
      ),
      backgroundColor: AppColor.backgroudColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.objectColor,
        selectedItemColor: AppColor.swatchColor,
        unselectedItemColor: Colors.grey.withOpacity(0.7),
        selectedLabelStyle: const TextStyle(color: AppColor.textColor),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined), label: 'Post'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded), label: 'Calendar'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
