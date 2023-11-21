import 'dart:convert';

import 'package:fam_story_frontend/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fam_story_frontend/pages/login_sign_up_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/style.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void _navigateToNextPage() async {
    // 1.5초간 대기
    await Future.delayed(const Duration(milliseconds: 1500));

    // 로그인 상태 확인
    const storage = FlutterSecureStorage();
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString != null) {
      Map<String, dynamic> userInfo = json.decode(userInfoString);
      if (userInfo['email'] != null) {
        // 자동 로그인 상태
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootPage()));
      } else {
        // 자동 로그인 X
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginSignUpPage()));
      }
    } else {
      // 최초 로그인 상태
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginSignUpPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'fam\'Story',
              style: TextStyle(color: AppColor.textColor, fontSize: 46, fontWeight: FontWeight.bold),
            ),
            Text(
              'Finding Home Key...',
              style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
