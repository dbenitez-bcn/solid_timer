String formatTime(int timeInSeconds) {
  int minutes = (timeInSeconds / 60).truncate();
  int seconds = timeInSeconds - (minutes * 60);
  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}