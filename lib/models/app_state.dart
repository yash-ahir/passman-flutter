import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool appStarted = true;
  bool inBackground = false;

  bool getStartUp() => appStarted;

  void setStartUp(bool inputValue) {
    appStarted = inputValue;
    notifyListeners();
  }

  bool getBackground() => inBackground;

  void setBackground(bool inputValue) {
    inBackground = inputValue;
    notifyListeners();
  }
}
