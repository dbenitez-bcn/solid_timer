import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solid_timer/src/domain/models/timer.dart';
import 'package:solid_timer/src/persistance/sqflite_timer_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'sqflite_timer_repository_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  MockDatabase database = MockDatabase();
  final SqfliteTimerRepository sut = SqfliteTimerRepository(database);
  test("given a seconds should create the timer", () async {
    final Timer timer = Timer(1, 10);
    when(database.insert("timers", {"seconds": 10})).thenAnswer((_) async => 1);

    Timer got = await sut.create(seconds: 10);

    expect(got, timer);
  });

  test("Should return all timers", () async {
    when(database.query("timers", columns: ["id", "seconds"]))
        .thenAnswer((_) async => [
              {"id": 1, "seconds": 10},
              {"id": 2, "seconds": 15}
            ]);
    List<Timer> got = await sut.getAll();

    expect(got, [Timer(1, 10), Timer(2, 15)]);
  });

  test("given an id should delete the timer", () async {
    when(database.delete("timers",  where: 'id = ?', whereArgs: [1])).thenAnswer((_) async => 1);

    await sut.deleteBy(id: 1);

    verify(database.delete("timers",  where: 'id = ?', whereArgs: [1]));
  });
}
