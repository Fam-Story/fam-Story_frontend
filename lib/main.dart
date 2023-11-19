import 'package:fam_story_frontend/pages/login_sign_up_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:flutter/material.dart';

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
      home: const LoginSignUpPage(),
    );
  }
}
