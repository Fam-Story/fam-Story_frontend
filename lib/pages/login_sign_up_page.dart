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
  String userEmail = '';
  String userName = '';
  String userNickname = '';
  String userPassword = '';
  int userAge = 0;
  String userGender = '';

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
              top: 0,
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FamStory',
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
              left: 0,
              top: 160,
              right: 0,
              bottom: isSignUpScreen ? 160 : 320,
              child: AnimatedContainer(
                duration: const Duration(microseconds: 300),
                padding: const EdgeInsets.all(20),
                // height: isSignUpScreen ? 380 : 290,
                height: 420,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
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
                  padding: const EdgeInsets.only(bottom: 40),
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
                                    userEmail = value!;
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
                                    userPassword = value!;
                                  },
                                ),
                                const SizedBox(height: 10),
                                // Name
                                if (isSignUpScreen)
                                  Column(
                                    children: [
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
                                          userName = value!;
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
                                          userNickname = value!;
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
                                                userAge = int.tryParse(value!)!;
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
                                                userGender = value!;
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
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: 0,
              top: isSignUpScreen ? 390 : 60,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(color: AppColor.objectColor, borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(userEmail);
                        print(userPassword);
                        if (isSignUpScreen) {
                          print(userName);
                          print(userNickname);
                          print(userAge);
                          print(userGender);
                        }
                      } else {
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
