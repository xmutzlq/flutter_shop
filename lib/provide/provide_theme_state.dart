import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  ThemeData _themeData; //主题
  int _colorIndex; //颜色

  ThemeState(this._colorIndex, this._themeData);

  void changeThemeData(int colorIndex, ThemeData themeData) {
    _themeData = themeData;
    _colorIndex = colorIndex;
    notifyListeners();
  }

  ThemeData get themeData => _themeData;
  int get colorIndex => _colorIndex;
}