// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/extensions.dart';

class CustomMainButton extends StatefulWidget {
  CustomMainButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isOutline,
    this.margin,
    required this.buttonWidth,
  });
  final void Function() onPressed;
  final String text;
  final bool? isOutline;
  final double buttonWidth;
  EdgeInsetsGeometry? margin;

  @override
  State<CustomMainButton> createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.margin,
        height: 50,
        width: context.deviceWidth * widget.buttonWidth,
        child: (widget.isOutline ?? false)
            ? OutlinedButton(
                style:
                    ButtonStyle(side: WidgetStateProperty.all(const BorderSide(color: ColorsConstant.redFrame, width: 2))),
                onPressed: widget.onPressed,
                child: _text(context, ColorsConstant.redText))
            : ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorsConstant.red)),
                onPressed: widget.onPressed,
                child: _text(context, Colors.white)));
  }

  Text _text(BuildContext context, Color textColor) {
    return Text(
      widget.text,
      style: context.textTheme.titleMedium?.copyWith(color: textColor),
    );
  }
}
