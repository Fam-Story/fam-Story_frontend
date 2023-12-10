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
}
