import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr=Color(0xff39C3FC);
const Color yellowClr=Color(0xff242C3B);
const Color pinkClr=Color(0xFFff4667);
const Color white=Colors.white;
const primaryClr=bluishClr;
const Color darkGreyClr=Color(0xFF121212);
const Color darkHeaderClr=Color(0xFF424242);

class Themes{
  static final light=ThemeData(
    fontFamily: "Lemonada",
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light
  );
  static final dart=ThemeData(
      fontFamily: "Lemonada",
    backgroundColor: darkGreyClr,
      primaryColor: darkGreyClr,
      brightness: Brightness.dark
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey

    )
  );
}


TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.grey[400]:Colors.grey

      )
  );
}


TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600]

      )
  );
}


TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30 ,
          fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}