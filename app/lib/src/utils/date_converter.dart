import 'dart:io';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class DateConverter {
  static String timezoneLocation = '';

  static void getLocalTimezone() {
    FlutterNativeTimezone.getLocalTimezone().then((value) {
      timezoneLocation = value;
    });
  }

  static DateTime fromTimestamp(double timestamp) {
    if (timezoneLocation.isEmpty)
      return DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
    final locationKey = tz.timeZoneDatabase.locations.keys.firstWhere(
        (x) => x.split('/').last == timezoneLocation.split('/').last);
    final location = tz.timeZoneDatabase.get(locationKey);
    final dTime = tz.TZDateTime.from(
        DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000),
        location);
    return dTime;
  }
}
