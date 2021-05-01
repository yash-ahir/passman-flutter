import 'package:flutter/material.dart';

class PlainTextPasswordData extends ChangeNotifier {
  String unhashedMasterPassword;
  List<String> plainTextPasswords;

  String getUnhashedMasterPassword() => unhashedMasterPassword;

  void setUnhashedMasterPassword(String password) {
    unhashedMasterPassword = password;
    notifyListeners();
  }

  List<String> getPlainTextPasswords() => plainTextPasswords;

  void setPlainTextPasswords(List<String> passwordList) {
    plainTextPasswords = passwordList;
    // notifyListeners();
  }
}
