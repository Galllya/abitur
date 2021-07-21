import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  fontFamily: 'Rubik',
  primaryColor: Color(0xff8A1702),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all(Color(0XFF8A1702)),
      minimumSize: MaterialStateProperty.all(Size.fromHeight(55)),
      textStyle: MaterialStateProperty.all(
          TextStyle(color: Colors.white, fontSize: 16)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 16,
      color: Color(0XFF909090),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFC8C8C8),
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFC8C8C8),
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFC8C8C8),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFC8C8C8),
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
