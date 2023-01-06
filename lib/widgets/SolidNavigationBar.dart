import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';

class SolidNavigationBar extends StatelessWidget {
  const SolidNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SolidTimerBloc bloc = SolidTimerBloc.of(context);
    return StreamBuilder<int>(
      initialData: bloc.currentPage,
      stream: bloc.pageStream,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          currentIndex: snapshot.data!,
          onTap: bloc.updatePage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_rounded), label: "Timer"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "My timers"),
          ],
        );
      },
    );
  }
}
