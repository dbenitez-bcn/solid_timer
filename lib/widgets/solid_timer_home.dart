import 'package:flutter/material.dart';
import 'package:solid_timer/widgets/buttons/solid_floating_button.dart';
import 'package:solid_timer/widgets/solid_page_view.dart';

import 'solid_navigation_bar.dart';

class SolidTimerHome extends StatelessWidget {
  const SolidTimerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SolidPageView(),
      bottomNavigationBar: SolidNavigationBar(),
      floatingActionButton: SolidFloatingButton(),
    );
  }
}
