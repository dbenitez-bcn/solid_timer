import 'package:flutter/material.dart';

class BaseSolidTimerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const BaseSolidTimerButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 75,
        child: OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
