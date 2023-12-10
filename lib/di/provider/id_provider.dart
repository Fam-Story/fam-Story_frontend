import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  int familyId = 0;
  int familyMemberId = 0;
  int role = 0;
  String name = '';
  String nickname = '';
  String introMessage = '';

  void setFamilyId(int id) {
    familyId = id;
    notifyListeners();
  }

  void setFamilyMemberId(int id) {
    familyMemberId = id;
    notifyListeners();
  }

  void setRole(int role) {
    role = role;
    notifyListeners();
  }

  void setName(String name) {
    name = name;
    notifyListeners();
  }

  void setNicKName(String nickname) {
    nickname = nickname;
    notifyListeners();
  }

  void setIntroMessage(String introMessage) {
    introMessage = introMessage;
    notifyListeners();
  }
}
