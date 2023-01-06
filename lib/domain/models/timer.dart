class Timer {
  late final int seconds;

  Timer(int seconds) {
    this.seconds = seconds < 6000 ? seconds : 5999;
  }

  Timer.fromMap(Map<String, dynamic> map) {
    seconds = map["seconds"] < 6000 ? map["seconds"] : 5999;
  }

  String toClockFormat() {
    int minutes = (this.seconds / 60).truncate();
    int seconds = this.seconds - (minutes * 60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
