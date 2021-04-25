import 'package:flutter/material.dart';

class UnhashedPassword extends ChangeNotifier {
  String unhashedPassword;

  String getUnhashedPassword() => unhashedPassword;

  void setUnhashedPassword(String password) {
    unhashedPassword = password;
    notifyListeners();
  }
}
