import 'package:flutter/material.dart' show ThemeData, Colors;
import 'package:flutter_shop/provide/provide_locale_state.dart';

class GlobalConfig {
  //是否是调试模式
  static final bool isDebug = true;
  //配置主题
  static final initThemeData = ThemeData(primaryColor: Colors.black);
  static final initIndex = 0;
  //配置语言
  static final language = LocaleState.zh();
}