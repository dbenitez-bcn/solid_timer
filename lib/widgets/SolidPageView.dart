import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/widgets/pages/solid_timer_page.dart';

class SolidPageView extends StatelessWidget {
  const SolidPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SolidTimerBloc.of(context);
    var pageController = PageController(
      initialPage: bloc.currentPage,
    );
    bloc.pageStream.listen((page) {
      pageController.animateToPage(page, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
    return PageView(
      controller: pageController,
      onPageChanged: bloc.updatePage,
      children: const [
        SolidTimerPage(),
        Center(
          child: Text('Second Page'),
        ),
      ],
    );
  }
}
