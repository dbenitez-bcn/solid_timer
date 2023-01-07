import 'package:flutter/material.dart';
import 'package:solid_timer/widgets/buttons/base_solid_timer_button.dart';
import 'package:solid_timer/widgets/pages/new_timer_page.dart';

class AddTimerButton extends BaseSolidTimerButton {
  AddTimerButton.enabled({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => NewTimerPage(
                onSave: (timer) {},
              ),
            ));
          },
          child: const Icon(Icons.add),
        );

  const AddTimerButton.disabled({Key? key})
      : super(
          key: key,
          onPressed: null,
          child: const Icon(Icons.add),
        );
}
