class Timer {
  final int id;
  final int seconds;

  Timer(this.id, this.seconds);

  Timer.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        seconds = map["seconds"];

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
