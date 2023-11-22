import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: AppColor.backgroudColor,
        ),
      ),
      backgroundColor: AppColor.backgroudColor,
      body: Center(
        child: Column(
          children: [
              Text('Hello',
                style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),),
              Container(
                width: 100.0, // 원형 이미지의 가로 크기
                height: 100.0, // 원형 이미지의 세로 크기
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 원형 모양 지정
                  image: DecorationImage(
                    image: AssetImage('assets/images/home.png'), // 이미지 경로 지정
                    fit: BoxFit.fill, // 이미지가 컨테이너를 완전히 채우도록 설정
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}
