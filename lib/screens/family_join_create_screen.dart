import 'package:fam_story_frontend/services/api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class FamilyJoinCreateScreen extends StatefulWidget {
  const FamilyJoinCreateScreen({super.key});

  @override
  State<FamilyJoinCreateScreen> createState() => _FamilyJoinCreateScreenState();
}

class _FamilyJoinCreateScreenState extends State<FamilyJoinCreateScreen> {
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 상단 텍스트
            const Positioned(
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'fam\'Story',
                    style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Hang With Your Family!',
                    style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // 생성 또는 참가
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Column(children: [
                  // 생성
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: (MediaQuery.of(context).size.height - 320) / 2,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColor.swatchColor),
                    child: const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Create',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46, color: AppColor.objectColor),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Create Your fam\'Story !!',
                            style: TextStyle(fontSize: 18, color: AppColor.objectColor),
                          ),
                          Text(
                            'And Invite Your Family :)',
                            style: TextStyle(fontSize: 18, color: AppColor.objectColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 참가
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: (MediaQuery.of(context).size.height - 320) / 2,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColor.objectColor),
                    child: const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Join',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46, color: AppColor.swatchColor),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Join Your fam\'Story !!',
                            style: TextStyle(fontSize: 18, color: AppColor.swatchColor),
                          ),
                          Text(
                            'With Your Invitation Code :)',
                            style: TextStyle(fontSize: 18, color: AppColor.swatchColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            // 하단 생성 버튼
          ],
        ),
      ),
    );
  }
}
