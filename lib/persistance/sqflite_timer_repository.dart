import 'package:solid_timer/domain/datasource/timer_repository.dart';
import 'package:solid_timer/domain/models/timer.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteTimerRepository extends TimerRepository {
  final Database database;

  SqfliteTimerRepository(this.database);

  @override
  Future<Timer> create({required int seconds}) async {
    int id = await database.insert("timers", {"seconds": seconds});
    return Timer(id, seconds);
  }

  @override
  Future<List<Timer>> getAll() async {
    final list = await database.query("timers", columns: ["id", "seconds"]);
    return list.map((e) => Timer.fromMap(e)).toList();
  }

  @override
  Future<void> deleteBy({required int id}) async {
    await database.delete("timers", where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Timer?> getLastSelectedTimer() async {
    var timers = await database.query("last_selected_timer", where: "id = 1");
    if (timers.isNotEmpty) {
      return Timer.fromMap(timers.first);
    } else {
      return null;
    }
  }

  @override
  Future<Timer> updateLastSelectedTimer(Timer timer) async {
    await database.update(
      "last_selected_timer",
      {"seconds": timer.seconds},
      where: "id = 1",
    );

    return Timer(1, timer.seconds);
  }
}
