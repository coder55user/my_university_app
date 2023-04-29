import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:flutter/material.dart';

ThemeData getLightMode() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    iconTheme: IconThemeData(
      color: ColorsManager.gray,
      size: 30,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      // fillColor: ColorsManager.customMainSecondary,
      prefixStyle: TextStyle(
        color: Colors.white,
      ),
      prefixIconColor: Colors.black,
      iconColor: Colors.black,
    ),
    fontFamily: AssetsFonts.bold,

    scaffoldBackgroundColor: ColorsManager.backGround, //customScaffoldColor,
    primaryColor: ColorsManager.main, //custom main
    splashColor: Colors.white, //customBackGroundBody
    // shadowColor: ColorsManager.customMainSecondary,

    //
    textTheme: const TextTheme(
      //display Small

      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: AssetsFonts.light,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontFamily: AssetsFonts.medium,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontFamily: AssetsFonts.regular,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),

      //head line Small
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontFamily: AssetsFonts.light,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      //title Small
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: AssetsFonts.medium,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        fontFamily: AssetsFonts.regular,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontFamily: AssetsFonts.bold,
      ),
    ),
  );
}

TextStyle titleSmall(context) {
  return Theme.of(context).textTheme.titleSmall!;
}

TextStyle titleMedium(context) {
  return Theme.of(context).textTheme.titleMedium!;
}

TextStyle titleLarge(context) {
  return Theme.of(context).textTheme.titleLarge!;
}

class ColorsManager {
  //custom

  static Color backGround = const Color(0xffe8e7ec);
  static Color main = const Color(0xff808f98);
  static Color secondMain = Color.fromARGB(155, 0, 16, 234);
  static Color thirdMain = const Color(0xfff1f5fc);
  static Color gray = const Color(0xff7d8184);
  static Color secondaryGray = Colors.black.withOpacity(.05);
  static Color white = const Color.fromARGB(255, 255, 255, 255);

  //
  static Color color1 = const Color(0xffc7ebfe);
  static Color color2 = const Color(0xfffcbc04);
  static Color color3 = const Color(0xffdff7e7);
  static Color color4 = const Color(0xffffe7e5);
  static Color color5 = const Color(0xffc5ebfe);
  static Color color6 = const Color(0xffbcdcfc);
  static Color color7 = const Color(0xff8394f5);
}
