import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/app/resources/font_manager.dart';
import 'package:movies_app_mvvm/app/resources/text_styles_manager.dart';
import 'package:movies_app_mvvm/app/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    textTheme: TextTheme(
      titleLarge: getBlackStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSize.s30,
      ),
      displayLarge: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s30,
      ),
      titleMedium: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s20,
      ),
      labelSmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppPadding.p14,
        horizontal: AppPadding.p18,
      ),
      hintStyle: getRegularStyle(
        color: ColorManager.textGrey,
        fontSize: FontSize.s15,
      ),
      labelStyle: getRegularStyle(
        color: ColorManager.textGrey,
        fontSize: FontSize.s15,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.whiteBorder,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.white,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s20,
        ),
        minimumSize: const Size(
          double.infinity,
          AppSize.s50,
        ),
        backgroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
