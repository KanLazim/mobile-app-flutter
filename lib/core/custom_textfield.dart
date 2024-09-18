// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.isPassword,
    required this.controller,
    this.validator,
    this.keyboardType, // Klavye türü parametresi eklendi
  });
  final String labelText;
  final bool? isPassword;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType; // Klavye türü parametresi eklendi

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isSecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: (widget.isPassword ?? false) ? (_isSecure ? true : false) : false,
      keyboardType: widget.keyboardType, // Klavye türü parametresi geçirildi
      decoration: InputDecoration(
          suffixIcon: (widget.isPassword ?? false)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSecure = !_isSecure;
                    });
                  },
                  child: Container(
                    constraints: BoxConstraints.loose(Size.zero),
                    alignment: Alignment.center,
                    child: AnimatedCrossFade(
                        firstChild: const Icon(Icons.visibility_off_outlined),
                        secondChild: const Icon(Icons.visibility),
                        crossFadeState: _isSecure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 350)),
                  ),
                )
              : const SizedBox.shrink(),
          label: Text(
            widget.labelText,
            style: context.textTheme.titleSmall?.copyWith(color: Colors.grey.shade600),
          )),
    );
  }
}
