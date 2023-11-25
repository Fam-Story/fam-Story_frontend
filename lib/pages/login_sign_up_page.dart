import 'package:fam_story_frontend/pages/family_join_create_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/user_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isSignUpScreen = false;

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 상단 텍스트
            Positioned(
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'fam\'Story',
                    style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    isSignUpScreen ? 'Enjoy Your Home :)' : 'Welcome, Home :)',
                    style: const TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // 중단 입력창
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: 160,
              child: AnimatedContainer(
                duration: const Duration(microseconds: 300),
                curve: Curves.easeIn,
                padding: const EdgeInsets.all(20),
                height: isSignUpScreen ? 390 : 240,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignUpScreen ? AppColor.swatchColor : Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: AppColor.subColor,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignUpScreen ? AppColor.swatchColor : Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 65,
                                  color: AppColor.subColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // E-mail
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.account_circle_rounded,
                                      color: AppColor.subColor,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.subColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.swatchColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35)),
                                    ),
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    // Email 형식 검사 추가
                                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                ),
                                const SizedBox(height: 10),
                                // Password
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_rounded,
                                      color: AppColor.subColor,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.subColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.swatchColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                ),
                                const SizedBox(height: 10),
                                if (!isSignUpScreen)
                                  // 추가될 위치
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: autoLogin,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            autoLogin = newValue ?? false;
                                          });
                                        },
                                        activeColor: AppColor.swatchColor, // 체크박스 활성 색상
                                      ),
                                      Text(
                                        'Auto-Login',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (isSignUpScreen)
                                  Column(
                                    children: [
                                      // Name
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: AppColor.subColor,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.subColor),
                                            borderRadius: BorderRadius.all(Radius.circular(35)),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                            borderRadius: BorderRadius.all(Radius.circular(35)),
                                          ),
                                          hintText: 'Name',
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
                                      const SizedBox(height: 10),
                                      // Nickname
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person_add_alt_1,
                                            color: AppColor.subColor,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.subColor),
                                            borderRadius: BorderRadius.all(Radius.circular(35)),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                            borderRadius: BorderRadius.all(Radius.circular(35)),
                                          ),
                                          hintText: 'Nickname',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                          contentPadding: const EdgeInsets.all(10),
                                        ),
                                        onSaved: (value) {
                                          nickname = value!;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Age
                                          SizedBox(
                                            width: 120,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.numbers,
                                                  color: AppColor.subColor,
                                                ),
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(color: AppColor.subColor),
                                                  borderRadius: BorderRadius.all(Radius.circular(35)),
                                                ),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(color: AppColor.swatchColor),
                                                  borderRadius: BorderRadius.all(Radius.circular(35)),
                                                ),
                                                hintText: 'Age',
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
                                          ),
                                          const SizedBox(width: 20),
                                          // Gender
                                          SizedBox(
                                            width: 150,
                                            child: DropdownButtonFormField<String>(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              value: _selectedGender,
                                              hint: const Text(
                                                'Select Gender',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
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
                                          ),
                                        ],
                                      )
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
            // 하단 리턴 버튼
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: 0,
              top: isSignUpScreen ? 520 : 370,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(color: AppColor.objectColor, borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (isSignUpScreen) {
                          // 회원 가입
                          try {
                            bool isCreated = await UserApiService.createUser(email, username, password, nickname, age, gender);
                            if (isCreated) {
                              // TODO: 회원가입 완료 팝업 띄우기
                              print('sign up ok');
                            }
                          } catch (e) {
                            // TODO: 에러 내용 알려주기
                            print(e.toString());
                          }
                        } else {
                          // 로그인
                          try {
                            int isBelongedToFamily = await UserApiService.postUserLogin(email, password, autoLogin);

                            if (isBelongedToFamily == 0) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FamilyJoinCreatePage()));
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootPage()));
                            }
                          } catch (e) {
                            // TODO: 에러 내용 알려주기
                            print(e.toString());
                          }
                        }
                      } else {
                        // TODO: 굳이 뭐 할 필요 x
                        print('Validation Fault');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.textColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.door_back_door_rounded,
                        color: AppColor.objectColor,
                      ),
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
