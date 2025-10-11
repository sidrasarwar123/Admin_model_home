import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validate;

  const CustomTextField({
    super.key,
    this.validate,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validate, // ✅ validator added here
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey.shade500)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
