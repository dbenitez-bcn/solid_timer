import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';

class TimerProgressIndicator extends StatefulWidget {
  final SolidTimer timer;

  const TimerProgressIndicator({Key? key, required this.timer})
      : super(key: key);

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // bool _soundPlayed = false;
  bool _isRestPlaying = false;
  int? sets;

  // void sound() {
  //   if (!_soundPlayed) {
  //     Duration duration = _controller.duration! * (1 - _controller.value);
  //     if (duration.inSeconds == 3) {
  //       _soundPlayed = true;
  //       print("Sound!");
  //     }
  //   }
  // }

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
          _controller.forward();
          break;
        case Status.waiting:
          _controller.stop();
          break;
      }
    }
  }

  @override
  void initState() {
    sets = widget.timer.rounds;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.timer.work.seconds),
    );
    _animation = Tween<double>(begin: 0.0, end: 1).animate(_controller);
    // _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SolidTimerBloc.of(context).status.listen(_onStatusChange);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_isRestPlaying) {
          _controller.duration = Duration(seconds: widget.timer.work.seconds);
          if (sets != null) {
            sets = sets! - 1;
            if (sets == 0) {
              SolidTimerBloc.of(context).stop();
            }
          }
          _isRestPlaying = false;
          _controller.reset();
          _controller.forward();
        } else {
          if (widget.timer.rest == null) {
            if (sets != null) {
              sets = sets! - 1;
              if (sets == 0) {
                SolidTimerBloc.of(context).stop();
              }
            }
          } else {
            _isRestPlaying = true;
            _controller.duration = Duration(seconds: widget.timer.rest!.seconds);
          }
          _controller.reset();
          _controller.forward();
        }
      } else if (status == AnimationStatus.forward) {
        print("Animation forward");
      } else if (status == AnimationStatus.dismissed) {
        print("Animation dismissed");
      } else if (status == AnimationStatus.reverse) {
        print("Animation reverse");
      }
    });

    return Stack(alignment: AlignmentDirectional.center, children: [
      AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sets == null
                  ? const Text("")
                  : Text(sets! > 1 ? "x$sets" : "last_set".i18n(), style: Theme.of(context)
                  .textTheme
                  .headlineSmall,),
              Text(
                _timerString,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontWeight: FontWeight.w300),
              ),
              Text(_isRestPlaying ? "rest".i18n() : "work".i18n(),
              style: Theme.of(context).textTheme.displaySmall,),
            ],
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
