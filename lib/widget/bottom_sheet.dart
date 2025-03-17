import 'package:break_time/widget/button.dart';
import 'package:break_time/widget/custom_text.dart';
import 'package:break_time/widget/size_box.dart';
import 'package:flutter/material.dart';


class ConfirmationBottomSheet extends StatelessWidget {
  final Function endNowTap;
  const ConfirmationBottomSheet({super.key, required this.endNowTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 232,
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFD1D1D1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const Height(25),
            CustomText(
              text: "Ending break early?",
              size: 20,
              color: const Color(0xFF0F173F),
              fontweights: FontWeight.w600,
              height: 1.20,
            ),
            const Height(20),
            CustomText(
              text: "Are you sure you want to end your break now? Take this time to recharge before your next task.",
              size: 15,
              color: const Color(0xFF515770),
              fontweights: FontWeight.w500,
              height: 1.33,
              letterSpacing: -0.24,
              overFlow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            const Height(25),
            Row(
              children: [
                Expanded(
                  child: ContinueButton(
                    text: 'Continue',
                    bgColor: const Color(0xFF429777),
                    isValid: true,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const Widths(8),
                Expanded(
                  child: ContinueButton(
                    text: 'End now',
                    bgColor: Colors.white,
                    isValid: true,
                    onTap: () {
                      endNowTap();
                      Navigator.pop(context);
                    },
                    textColor: const Color(0xFFA73636),
                    border: Border.all(color: const Color(0xFFA73636)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}