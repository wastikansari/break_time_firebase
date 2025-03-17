import 'package:flutter/material.dart';

class AnimatedCircularProgressBar extends StatefulWidget {
  final double progress; // Value between 0.0 to 1.0
  final double size;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  const AnimatedCircularProgressBar({
    super.key,
    required this.progress,
    this.size = 100.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 8.0,
  });

  @override
  _AnimatedCircularProgressBarState createState() =>
      _AnimatedCircularProgressBarState();
}

class _AnimatedCircularProgressBarState
    extends State<AnimatedCircularProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.progress)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _controller.reset();
      _animation = Tween<double>(begin: _animation.value, end: widget.progress)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: widget.strokeWidth,
            backgroundColor: widget.backgroundColor,
          ),
          CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: widget.strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
          ),
        ],
      ),
    );
  }
}
