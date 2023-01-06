import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';

class MutedButton extends StatelessWidget {
  const MutedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SolidTimerBloc.of(context);
    return StreamBuilder(
        initialData: bloc.isSoundEnabled,
        stream: bloc.soundStream,
        builder: (context, snapshot) {
          return OutlinedButton(
            onPressed: () async {
              await bloc.toggleSound();
            },
            style: OutlinedButton.styleFrom(shape: const CircleBorder()),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(
                snapshot.data! ? Icons.volume_up : Icons.volume_off,
                color: snapshot.data!
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          );
        });
  }
}
