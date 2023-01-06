import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function() onPressed;
  final Function()? onLongPress;
  final Widget child;
  final double fontSize;
  final double padding;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.onLongPress,
    double? fontSize,
    double? padding,
  })  : fontSize = fontSize ?? 32,
        padding = padding ?? 32,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
      style: ElevatedButton.styleFrom(
          textStyle:
              Theme.of(context).textTheme.button?.copyWith(fontSize: fontSize),
          shape: const CircleBorder(),
          padding: EdgeInsets.all(padding),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0),
    );
  }
}
