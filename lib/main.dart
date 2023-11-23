import 'package:flutter/material.dart';
import 'package:fam_story_frontend/screens/loading_screen.dart'; // LoadingScreen import
import 'package:fam_story_frontend/pages/family_join_create_page.dart'; // FamilyJoinCreatePage import
import 'package:fam_story_frontend/pages/login_sign_up_page.dart'; // LoginSignUpPage import
import 'package:fam_story_frontend/root_page.dart'; // RootPage import

void main() {
  runApp(const FamStory());
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
      // 초기 라우트를 LoadingScreen.
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(), // LoadingScreen이 첫 화면
        '/rootPage': (context) => const RootPage(), // RootPage 라우트
        '/loginSignUpPage': (context) =>
            const LoginSignUpPage(), // LoginSignUpPage 라우트
        '/familyJoinCreatePage': (context) =>
            const FamilyJoinCreatePage(), // FamilyJoinCreatePage 라우트
        // '/familyJoinPage': (context) => const FamilyJoinPage(), // FamilyJoinPage 라우트 (추가 필요 시)
        // '/familyCreatePage': (context) => const FamilyCreatePage(), // FamilyCreatePage 라우트 (추가 필요 시)
        // TODO: 각자 추가 라우트가 필요하면 여기에 추가하세용.
      },
    );
  }
}
