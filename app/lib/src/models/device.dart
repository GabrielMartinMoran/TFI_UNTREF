import 'package:app/src/models/measurement.dart';

class Device {
  Device({
    this.bleId,
    this.measurements,
    this.name,
  });

  String bleId;
  List<Measurement> measurements;
  String name;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        bleId: json["bleId"],
        measurements: List<Measurement>.from(
            json["measurements"].map((x) => Measurement.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "bleId": bleId,
        "measurements": List<dynamic>.from(measurements.map((x) => x.toJson())),
        "name": name,
      };

  List<Measurement> getLasBunchOfTime(double lastSeconds) {
    final filtered = measurements
        .where((x) =>
            DateTime.now().difference(x.datetime).inSeconds <= lastSeconds)
        .toList();
    return filtered;
  }
}
