import 'dart:async';

import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/pages/login_sign_up_page.dart';
import 'package:fam_story_frontend/root_page.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:fam_story_frontend/models/family_model.dart';

import '../di/provider/id_provider.dart';
import '../models/family_member_model.dart';
import '../models/family_model.dart';
import '../models/family_model.dart';
import '../models/family_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with TickerProviderStateMixin {
  final _familyNameController = TextEditingController();
  late Future<List<FamilyModel>> _familyInfo;
  int familyId = 0, familyMemberId = 0;


  String buttonText = 'Go Out';
  String buttonText2 = 'Edit';


  String username = '';
  String nickname = '';
  String password = '';
  int age = -1;
  int gender = -1;
  bool isEditMode = false; // Track the edit mode

  int familyMemberID = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
      _initData();
  }

  Future<void> _initData() async {
    familyId = context.watch<IdProvider>().familyId;
    familyMemberId = context.watch<IdProvider>().familyMemberId;
    print('familyId: $familyId');
    print('familyMemberId: $familyMemberId');

  }


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
                  "My Room",
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
            top: 80,
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
                      margin: const EdgeInsets.only(top: 0),
                      child: Form(
                          child: Column(
                            children: [
                              // E-mail
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("E-mail"),
                                    const SizedBox(height: 10),
                                    Text(context.read<IdProvider>().email,), // TODO: 수정해야됨
                                    Divider(color: AppColor.swatchColor,),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Username"),
                                    if (isEditMode)
                                      TextFormField(
                                        autofocus: true,
                                        initialValue: username,
                                        decoration: InputDecoration(
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          hintText: 'username',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          // Handle saving logic
                                        },
                                      ),
                                    if (!isEditMode)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 16),
                                          Text(context.read<IdProvider>().username,),
                                          const SizedBox(height: 4),
                                          Divider(color: AppColor.swatchColor,),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nickname"),
                                    if (isEditMode)
                                      TextFormField(
                                        autofocus: true,
                                        initialValue: username,
                                        decoration: InputDecoration(
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: AppColor.swatchColor),
                                          ),
                                          hintText: 'nickname',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),

                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          // Handle saving logic
                                        },
                                      ),
                                    if (!isEditMode)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 16),
                                          Text(context.read<IdProvider>().nickname,),
                                          const SizedBox(height: 4),
                                          Divider(color: AppColor.swatchColor,),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
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
                                          if (isEditMode)
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
                                          if (!isEditMode)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 20),
                                                //Text(context.read<IdProvider>().age), // TODO
                                                Divider(color: AppColor.swatchColor,),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Gender
                                    if (isEditMode)
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
                                    if (!isEditMode)
                                      SizedBox(
                                        width: 150,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Gender"),
                                            const SizedBox(height: 20),
                                            Text(
                                              context.read<IdProvider>().gender == 0 ? "남자" : "여자",
                                              // TODO: 수정해야됨
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Divider(color: AppColor.swatchColor,)
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
            left: 300,
            right: 0,
            top: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        // Toggle the edit mode when the button is pressed
                        isEditMode = !isEditMode;
                      });
                    },
                    icon: const Icon(CupertinoIcons.pen)),
              ],
            ),
          ),
          if(!isEditMode)
          Positioned(
            left: 0,
            right: 0,
            top: 460,
            child: Center(
              child: Container(
                width: 350, // Set the width of the Container
                height: 120, // Set the height of the Container
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
                  children: [
                    SizedBox(height: 5,),
                    Align(
                      child: Text(
                        'Send an invitation!',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.read<IdProvider>().familyKeyCode,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 620,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginSignUpPage()));
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
