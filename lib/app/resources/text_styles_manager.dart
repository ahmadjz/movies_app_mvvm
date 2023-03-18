import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getBlackStyle(
    {double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.black, color);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
