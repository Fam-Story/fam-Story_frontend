import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/models/user_model.dart';
import 'package:fam_story_frontend/models/family_interaction_model.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> with TickerProviderStateMixin {

  String buttonText = 'Clear';

  List<FamilyInteractionModel> interactions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leading: SizedBox(
            width: 40.0,
            height: 40.0,
            child: Container(
              margin: const EdgeInsets.only(left: 16.0, top: 8),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.swatchColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          backgroundColor: AppColor.backgroudColor,
        ),
      ),
      backgroundColor: AppColor.backgroudColor,
      body: Stack(
        children: [
          const Positioned(
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recognize",
                  style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hear Family's Reactions",
                  style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxHeight: 480),
                margin: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                padding: const EdgeInsets.only(top:20.0, bottom: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: AppColor.objectColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Form(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: interactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = interactions[interactions.length - 1 - index];
                              bool isChecked = item.isChecked ?? false;
                              return Container(
                                height: 60,
                                color: isChecked ? Colors.white: Colors.grey[200],
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blue, // 도형의 배경색
                                      child: Icon(
                                        Icons.person, // 아이콘 등을 넣어줄 수 있습니다.
                                        color: Colors.white, // 아이콘의 색상
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.blue, // 도형의 배경색
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/heart.png', // 이미지 URL로 변경
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10), // 도형과 텍스트 간격 조절
                                    Text(
                                      "${item.srcMemberId}님이 당신을 ${item.interactionType}했어요.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),

                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),



          Positioned(
            left: 0,
            right: 0,
            top: 630,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Access user input values

                      // TODO: API 연결, 가족 멤버 생성, 가족 ID 가져오기
                    } catch (e) {
                      print(e.toString());
                    }
                    setState(() {
                    });
                  },

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    backgroundColor: AppColor.textColor, // 항상 활성화된 색상
                    minimumSize: const Size(120, 40),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: AppColor.objectColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
