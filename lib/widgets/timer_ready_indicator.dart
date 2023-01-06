import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';

class TimerReadyIndicator extends StatelessWidget {
  const TimerReadyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SolidTimer>(
      initialData: SolidTimerBloc.of(context).currentTimer,
      stream: SolidTimerBloc.of(context).selectedTimer,
      builder: (context, snapshot) {
        return AnimatedOpacity(
          opacity: snapshot.hasData ? 1 : 0,
          duration: const Duration(microseconds: 250),
          child: snapshot.hasData
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      snapshot.data!.work.toClockFormat(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: CirclePainter(),
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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
