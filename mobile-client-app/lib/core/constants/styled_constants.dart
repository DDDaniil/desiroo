import 'package:flutter/material.dart';

class StyledConstants {
  static const Color colorBackground = Colors.white;
  static const Color colorPrimary = Colors.blue;
  static const Color colorSecondary = Color(0xffF0F2F5);
  static const Color colorDivider = Color(0xffE5E8EB);

  static const Color colorTextMain = Color(0xff141414);
  static const Color colorTextSecondary = Color(0xff3D4D5C);
  static const Color colorTextDisabled = Color(0xff969b9f);


  static const TextStyle textStyleTabs = TextStyle(
    fontSize: 18,
    //color: colorTextMain,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 24,
    //color: colorTextMain,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle mainTextStyle = TextStyle(
    fontSize: 16,
    //color: colorTextMain,
  );

  static TextStyle headerTextStyle2 = StyledConstants.headerTextStyle.copyWith(
    fontSize: 18,
  );

  static const double edgeInsetsHorizontal = 20;
  static const double edgeInsetsVertical = 12;
  static const double borderRadius = 12;
  static const double fontSizeButton = 16;
  static const double fontSizeSearchButton = 24;
  static const double fontBigSize = 32;
  static const double textHeight = 1.2;
}