import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';

class TimersListPage extends StatelessWidget {
  const TimersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<SolidTimer>>(
          stream: SolidTimerBloc.of(context).timers,
          initialData: SolidTimerBloc.of(context).timersList,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var solidTimer = snapshot.data![i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  SolidTimerBloc.of(context)
                                      .select(solidTimer);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        solidTimer.toStringFormat(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "time".i18n(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                                Text(solidTimer.work
                                                    .toClockFormat())
                                              ],
                                            ),
                                          ),
                                          if (solidTimer.rest != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "rest".i18n(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  Text(solidTimer.rest!
                                                      .toClockFormat())
                                                ],
                                              ),
                                            ),
                                          if (solidTimer.rounds != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "rounds".i18n(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  Text(
                                                      "${solidTimer.rounds!}")
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                SolidTimerBloc.of(context)
                                    .select(solidTimer);
                              },
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.grey,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            GestureDetector(
                              onTap: () {
                                SolidTimerBloc.of(context)
                                    .remove(solidTimer.id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
