import 'package:fam_story_frontend/di/provider/id_provider.dart';
import 'package:fam_story_frontend/models/family_member_model.dart';
import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/pages/calendar_page.dart';
import 'package:fam_story_frontend/pages/chat_page.dart';
import 'package:fam_story_frontend/pages/home_page.dart';
import 'package:fam_story_frontend/pages/post_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    //Future.microtask(() => _initData());
    _initData().then((_) {});
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

  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
          Duration(seconds: flag ? 0 : 1), () => _pages[_selectedIndex]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            // 처음 한 번만 1초 텀 주는 부분
            return Scaffold(
              backgroundColor: AppColor.backgroudColor,
              body: Center(
                child: LoadingIndicator(),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: AppBar(
                  backgroundColor: AppColor.backgroudColor,
                ),
              ),
              backgroundColor: AppColor.backgroudColor,
              body: snapshot.data,
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
                      icon: Icon(Icons.question_answer_outlined),
                      label: 'Chat'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sticky_note_2_outlined), label: 'Post'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_rounded),
                      label: 'Calendar'),
                ],
                onTap: (index) {
                  setState(() {
                    flag = true;
                    _selectedIndex = index;
                  });
                },
              ),
            );
        }
      },
    );
  }
}
