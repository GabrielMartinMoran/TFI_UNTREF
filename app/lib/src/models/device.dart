import 'package:app/src/models/measurement.dart';

class Device {
  String bleId;
  List<Measurement> measurements;
  String name;
  bool active;

  Device({
    this.bleId,
    this.measurements,
    this.name,
    this.active,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        bleId: json["bleId"],
        measurements: List<Measurement>.from(
            json["measurements"].map((x) => Measurement.fromJson(x))),
        name: json["name"],
        active: json["active"],
      );

  List<Measurement> getLasBunchOfTime(double lastSeconds) {
    final filtered = measurements
        .where((x) =>
            DateTime.now().difference(x.datetime).inSeconds <= lastSeconds)
        .toList();
    return filtered;
  }
}
