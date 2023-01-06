import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';

import 'buttons/base_solid_timer_button.dart';
import 'buttons/rounded_button.dart';

class NewTimerScreen extends StatefulWidget {
  final SolidTimerBloc bloc;

  const NewTimerScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  State<NewTimerScreen> createState() => _NewTimerScreenState();
}

class _NewTimerScreenState extends State<NewTimerScreen> {
  String time = "";

  void amend(String value) {
    if (_isTimeEmpty() && value == "0") return;
    if (time.length < 4) {
      setState(() {
        time += value;
      });
    }
  }

  String formatTime() {
    String tmp = time.padLeft(4, "0");
    return (tmp.substring(0, 2) + ":" + tmp.substring(2, 4));
  }

  void popVal() {
    if (time.isNotEmpty) {
      setState(() {
        time = time.substring(0, time.length - 1);
      });
    }
  }

  void reset() {
    setState(() {
      time = "";
    });
  }

  bool _isTimeEmpty() {
    return time.padLeft(4, "0") == "0000";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(formatTime(),
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontWeight: FontWeight.w300)),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        onPressed: () {
                          amend("1");
                        },
                        child: const Text("1"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("2");
                        },
                        child: const Text("2"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("3");
                        },
                        child: const Text("3"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        onPressed: () {
                          amend("4");
                        },
                        child: const Text("4"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("5");
                        },
                        child: const Text("5"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("6");
                        },
                        child: const Text("6"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        onPressed: () {
                          amend("7");
                        },
                        child: const Text("7"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("8");
                        },
                        child: const Text("8"),
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("9");
                        },
                        child: const Text("9"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        onPressed: () {
                          amend("0");
                          amend("0");
                        },
                        child: const Text("00"),
                        fontSize: 30,
                        padding: 24,
                      ),
                      RoundedButton(
                        onPressed: () {
                          amend("0");
                        },
                        child: const Text("0"),
                      ),
                      RoundedButton(
                        onPressed: popVal,
                        onLongPress: reset,
                        child: const Icon(
                          Icons.backspace_outlined,
                          size: 32,
                        ),
                        padding: 25.5,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BaseSolidTimerButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                  BaseSolidTimerButton(
                    onPressed: !_isTimeEmpty()
                        ? () {
                            var tmp = formatTime().split(":");
                            int minutes = int.parse(tmp[0]);
                            int seconds = int.parse(tmp[1]);
                            widget.bloc.addTimer((minutes * 60) + seconds);
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
