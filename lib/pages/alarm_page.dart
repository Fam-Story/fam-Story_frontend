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

  List<FamilyInteractionModel> interactions = [
    FamilyInteractionModel(
      interactionId: 1,
      srcMemberId: 101,
      dstMemberId: 102,
      isChecked: false,
      interactionType: 1,
    ),
    FamilyInteractionModel(
      interactionId: 2,
      srcMemberId: 102,
      dstMemberId: 103,
      isChecked: false,
      interactionType: 2,
    ),
    FamilyInteractionModel(
      interactionId: 3,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: false,
      interactionType: 3,
    ),
    FamilyInteractionModel(
      interactionId: 4,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: false,
      interactionType: 4,
    ),
    FamilyInteractionModel(
      interactionId: 1,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: true,
      interactionType: 4,
    ),
    FamilyInteractionModel(
      interactionId: 2,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: true,
      interactionType: 3,
    ),
    FamilyInteractionModel(
      interactionId: 3,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: true,
      interactionType: 2,
    ),
    FamilyInteractionModel(
      interactionId: 4,
      srcMemberId: 103,
      dstMemberId: 101,
      isChecked: true,
      interactionType: 1,
    ),
  ];

  List<UserModel> user = [];


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
                  color: Colors.grey[100],
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
                              // TODO: srcMemberId로 아래 두 개의 값 불러오기
                              final role;
                              final nickname;
                              return Container(
                                height: 60,
                                color: isChecked ? Colors.grey[100]: Colors.grey[300],
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blue, // 도형의 배경색
                                      child: Opacity(
                                        opacity: interactions[index].isChecked ? 0.5 : 1,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 16,
                                      child: ClipOval(
                                        child: Opacity(
                                          opacity: interactions[index].isChecked ? 0.5 : 1,
                                          child: (() {
                                            switch (interactions[index].interactionType) {
                                              case 1:
                                                return Image.asset(
                                                  'assets/images/thumbup.png',
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                );
                                              case 2:
                                                return Image.asset(
                                                  'assets/images/thumbdown.png',
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                );
                                              case 3:
                                                return Image.asset(
                                                  'assets/images/heart.png',
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                );
                                              case 4:
                                                return Image.asset(
                                                  'assets/images/poke.png',
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                );
                                              default:
                                                return Container(); // 예외 처리
                                            }
                                          })(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      (() {
                                        switch (item.interactionType) {
                                          case 1:
                                            return "${item.srcMemberId} sents you a thumbs up!";
                                          case 2:
                                            return "${item.srcMemberId} sents you a thumbs up!";
                                          case 3:
                                            return "${item.srcMemberId} sents you a heart!";
                                          case 4:
                                            return "${item.srcMemberId} sents you a poke!";
                                          default:
                                            return ""; // Handle unexpected interactionType
                                        }
                                      })(),
                                      style: TextStyle(
                                        color: isChecked ? Colors.black: Colors.grey[400],
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

class FamilyInteractionModel {
  final int interactionId, srcMemberId, dstMemberId, interactionType;
  final bool isChecked;

  FamilyInteractionModel({
    required this.interactionId,
    required this.srcMemberId,
    required this.dstMemberId,
    required this.isChecked,
    required this.interactionType,
  });
}