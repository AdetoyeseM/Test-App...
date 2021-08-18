import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

void overrideDeviceColors([Color? color]) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    /* set Status bar color in Android devices. */
    statusBarColor: Colors.transparent,
    /* set Status bar icons color in Android devices.*/
    statusBarIconBrightness:
        Platform.isIOS ? Brightness.light : Brightness.dark,
    /* set Status bar icon color in iOS. */
    statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

extension CustomThemeContext on BuildContext {
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.mulish().fontFamily,
        textTheme: GoogleFonts.mulishTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
