import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';

class RolePage extends StatefulWidget {
  // 인자로 대체
  // final String familyName;
  // const RolePage({Key? key, required this.familyName}) : super(key: key);
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<RolePage>
    with TickerProviderStateMixin {
  final _familyNameController = TextEditingController();

  int? selectedRole;
  String buttonText = 'Enjoy';

  List<int> roles = [1, 2, 3, 4, 5, 6];

  Map<int, String> roleDescriptions = {
    1: 'Grandfa',
    2: 'Dad',
    3: 'Son',
    4: 'Grandma',
    5: 'Mom',
    6: 'Daughter',
  };

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final familyName = args['familyName'] as String;
    final familyId = args['familyId'] as int;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: AppColor.backgroudColor,
        ),
      ),
      backgroundColor: AppColor.backgroudColor,
      body: Stack(
        children: [
          // 상단에 고정된 UI
          const Positioned(
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "fam'Story",
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tell Me Who You Are !",
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // 중단의 Container 및 내부 UI
          Positioned(
            left: 0,
            right: 0,
            top: 120,
            child: Center(
              child: Container(
                margin: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                padding: const EdgeInsets.all(16.0),
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
                child: Column(
                  children: [
                    Text(
                      familyName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColor.swatchColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 14.0,
                        mainAxisSpacing: 14.0,
                      ),
                      itemCount: roles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // TODO: 선택한 역할에 대한 로직 추가
                            setState(() {
                              selectedRole = roles[index];
                              buttonText = 'Join';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(getRoleImage(roles[index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (selectedRole == roles[index])
                                  Positioned(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.6),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // 선택한 Role의 텍스트
                    if (selectedRole != null)
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColor.objectColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'I Am ${roleDescriptions[selectedRole!]} !',
                              style: const TextStyle(
                                fontSize: 24,
                                color: AppColor.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // 하단의 버튼
          Positioned(
            left: 0,
            right: 0,
            top: 580,
            child: Center(
              child: ElevatedButton(
                onPressed: selectedRole != null
                    ? () async {
                        // TODO: API 연결, 가족 멤버 생성, 가족 ID 가져 오기
                        print(roleDescriptions[selectedRole!]);
                        try {
                          int familyMemberId =
                              await FamilyMemberApiService.postFamilyMember(
                                  familyId, selectedRole!, "");
                        } catch (e) {
                          print(e.toString());
                        }
                        // 만약 생성이 잘 되었으면 생성 잘 되었다는 팝업 띄우고 Enjoy로 바뀜. RootPage로 이동
                        setState(() {
                          buttonText = 'Enjoy';
                        });
                        showDialog(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return AlertDialog(
                                backgroundColor: AppColor.objectColor, // 배경색 변경
                                content: const Text(
                                  'Now You Are\nA Family Member !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20, // 글씨 크기 변경
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.swatchColor, // 글씨 색상 변경
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 현재 라우트 팝
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RootPage()),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            AppColor.objectColor, // 텍스트 색상
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 10, 40, 10), // 버튼 패딩 조정
                                        minimumSize: const Size(100, 40),
                                        backgroundColor:
                                            AppColor.textColor, // 버튼 배경색
                                      ),
                                      child: const Text(
                                        'Let\'s Go Home',
                                        style: TextStyle(
                                          fontSize: 18, // 버튼 글씨 크기
                                          color:
                                              AppColor.objectColor, // 버튼 글씨 색상
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    : null, // selectedRole이 null이면 onPressed를 null로 설정하여 버튼 비활성화
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  backgroundColor:
                      selectedRole != null ? AppColor.textColor : Colors.grey,
                  minimumSize: const Size(120, 40), // selectedRole에 따라 배경색 조절
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
            ),
          ),
        ],
      ),
    );
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
      return 'assets/images/default.png';
  }
}
