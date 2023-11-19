import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isSignUpScreen = false;
  String loginMesseage = 'Welcome, Home :)';
  String signUpMesseage = 'Join Your Home :)';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FamStory',
                  style: TextStyle(color: AppColor.textColor, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  isSignUpScreen ? signUpMesseage : loginMesseage,
                  style: const TextStyle(color: AppColor.textColor, fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 90,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 280,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
