import 'package:flutter/material.dart';

class BaseSolidTimerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget child;

  const BaseSolidTimerButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      child: OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
