import 'package:app/src/utils/platform_checker.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

class DateConverter {
  // ignore: avoid_init_to_null
  static String timezoneLocation = null;

  static void initialize() {
    if (!PlatformChecker.isWeb()) {
      getLocalTimezone();
      tzd.initializeTimeZones();
    }
    print(
        'Zona horaria a utilizar: ${timezoneLocation ?? DateTime.now().timeZoneName}');
  }

  static void getLocalTimezone() {
    FlutterNativeTimezone.getLocalTimezone().then((value) {
      timezoneLocation = value;
    });
  }

  static DateTime fromTimestamp(double timestamp) {
    if (timezoneLocation == null)
      return toUTCfromTimestamp(timestamp).toLocal();
    final location = _getTimezoneLocation();
    final dTime = tz.TZDateTime.from(toUTCfromTimestamp(timestamp), location);
    return dTime;
  }

  static DateTime toUTCfromTimestamp(double timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);

  static tz.Location _getTimezoneLocation() {
    final locationKey = tz.timeZoneDatabase.locations.keys.firstWhere(
        (x) => x.split('/').last == timezoneLocation.split('/').last);
    return tz.timeZoneDatabase.get(locationKey);
  }
}
