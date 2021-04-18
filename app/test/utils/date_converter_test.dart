import 'package:app/src/utils/date_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'toUTCfromTimestamp returns UTC datetime when called with double timestamp',
      () {
    double timestamp = 1618781493;

    DateTime result = DateConverter.toUTCfromTimestamp(timestamp);

    expect(result.toString(), '2021-04-18 21:31:33.000Z');
  });
}
