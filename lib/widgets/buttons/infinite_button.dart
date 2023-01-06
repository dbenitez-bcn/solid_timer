import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';

class InfiniteButton extends StatelessWidget {
  const InfiniteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SolidTimerBloc.of(context);
    return StreamBuilder(
        initialData: bloc.isInfiniteRoundsEnabled,
        stream: bloc.infiniteRoundsStream,
        builder: (context, snapshot) {
          return OutlinedButton(
            onPressed: () async {
              await bloc.toggleInfinite();
            },
            style: OutlinedButton.styleFrom(shape: const CircleBorder()),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(
                Icons.repeat,
                color: snapshot.data!
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          );
        });
  }
}
