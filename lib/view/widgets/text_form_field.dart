import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.label,
    this.suffixIcon,
    required this.prefixIcon,
    this.isPass = false,
    required this.controller,
    required this.validation,
    required this.inputType,
    this.suffixPressed,
    this.onChanged,
    this.onSubmit,
  }) : super(key: key);
  final String label;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final bool isPass;
  final TextEditingController controller;
  final FormFieldValidator validation;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;
  final TextInputType inputType;
  VoidCallback? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          controller: controller,
          validator: validation,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: IconButton(
              icon: Icon(suffixIcon),
              onPressed: suffixPressed,
            ),
          ),
          obscureText: isPass,
          keyboardType: inputType,
          onFieldSubmitted: onSubmit),
    );
  }
}
