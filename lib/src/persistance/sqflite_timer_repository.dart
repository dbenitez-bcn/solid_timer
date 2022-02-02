import 'package:solid_timer/src/domain/datasource/timer_repository.dart';
import 'package:solid_timer/src/domain/models/timer.dart';
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
    final list = await database
        .query("timers", columns: ["id", "seconds"]);
    return list.map((e) => Timer.fromMap(e))
        .toList();
  }

  @override
  Future<void> deleteBy({required int id}) async {
    await database.delete("timers",  where: 'id = ?', whereArgs: [id]);
  }

}