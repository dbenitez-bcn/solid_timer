class Timer {
  final int id;
  late final int seconds;

  Timer(this.id, int seconds) {
    this.seconds = seconds < 6000 ? seconds : 5999;
  }

  Timer.fromMap(Map<String, dynamic> map) : id = map["id"] {
    seconds = map["seconds"] < 6000 ? map["seconds"] : 5999;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == runtimeType &&
        (other as Timer).id == id &&
        other.seconds == seconds) {
      return true;
    }
    return false;
  }

  String toClockFormat() {
    int minutes = (this.seconds / 60).truncate();
    int seconds = this.seconds - (minutes * 60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
