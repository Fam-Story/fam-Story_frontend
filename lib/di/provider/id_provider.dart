import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  int familyId = 0;
  int familyMemberId = 0;
  int role = 0;
  String name = '';
  String nickname = '';
  String introMessage = '';

  int memberNumber = 0;
  String familyName = '';
  String createdDate = '';
  String familyKeyCode = '';

  int age = 0;
  int gender = 0;
  String email = '';
  String username = '';

  void setFamilyId(int id) {
    familyId = id;
    notifyListeners();
  }

  void setFamilyMemberId(int id) {
    familyMemberId = id;
    notifyListeners();
  }

  void setRole(int ro) {
    role = ro;
    notifyListeners();
  }

  void setName(String nam) {
    name = nam;
    notifyListeners();
  }

  void setNicKName(String nick) {
    nickname = nick;
    notifyListeners();
  }

  void setIntroMessage(String message) {
    introMessage = message;
    notifyListeners();
  }

  void setMemberNumber(int memNum) {
    memberNumber = memNum;
    notifyListeners();
  }
  void setFamilyName(String fam) {
    familyName = fam;
    notifyListeners();
  }
  void setCreatedDate(String date) {
    createdDate = date;
    notifyListeners();
  }
  void setKeyCode(String keycode) {
    familyKeyCode = keycode;
    notifyListeners();
  }

  void setAge(int ageage) {
    age = ageage;
    notifyListeners();
  }
  void setGender(int gen) {
    gender = gen;
    notifyListeners();
  }
  void setEmail(String emailemail) {
    email = emailemail;
    notifyListeners();
  }
  void setUsername(String usernamename) {
    username = usernamename;
    notifyListeners();
  }

}
