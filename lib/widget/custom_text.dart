import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  final Color? color;
  final Color? decorationColor;
  final String text;
  final FontWeight? fontweights;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  double size;
  TextOverflow overFlow;
  CustomText({
    super.key,
    this.color = Colors.black,
    required this.text,
    this.size = 13,
    this.overFlow = TextOverflow.ellipsis,
    this.fontweights = FontWeight.normal,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
        fontFamily: Theme.of(context)
            .textTheme
            .bodyMedium
            .toString(), // 'VremenaGroteskBook',
        fontSize: size,
        fontWeight: fontweights,
        color: color,
      ),
    );
  }
}
