import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  int familyId = 0;
  int familyMemberId = 0;

  void setFamilyId(int id) {
    familyId = id;
    notifyListeners();
  }

  void setFamilyMemberId(int id) {
    familyMemberId = id;
    notifyListeners();
  }
}
