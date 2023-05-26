import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isDense;
  final String labelText;
  final Widget? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String errorValidation;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.isDense = true,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    required this.errorValidation,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[900]!),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          isDense: widget.isDense,
          // labelText: widget.labelText,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          errorStyle: TextStyle(color: Colors.red[900])),
      obscureText: widget.obscureText,
      validator: (value) {
        if (value == '') {
          return widget.errorValidation;
        } else {
          return null;
        }
      },
    );
  }
}
