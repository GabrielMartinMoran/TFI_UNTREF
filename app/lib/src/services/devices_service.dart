import 'package:app/src/models/device.dart';
import 'package:app/src/services/base_service.dart';
import 'dart:convert';

class DevicesService extends BaseService {
  Future<List<Device>> getDevicesData() async {
    final response = await get('/get_data');
    return _devicesFromJson(response.body);
  }

  List<Device> _devicesFromJson(String str) =>
      List<Device>.from(json.decode(str).map((x) => Device.fromJson(x)));
}
