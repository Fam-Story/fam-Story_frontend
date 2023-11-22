import 'package:fam_story_frontend/pages/role_page.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

// 적절한 다트파일을 import 해주세요!
class FamilyCreatePage extends StatefulWidget {
  const FamilyCreatePage({Key? key}) : super(key: key);

  @override
  State<FamilyCreatePage> createState() => _FamilyCreatePageState();
}

class _FamilyCreatePageState extends State<FamilyCreatePage> with TickerProviderStateMixin {
  final _familyNameController = TextEditingController();
  String? _errorText;
  bool _isCreateButtonPressed = false;

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
                    "Let's Create Your Family !",
                    style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // 중단의 집 아이콘
            Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // 중단의 가족 이름 입력란
            Positioned(
              top: 280,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 20,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textColor, width: 2), // 외곽선 추가
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.objectColor,
                      boxShadow: [
                        // 그림자 효과 추가
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: AppColor.swatchColor, // 커서 색상 변경
                        style: const TextStyle(
                          color: AppColor.textColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        controller: _familyNameController,
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
                          hintText: 'Write Your Family Name',
                          hintStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          errorText: _errorText,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    width: 30,
                    decoration: BoxDecoration(
                      border: const Border(
                        // 상단을 제외한 세 면에 테두리 적용
                        left: BorderSide(color: AppColor.textColor, width: 2),
                        bottom: BorderSide(color: AppColor.textColor, width: 2),
                        right: BorderSide(color: AppColor.textColor, width: 2),
                      ),
                      color: AppColor.objectColor,
                      boxShadow: [
                        // 그림자 효과 추가
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // 하단의 생성 버튼
            Positioned(
              top: 580,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_familyNameController.text.isEmpty) {
                        // 텍스트 필드에 값이 없으면 에러 메시지를 설정
                        _errorText = 'Family Name cannot be empty';
                      } else {
                        // TODO: API 호출 및 가족 생성
                        // 생성 완료 시 완료 팝업 띄우고 롤 페이지로 이동
                        String familyName = _familyNameController.text;
                        Navigator.pushReplacementNamed(context, '/rolePage', arguments: familyName);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RolePage()));

                        _errorText = null;
                        _isCreateButtonPressed = true;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    backgroundColor: AppColor.textColor,
                    minimumSize: const Size(120, 40),
                  ),
                  child: const Text(
                    'Create',
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
