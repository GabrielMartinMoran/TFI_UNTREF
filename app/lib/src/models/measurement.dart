import 'package:app/src/utils/date_converter.dart';

class Measurement {
  Measurement({
    this.current,
    this.power,
    this.timestamp,
    this.voltage,
  });

  double current;
  double power;
  double timestamp;
  double voltage;

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
        current: json["current"].toDouble(),
        power: json["power"].toDouble(),
        timestamp: json["timestamp"].toDouble(),
        voltage: json["voltage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "power": power,
        "timestamp": timestamp,
        "voltage": voltage,
      };

  DateTime get utcDatetime {
    return DateConverter.toUTCfromTimestamp(timestamp);
  }
}
