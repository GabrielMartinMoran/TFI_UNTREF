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

  DateTime get datetime {
    return DateConverter.fromTimestamp(timestamp);
  }

  Measurement clone() {
    return new Measurement(
        current: current, power: power, timestamp: timestamp, voltage: voltage);
  }
}
