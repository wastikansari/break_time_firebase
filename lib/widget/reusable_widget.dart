import 'package:break_time/widget/custom_text.dart';
import 'package:flutter/material.dart';

Widget sectionHeader(String text, {double size = 13.00}) {
  return CustomText(
    text: text,
    size: size,
    color: const Color(0xFF101840),
    fontweights: FontWeight.w600,
    height: 1.4,
    overFlow: TextOverflow.visible,
  );
}
