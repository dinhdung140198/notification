import 'package:flutter/material.dart';

class AppFonts{
  static const String OpenSans = 'OpenSans';
}

class AppTextStyle{
  static const TextStyle openSans = TextStyle(
    fontFamily: AppFonts.OpenSans,
  );

  static const TextStyle montserrat = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static TextStyle get normal => openSans.copyWith(fontSize: 14, color: Colors.black);

  static TextStyle get medium => openSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle get bold => openSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);
}

class AppColors {
  static const Color verdigris = Color.fromRGBO(95, 86, 62, 1);
}