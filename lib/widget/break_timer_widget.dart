import 'package:break_time/utiles/constants.dart';
import 'package:flutter/material.dart';
import '../widget/button.dart';
import '../widget/custom_text.dart';
import '../providers/break_provider.dart';
import 'package:provider/provider.dart';

class BreakTimerWidget extends StatelessWidget {
  final bool isSmallScreen;
  final Function() onTap;

  const BreakTimerWidget({
    super.key,
    required this.isSmallScreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final breakProvider = Provider.of<BreakProvider>(context);
    final remainingTime = breakProvider.remainingTime;
    final breakData = breakProvider.breakData;

    String _formatDuration(int seconds) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      return '${twoDigits(seconds ~/ 60)}:${twoDigits(seconds % 60)}';
    }

    String _calculateEndTime(int remainingSeconds) {
      try {
        // Use current local time as the base
        DateTime now = DateTime.now().toLocal();
        
        // Calculate end time by adding remaining seconds
        DateTime end = now.add(Duration(seconds: remainingSeconds));
        
        // Format to 12-hour clock
        int hour = end.hour % 12 == 0 ? 12 : end.hour % 12;
        String minute = end.minute.toString().padLeft(2, '0');
        String period = end.hour >= 12 ? 'PM' : 'AM';

        // Debugging logs
        debugPrint('Current Time (local): $now');
        debugPrint('Remaining Seconds: $remainingSeconds');
        debugPrint('End Time (local): $end');
        debugPrint('Formatted End: $hour:$minute $period');

        return '$hour:$minute $period';
      } catch (e) {
        debugPrint('Error in _calculateEndTime: $e');
        return 'Error';
      }
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 361, maxHeight: 450),
      margin: const EdgeInsets.all(25),
      decoration: breakboxDecoration,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: "We value your hard work!\nTake this time to relax",
              size: isSmallScreen ? 15 : 17,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            _buildProgressIndicator(
              context,
              isSmallScreen,
              _formatDuration(remainingTime),
            ),
            SizedBox(height: isSmallScreen ? 30 : 40),
            const Divider(color: Color(0xFF497AD1)),
            const SizedBox(height: 5),
            CustomText(
              text: breakData != null
                  ? "Break ends at ${_calculateEndTime(remainingTime)}"
                  : "Break ends soon",
              size: isSmallScreen ? 15 : 17,
              color: Colors.white,
            ),
            const SizedBox(height: 5),
            const Divider(color: Color(0xFF497AD1)),
            const SizedBox(height: 10),
            ContinueButton(
              text: 'End my break',
              isValid: true,
              bgColor: const Color(0xFFD14343),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context,
    bool isSmallScreen,
    String formattedTime,
  ) {
    final breakProvider = Provider.of<BreakProvider>(context);
    final progress = breakProvider.breakData != null && breakProvider.remainingTime > 0
        ? breakProvider.remainingTime / breakProvider.breakData!.duration
        : 0.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: isSmallScreen ? 130 : 150,
          width: isSmallScreen ? 130 : 150,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Column(
          children: [
            CustomText(
              text: formattedTime,
              color: Colors.white,
              fontweights: FontWeight.bold,
              size: 36,
            ),
            CustomText(
              text: "Break",
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        ..._buildStars(),
      ],
    );
  }

  List<Widget> _buildStars() {
    return const [
      Positioned(
        left: 0,
        top: 0,
        child: Icon(Icons.star, color: Colors.white, size: 20),
      ),
      Positioned(
        left: 30,
        bottom: 0,
        child: Icon(Icons.star, color: Colors.white, size: 20),
      ),
      Positioned(
        right: 0,
        top: 20,
        child: Icon(Icons.star, color: Colors.white, size: 20),
      ),
    ];
  }
}