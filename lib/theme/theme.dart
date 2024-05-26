import 'package:flutter/material.dart';

// ligth mode
ThemeData ligthMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800 
  )
);

// ligth mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade900,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300 
  )
);