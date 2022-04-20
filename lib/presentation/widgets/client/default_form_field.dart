import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class DefaultFormField extends StatelessWidget {
  final IconData? prefixcIcon;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? textInputType;

  final TextEditingController controller;
  const DefaultFormField({
    Key? key,
    required this.controller,
    this.prefixcIcon,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.validator,
    required this.isPassword,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: textInputType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixcIcon,
          color: loginIconsSuffixAndPrefixColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 30),
        labelStyle: TextStyle(
          color: labelColorInTextField,
          letterSpacing: 2,
        ),
        labelText: labelText,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: focusColorInTextField, width: 2.0),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
