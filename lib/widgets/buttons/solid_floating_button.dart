import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';

class SolidFloatingButton extends StatelessWidget {
  const SolidFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SolidTimerBloc.of(context);
    return StreamBuilder<int>(
      initialData: bloc.currentPage,
      stream: bloc.pageStream,
      builder: (context, snapshot) {
        return AnimatedRotation(
          duration: const Duration(milliseconds: 200),
          turns: snapshot.data! == 1 ? 1.0 : 0.9,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: snapshot.data! == 1 ? 1.0 : 0.0,
            curve: Curves.easeInOut,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
