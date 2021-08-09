import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  fontFamily: 'Rubik',
  primaryColor: const Color(0xff8A1702),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all(const Color(0xFF8A1702)),
      minimumSize: MaterialStateProperty.all(const Size.fromHeight(55)),
      textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white, fontSize: 16)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF909090),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC8C8C8),
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC8C8C8),
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC8C8C8),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC8C8C8),
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
