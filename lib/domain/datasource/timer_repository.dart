import 'package:solid_timer/domain/models/solid_timer.dart';

abstract class TimerRepository {
  Future<List<SolidTimer>> getAll();
  Future<SolidTimer> create(int work, int? rest, int? rounds);
  Future<void> deleteBy({required int id});
  Future<SolidTimer?> getLastSelectedTimer();
  Future<SolidTimer> updateLastSelectedTimer(SolidTimer timer);
}