// ignore_for_file: deprecated_member_use (quick fi), deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Warna-warna yang digunakan dalam aplikasi
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);

class Themes {
  // Tema untuk light mode
  static final light = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: primaryClr,
      brightness: Brightness.light);

  // Tema untuk dark mode
  static final dark = ThemeData(
      backgroundColor: darkGreyClr,
      primaryColor: darkGreyClr,
      brightness: Brightness.dark);
}

// Styling pada teks yang digunakan dalam aplikasi
// Sesuai dengan hierarki teks tersebut
TextStyle get subheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}
