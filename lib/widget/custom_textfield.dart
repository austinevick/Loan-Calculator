import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;

  const CustomTextfield({
    Key? key,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.words,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            onChanged: onChanged,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            textInputAction: textInputAction,
            controller: controller,
            cursorWidth: 1.0,
            obscureText: obscureText,
            validator: validator,
            textCapitalization: textCapitalization,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
