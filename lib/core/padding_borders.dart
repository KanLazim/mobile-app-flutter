import 'package:flutter/material.dart';

mixin PaddingBorderConstant {
  // Border Radius
  static final BorderRadiusGeometry borderRadiusLow = BorderRadius.circular(5);
  static final BorderRadiusGeometry borderRadius = BorderRadius.circular(10);
  static final BorderRadiusGeometry borderRadiusMedium = BorderRadius.circular(15);
  static final BorderRadiusGeometry borderRadiusHigh = BorderRadius.circular(20);

  // Padding all
  static const EdgeInsetsGeometry paddingAllLow = EdgeInsets.all(5);
  static const EdgeInsetsGeometry paddingAll = EdgeInsets.all(10);
  static const EdgeInsetsGeometry paddingAllMedium = EdgeInsets.all(15);
  static const EdgeInsetsGeometry paddingAllHigh = EdgeInsets.all(20);

  // Padding Horizontal
  static const EdgeInsetsGeometry paddingHorizontalLow = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsetsGeometry paddingHorizontal = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsetsGeometry paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: 15);
  static const EdgeInsetsGeometry paddingHorizontalHigh = EdgeInsets.symmetric(horizontal: 20);

  // Padding Vertical
  static const EdgeInsetsGeometry paddingVerticalLow = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsetsGeometry paddingVertical = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsetsGeometry paddingVerticalMedium = EdgeInsets.symmetric(vertical: 15);
  static const EdgeInsetsGeometry paddingVerticalHigh = EdgeInsets.symmetric(vertical: 20);

  // Padding only right
  static const EdgeInsetsGeometry paddingOnlyRightLow = EdgeInsets.only(right: 5);
  static const EdgeInsetsGeometry paddingOnlyRight = EdgeInsets.only(right: 10);
  static const EdgeInsetsGeometry paddingOnlyRightMedium = EdgeInsets.only(right: 15);
  static const EdgeInsetsGeometry paddingOnlyRightHigh = EdgeInsets.only(right: 20);

  // Padding only right
  static const EdgeInsetsGeometry paddingOnlyLeftLow = EdgeInsets.only(left: 5);
  static const EdgeInsetsGeometry paddingOnlyLeft = EdgeInsets.only(left: 10);
  static const EdgeInsetsGeometry paddingOnlyLeftMedium = EdgeInsets.only(left: 15);
  static const EdgeInsetsGeometry paddingOnlyLeftHigh = EdgeInsets.only(left: 20);

  // Padding only right
  static const EdgeInsetsGeometry paddingOnlyBottomLow = EdgeInsets.only(bottom: 5);
  static const EdgeInsetsGeometry paddingOnlyBottom = EdgeInsets.only(bottom: 10);
  static const EdgeInsetsGeometry paddingOnlyBottomMedium = EdgeInsets.only(bottom: 15);
  static const EdgeInsetsGeometry paddingOnlyBottomHigh = EdgeInsets.only(bottom: 20);

  // Padding only right
  static const EdgeInsetsGeometry paddingOnlyTopLow = EdgeInsets.only(top: 5);
  static const EdgeInsetsGeometry paddingOnlyTop = EdgeInsets.only(top: 10);
  static const EdgeInsetsGeometry paddingOnlyTopMedium = EdgeInsets.only(top: 15);
  static const EdgeInsetsGeometry paddingOnlyTopHigh = EdgeInsets.only(top: 20);
}
