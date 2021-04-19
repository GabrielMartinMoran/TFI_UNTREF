class DateConverter {
  static DateTime fromTimestamp(double timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
}
