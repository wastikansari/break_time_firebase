import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class customTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double? width;

  final double? height;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  const customTextField({
    super.key,
     this.controller,
    required this.hintText, this.width, this.height = 50, this.keyboardType, this.textAlign = TextAlign.start, this.onChanged, this.obscureText = false, this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
         inputFormatters: inputFormatters,
        style: const TextStyle(
          fontWeight: FontWeight.w400, 
          fontSize: 16, 
        ),
        onChanged: onChanged,
         textAlign: textAlign,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Color(0xFFD8DADC), fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide( color: Color(0xFFD8DADC),width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color(0xFFD8DADC),width: 1), 
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color(0xFF371382),width: 1),
          ),
        ),
      ),
    );
  }
}
