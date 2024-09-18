import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/extensions.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    {required BuildContext context, required String title, required bool isNegative}) {
  final snackBar = SnackBar(
      content: Center(
          child: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
      )),
      backgroundColor: isNegative ? ColorsConstant.red : Colors.green);
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
