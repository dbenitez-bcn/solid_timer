import 'dart:math' as math;

import 'package:flutter/material.dart';


class TimerProgressIndicator extends StatefulWidget {
  final int duration;

  const TimerProgressIndicator({Key? key, required this.duration})
      : assert(duration >= 0),
        super(key: key);

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1)
        .animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: TimerPainter(
            percentage: _animation.value,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TimerPainter extends CustomPainter {
  final double percentage;
  final Color color;

  TimerPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    _drawOutline(size, canvas);
    _drawProgress(size, canvas);
  }

  void _drawProgress(Size size, Canvas canvas) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const start = -math.pi / 2;
    final end = (2 * math.pi) * percentage;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rect, start, end, false, paint);
  }

  void _drawOutline(Size size, Canvas canvas) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
