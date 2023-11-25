import 'package:fam_story_frontend/pages/family_create_page.dart';
import 'package:fam_story_frontend/pages/family_join_page.dart';
import 'package:fam_story_frontend/pages/role_page.dart';
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
      initialRoute: '/',
      routes: {
        // TODO: 로딩에서 가족 여부 체크
        // '/': (context) => const LoadingScreen(),

        // '/': (context) => const FamilyJoinPage(),

        // 그페이지 TEST 하고 싶으면 밑처럼 그걸 메인 라우트로 지정하기~
        // '/': (context) => const FamilyJoinCreatePage(),
        '/': (context) => const LoginSignUpPage(),

        '/rootPage': (context) => const RootPage(),
        '/loginSignUpPage': (context) => const LoginSignUpPage(),
        '/familyJoinCreatePage': (context) => const FamilyJoinCreatePage(),
        '/familyJoinPage': (context) => const FamilyJoinPage(),
        '/familyCreatePage': (context) => const FamilyCreatePage(),
        '/rolePage': (context) => const RolePage(), // 인자 필요함
        // TODO: 각자 추가 라우트가 필요하면 여기에 추가하세용.
      },
    );
  }
}
