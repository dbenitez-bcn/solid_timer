import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/domain/models/timer.dart';

class TimerProgressIndicator extends StatefulWidget {
  final Timer timer;

  const TimerProgressIndicator({Key? key, required this.timer})
      : super(key: key);

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String get _timerString {
    Duration duration = _controller.duration! * (1 - _controller.value);
    return '${(duration.inMinutes).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _onStatusChange(Status status) {
    if (mounted) {
      switch (status) {
        case Status.ready:
          _controller.reset();
          break;
        case Status.playing:
          _controller.repeat();
          break;
        case Status.waiting:
          _controller.stop();
          break;
      }
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.timer.seconds),
    );
    _animation = Tween<double>(begin: 0.0, end: 1).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  void _onTimerSelected(Timer timer) {
    if (mounted) {
      setState(() {
        _controller = AnimationController(
          vsync: this,
          duration: Duration(seconds: timer.seconds),
        );
        _animation = Tween<double>(begin: 0.0, end: 1).animate(_controller);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SolidTimerBloc.of(context).status.listen(_onStatusChange);
    SolidTimerBloc.of(context).selectedTimer.listen(_onTimerSelected);

    return Stack(alignment: AlignmentDirectional.center, children: [
      AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          return Text(
            _timerString,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontWeight: FontWeight.w300),
          );
        },
      ),
      Positioned.fill(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: TimerPainter(
                percentage: _animation.value,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      ),
    ]);
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
      ..strokeCap = StrokeCap.round
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
