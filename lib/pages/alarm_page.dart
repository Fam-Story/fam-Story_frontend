import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/models/user_model.dart';
import 'package:fam_story_frontend/models/family_interaction_model.dart';
import 'package:provider/provider.dart';

import '../di/provider/id_provider.dart';
import '../models/family_member_model.dart';
import '../services/family_interaction_api_service.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> with TickerProviderStateMixin {
  String buttonText = 'Clear';

  late Future<List<FamilyInteractionModel>> interactions;
  late Future<FamilyMemberModel> _familyMember;
  int familyMemberId = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    familyMemberId = context.watch<IdProvider>().familyMemberId;
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
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hear Family's Reactions",
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20, left: 15, right: 15),
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
                        child: FutureBuilder<List<FamilyInteractionModel>>(
                          future: FamilyInteractionApiService.getFamilyInteraction(
                              familyMemberId), // Replace with your actual data-fetching method
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While data is being fetched, show a loading indicator
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If there's an error, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              // If no data is available, display a message indicating no interactions
                              return Container(
                                  height: 450,
                                  child:
                                      Center(child: Text('No reactions yet.')));
                            } else {
                              // Data has been successfully fetched, display the interactions
                              List<FamilyInteractionModel> interactions =
                                  snapshot.data!;

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: interactions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = interactions[
                                      interactions.length - 1 - index];
                                  bool isChecked = item.isChecked == 0;
                                  return Container(
                                    height: 60,
                                    color: isChecked
                                        ? Colors.white
                                        : Colors.grey[200],
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Opacity(
                                          opacity: isChecked ? 1.0 : 0.3,
                                          child: CircleAvatar(
                                            radius: 20,
                                            child: ClipOval(
                                              child: Center(
                                                child: Image.asset(
                                                  getRoleImage(
                                                      item.srcMemberRole),
                                                  fit: BoxFit.fill,
                                                  width: 40, // 원하는 너비로 조절
                                                  height: 40, // 원하는 높이로 조절
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Opacity(
                                          opacity: isChecked ? 1.0 : 0.3,
                                          child: CircleAvatar(
                                            radius: 12,
                                            child: ClipOval(
                                              child: getImageForInteractionType(
                                                  item.interactionType),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "${item.srcMemberNickname} ${getInteractionTypeText(item.interactionType)}",
                                          style: TextStyle(
                                            color: item.isChecked == 0
                                                ? Colors.black
                                                : Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      )
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
                      FamilyInteractionApiService.deleteFamilyInteraction(
                          familyMemberId);
                      Navigator.pop(context);
                    } catch (e) {
                      print(e.toString());
                    }
                    setState(() {});
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

  String getInteractionTypeText(int interactionType) {
    switch (interactionType) {
      case 4:
        return "complimented you";
      case 3:
        return "booed you";
      case 2:
        return "sent heart to you";
      case 1:
        return "poked you";
      default:
        return "unclassified";
    }
  }

  Widget getImageForInteractionType(int interactionType) {
    switch (interactionType) {
      case 4:
        return Image.asset(
          'assets/images/thumbup.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        );
      case 3:
        return Image.asset(
          'assets/images/thumbdown.png', // 싫어요 이미지에 대한 경로
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        );
      case 2:
        return Image.asset(
          'assets/images/heart.png', // 훈훈해요 이미지에 대한 경로
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        );
      case 1:
        return Image.asset(
          'assets/images/poke.png', // 슬퍼요 이미지에 대한 경로
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        );
      default:
        return Container(); // 기본적으로 빈 컨테이너를 반환하거나 다른 기본 이미지를 설정할 수 있습니다.
    }
  }

  String getRoleImage(int role) {
    switch (role) {
      case 1:
        return 'assets/images/grandfather.png';
      case 2:
        return 'assets/images/dad.png';
      case 3:
        return 'assets/images/son.png';
      case 4:
        return 'assets/images/grandmother.png';
      case 5:
        return 'assets/images/mom.png';
      case 6:
        return 'assets/images/daughter.png';
      default:
        return 'assets/images/son.png';
    }
  }
}
