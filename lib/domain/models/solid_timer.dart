import 'package:solid_timer/domain/models/timer.dart';

class SolidTimer {
  final int id;
  final Timer work;
  final Timer? rest;
  final int? rounds;

  SolidTimer(this.id, int work, int? rest, this.rounds)
      : work = Timer(work),
        rest = rest != null ? Timer(rest) : null;

  SolidTimer.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        work = Timer(map["work"]),
        rest = map["rest"] != null ? Timer(map["rest"]) : null,
        rounds = map["rounds"];

  String toStringFormat() {
    int total = work.seconds;
    if (rest != null) {
      total += rest!.seconds;
    }
    if (rounds != null) {
      total *= rounds!;
    }
    int minutes = (total / 60).truncate();
    int seconds = total - (minutes * 60);
    return "${minutes > 0 ? "${minutes.toString().padLeft(2, '0')}' " : ""}${seconds.toString().padLeft(2, '0')}''";
  }
}
