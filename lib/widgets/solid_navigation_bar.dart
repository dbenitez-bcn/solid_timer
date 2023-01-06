import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
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
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.timer), label: "timer".i18n()),
            BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: "saved".i18n()),
          ],
        );
      },
    );
  }
}
