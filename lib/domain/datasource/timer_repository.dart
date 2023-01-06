import 'package:solid_timer/domain/models/timer.dart';

abstract class TimerRepository {
  Future<List<Timer>> getAll();
  Future<Timer> create({required int seconds});
  Future<void> deleteBy({required int id});
  Future<Timer?> getLastSelectedTimer();
  Future<Timer> updateLastSelectedTimer(Timer timer);
}