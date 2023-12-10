import 'package:fam_story_frontend/di/provider/id_provider.dart';
import 'package:fam_story_frontend/pages/calendar_page.dart';
import 'package:fam_story_frontend/pages/chat_page.dart';
import 'package:fam_story_frontend/pages/home_page.dart';
import 'package:fam_story_frontend/pages/post_page.dart';
import 'package:fam_story_frontend/services/family_api_service.dart';
import 'package:fam_story_frontend/style.dart';
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
  late Future<int> _familyId, _familyMemberId;

  final List<Widget> _pages = [
    const HomePage(),
    const ChatPage(),
    const PostPage(),
    const CalendarPage()
  ];

  @override
  void initState() {
    super.initState();
    // _familyMemberId = FamilyApiService.
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<IdProvider>().familyId);
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
