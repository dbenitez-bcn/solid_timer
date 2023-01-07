import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/models/timer.dart';
import 'package:solid_timer/widgets/pages/new_timer_page.dart';

class NewSolidTimerPage extends StatefulWidget {
  const NewSolidTimerPage({Key? key}) : super(key: key);

  @override
  State<NewSolidTimerPage> createState() => _NewSolidTimerPageState();
}

class _NewSolidTimerPageState extends State<NewSolidTimerPage> {
  var workTimer = Timer(30);
  var restTimer = Timer(30);
  var rounds = 0;
  bool isRestEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.black,
        title: Text("new_timer".i18n()),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                      child: Column(
                        children: [
                          Text(
                            "work".i18n().toUpperCase(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewTimerPage(
                                  onSave: (Timer timer) {
                                    setState(() {
                                      workTimer = timer;
                                    });
                                  },
                                ),
                              ),
                            ),
                            child: Text(
                              workTimer.toClockFormat(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "rest".i18n().toUpperCase(),
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Switch(
                                  value: isRestEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      isRestEnabled = value;
                                    });
                                  })
                            ],
                          ),
                          GestureDetector(
                            onTap: isRestEnabled
                                ? () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewTimerPage(
                                          onSave: (Timer timer) {
                                            setState(() {
                                              restTimer = timer;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                : null,
                            child: Text(
                              isRestEnabled
                                  ? restTimer.toClockFormat()
                                  : "00:00",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isRestEnabled
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              "rounds".i18n().toUpperCase(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: rounds > 0
                                      ? () {
                                          setState(() {
                                            rounds -= 1;
                                          });
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.remove,
                                    size: 48.0,
                                    color:
                                        rounds > 0 ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Text(
                                  "$rounds",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: rounds > 0
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: rounds < 99
                                      ? () {
                                          setState(() {
                                            rounds += 1;
                                          });
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.add,
                                    size: 48.0,
                                    color: rounds < 99
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    SolidTimerBloc.of(context).addTimer(
                        workTimer.seconds,
                        isRestEnabled ? restTimer.seconds : null,
                        rounds > 0 ? rounds : null);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    "save".i18n(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
