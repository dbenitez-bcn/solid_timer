import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width - 24.0,
      height: MediaQuery.of(context).size.width - 24.0,
      color: Colors.black,
      child: const TimerProgressIndicator(
        percentage: 1,
      ),
    ));
  }
}

class TimerProgressIndicator extends StatelessWidget {
  final double percentage;

  const TimerProgressIndicator({Key? key, required this.percentage})
      : assert(percentage >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TimerPainter(percentage),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double percentage;

  TimerPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(size, canvas);
    _drawArc(size, canvas);
  }

  void _drawArc(Size size, Canvas canvas) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const start = -math.pi / 2;
    final end = (2 * math.pi) * percentage;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rect, start, end, false, paint);
  }

  void _drawCircle(Size size, Canvas canvas) {
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
