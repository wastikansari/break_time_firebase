import 'package:break_time/utiles/colors.dart';
import 'package:break_time/widget/custom_text.dart';
import 'package:break_time/widget/size_box.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final String text;
  final bool value;
  void Function(bool?) onChanged;
  final double borderRadius;
  CheckBox(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged,
      this.borderRadius = 50.00});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
              value: widget.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadius), // Border Radius 50
              ),

              // checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) => widget.value
                    ? AppColor.primaryColor
                    : AppColor.backgroundColors,
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(
                  color: widget.value
                      ? AppColor.primaryColor
                      : const Color(0xFFD8DAE5),
                  width: 2,
                ),
              ),
              onChanged: widget.onChanged),
        ),
        const Widths(10),
        CustomText(
          text: widget.text,
          letterSpacing: -0.24,
          color: const Color(0xff525871),
          fontweights: FontWeight.w400,
        )
      ],
    );
  }
}
