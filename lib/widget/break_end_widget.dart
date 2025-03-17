import 'package:break_time/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../widget/custom_text.dart';
import '../widget/size_box.dart';


class BreakEndedWidget extends StatelessWidget {
  const BreakEndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 361, maxHeight: 450),
      margin: const EdgeInsets.all(25),
      decoration: breakboxDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarGlow(
              child: const Material(
                elevation: 2.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(Icons.check, color: Colors.green),
                ),
              ),
            ),
            const Height(50),
            CustomText(
              text: "Hope you are feeling refreshed and ready to start working again",
              size: 16,
              color: Colors.white,
              overFlow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}