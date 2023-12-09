import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/models/user_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with TickerProviderStateMixin {
  final _familyNameController = TextEditingController();

  String buttonText = 'Go Out';
  String buttonText2 = 'Edit';

  bool _isEditing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String nickname = '';
  String password = '';
  int age = -1;
  int gender = -1;
  bool autoLogin = false;

  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female'];
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
      body: Stack(
        children: [
          const Positioned(
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Setting",
                  style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tell Me Who You Are !",
                  style: TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 120,
            child: Center(
              child: Container(
                margin: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                padding: const EdgeInsets.all(20.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Form(
                          child: Column(
                            children: [
                              // E-mail
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("E-mail"),
                                    Text("이 부분에 이메일 고정"),
                                    Divider(color: AppColor.swatchColor,),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Username
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Username"),
                                      TextFormField(
                                        initialValue: username,
                                        decoration: InputDecoration(
                                          focusedBorder: const UnderlineInputBorder(
                                            // 선택 시 하단 밑줄 색상 변경
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            // 비활성 시 하단 밑줄 색상
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          hintText: 'username',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                          contentPadding: const EdgeInsets.all(10),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          username = value!;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 10),
                                // Nickname
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nickname"),
                                    TextFormField(
                                      initialValue: nickname,
                                      decoration: InputDecoration(
                                        focusedBorder: const UnderlineInputBorder(
                                          // 선택 시 하단 밑줄 색상 변경
                                          borderSide: BorderSide(color: AppColor.swatchColor),
                                        ),
                                        enabledBorder: const UnderlineInputBorder(
                                          // 비활성 시 하단 밑줄 색상
                                          borderSide: BorderSide(color: AppColor.swatchColor),
                                        ),
                                        hintText: 'nickname',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        contentPadding: const EdgeInsets.all(10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        username = value!;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                                // Age, Gender
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Age
                                    SizedBox(
                                      width: 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Age"),
                                          TextFormField(
                                            initialValue: age.toString(),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              focusedBorder: const UnderlineInputBorder(
                                                // 선택 시 하단 밑줄 색상 변경
                                                borderSide: BorderSide(color: AppColor.swatchColor),
                                              ),
                                              enabledBorder: const UnderlineInputBorder(
                                                // 비활성 시 하단 밑줄 색상
                                                borderSide: BorderSide(color: AppColor.swatchColor),
                                              ),
                                              hintText: 'age',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.withOpacity(0.7),
                                              ),
                                              contentPadding: const EdgeInsets.all(10),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your age';
                                              }
                                              if (int.tryParse(value) == null) {
                                                return 'Age must be a number';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              age = int.tryParse(value!)!;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Gender
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Gender"),
                                          DropdownButtonFormField<String>(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                            value: _selectedGender,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedGender = newValue;
                                              });
                                            },
                                            items: _genders.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'please choose your gender';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              gender = (value! == 'Male' ? 0 : 1);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 580,
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
                    buttonText2,
                    style: const TextStyle(
                      color: AppColor.objectColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonText = 'Go Out';
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return AlertDialog(
                          backgroundColor: AppColor.objectColor,
                          content: const Text(
                            'Do you wanna leave?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.swatchColor,
                            ),
                          ),
                          actions: [
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootPage()));
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColor.objectColor,
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  minimumSize: const Size(100, 40),
                                  backgroundColor: AppColor.textColor,
                                ),
                                child: const Text(
                                  'Go Out',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.objectColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
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
