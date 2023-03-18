import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/font_manager.dart';
import 'package:movies_app_mvvm/app/resources/text_styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    textTheme: TextTheme(
        titleLarge: getBlackStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSize.s30,
        ),
        displayLarge: getBlackStyle(
          color: ColorManager.white,
          fontSize: FontSize.s30,
        ),
        titleMedium: getRegularStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s20,
        )),
  );
}
