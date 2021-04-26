import 'package:flutter/material.dart';

class AppStartup extends ChangeNotifier {
  bool value = true;

  bool getValue() => value;

  void setValue(bool inputValue) {
    value = inputValue;
    notifyListeners();
  }
}
