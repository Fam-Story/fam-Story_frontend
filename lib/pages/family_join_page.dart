import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/services/family_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class FamilyJoinPage extends StatefulWidget {
  const FamilyJoinPage({Key? key}) : super(key: key);

  @override
  State<FamilyJoinPage> createState() => _FamilyJoinPageState();
}

class _FamilyJoinPageState extends State<FamilyJoinPage> with TickerProviderStateMixin {
  final _familyKeyCodeController = TextEditingController();
  String? familyKeyCode;

  String? _errorText;

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
          // 포커스 해제
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 상단의 멘트
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
                    "Let's Join Your Family !",
                    style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // 중단의 집 아이콘
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/keys.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // 중단의 가족 이름 입력란
            Positioned(
              top: 360,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 50, // 컨테이너의 높이 조정 가능
                    width: MediaQuery.of(context).size.width - 20, // 컨테이너의 너비 조정 가능
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textColor, width: 2), // 외곽선 추가
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.objectColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: AppColor.swatchColor, // 커서 색상 변경
                        style: const TextStyle(
                          color: AppColor.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: _familyKeyCodeController,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            // 선택 시 하단 밑줄 색상 변경
                            borderSide: BorderSide(color: AppColor.objectColor),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            // 비활성 시 하단 밑줄 색상
                            borderSide: BorderSide(color: AppColor.objectColor),
                          ),
                          focusColor: AppColor.swatchColor,
                          hintText: 'Enter Your Family Key Code Here',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          errorText: _errorText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 중단의 안내 텍스트
            const Positioned(
              top: 460,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Find Your Home Key :)',
                      style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Let\'s Open The Door !',
                      style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // 하단의 생성 버튼
            Positioned(
              top: 580,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    familyKeyCode = _familyKeyCodeController.text;
                    if (familyKeyCode!.isNotEmpty) {
                      setState(() {});
                      try {
                        FamilyModel familyInfo = await FamilyApiService.getFamilyJoin(familyKeyCode!);
                        String familyName = familyInfo.familyName;
                        int familyId = familyInfo.familyId;

                        showDialog(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return AlertDialog(
                                backgroundColor: AppColor.objectColor, // 배경색 변경
                                content: Text(
                                  'Welcome $familyName! !!',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20, // 글씨 크기 변경
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.swatchColor, // 글씨 색상 변경
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, '/rolePage', arguments: {'familyName': familyName, 'familyId': familyId});
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColor.objectColor, // 텍스트 색상
                                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10), // 버튼 패딩 조정
                                        minimumSize: const Size(100, 40),
                                        backgroundColor: AppColor.textColor, // 버튼 배경색
                                      ),
                                      child: const Text(
                                        'Let\'s Join Home',
                                        style: TextStyle(
                                          fontSize: 18, // 버튼 글씨 크기
                                          color: AppColor.objectColor, // 버튼 글씨 색상
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      // 필요한 경우 여기서 오류 메시지를 설정할 수 있습니다.
                      setState(() {
                        _errorText = "Family Name cannot be empty";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    backgroundColor: AppColor.textColor,
                    minimumSize: const Size(120, 40),
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      color: AppColor.objectColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
