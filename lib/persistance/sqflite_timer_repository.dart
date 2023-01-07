import 'package:solid_timer/domain/datasource/timer_repository.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteTimerRepository extends TimerRepository {
  final Database database;

  SqfliteTimerRepository(this.database);

  @override
  Future<SolidTimer> create(int work, int? rest, int? rounds) async {
    int id = await database.insert("timers", {"work": work, "rest": rest, "rounds": rounds});
    return SolidTimer(id, work, rest, rounds);
  }

  @override
  Future<List<SolidTimer>> getAll() async {
    final list = await database.query("timers", columns: ["id", "work", "rest", "rounds"]);
    return list.map((e) => SolidTimer.fromMap(e)).toList();
  }

  @override
  Future<void> deleteBy({required int id}) async {
    await database.delete("timers", where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<SolidTimer?> getLastSelectedTimer() async {
    var timers = await database.query("last_selected_timer", where: "id = 1");
    if (timers.isNotEmpty) {
      return SolidTimer.fromMap(timers.first);
    } else {
      return null;
    }
  }

  @override
  Future<SolidTimer> updateLastSelectedTimer(SolidTimer timer) async {
    await database.update(
      "last_selected_timer",
      {"work": timer.work.seconds, "rest": timer.rest?.seconds, "rounds": timer.rounds},
      where: "id = 1",
    );

    return SolidTimer(1, timer.work.seconds, timer.rest?.seconds, timer.rounds);
  }
}
