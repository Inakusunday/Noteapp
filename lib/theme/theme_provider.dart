import 'package:flutter/material.dart';
import 'package:notes/theme/theme.dart';

class ThemeDataProvider with ChangeNotifier {

  //initially, theme is ligth mode
  ThemeData _themeData = ligthMode;

  // gggget the mothod to access the theme from other part of the code
  ThemeData get themeData => _themeData; 

  //getter to see if we are in dart mode or not
  bool get isDarkMode => _themeData == darkMode;
  
  // setter the mode to set the new theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  //  we will use this toggle in a swicth later on
  void toggleheme(){
    if(_themeData == ligthMode){
      themeData = darkMode;
    }else{
      themeData = ligthMode;
    }
  }
}