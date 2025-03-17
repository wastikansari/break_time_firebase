import 'package:break_time/widget/custom_text.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final bool isValid;
  final Function() onTap;
  final Color? bgColor;
  final Color?  textColor;
  final BoxBorder? border;
  final bool isLoading;

  const ContinueButton(
      {super.key,
      required this.text,
      required this.isValid,
      required this.onTap,
      this.bgColor = const Color(0xFF371382), this.border, this.textColor = Colors.white, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            border: border,
              color: isValid ? bgColor : const Color(0xFFEAEAF1),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: isLoading ?  const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.white,),
              ) : CustomText(
            text: text,
            color: isValid ? textColor : const Color(0xFFBCBCCD),
            size: 16,
          )
         
          
          )),
    );
  }
}
