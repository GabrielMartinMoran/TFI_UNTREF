import 'package:app/src/configs/pallete.dart';
import 'package:flutter/material.dart';

class TimeSlider extends StatefulWidget {
  final Function onChange;
  TimeSlider({Key key, this.onChange}) : super(key: key);

  @override
  _TimeSliderState createState() => _TimeSliderState(onChange);
}

class _TimeSliderState extends State<TimeSlider> {
  final Function onChange;
  double sliderValue = 0;
  final _valuesMap = {
    0: [60.0, '1 minuto'],
    1: [60.0 * 5, '5 minutos'],
    2: [60.0 * 30, '30 minutos'],
    3: [60.0 * 60 * 1, '1 hora'],
    4: [60.0 * 60 * 2, '2 horas']
  };

  _TimeSliderState(this.onChange);

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Pallete.primary,
      inactiveColor: Pallete.primary.withOpacity(0.3),
      value: sliderValue,
      onChanged: (double value) {
        setState(() {
          sliderValue = value;
          onChange(_sliderValueToTime(value.toInt()));
        });
      },
      min: 0,
      max: (_valuesMap.keys.length - 1).toDouble(),
      divisions: _valuesMap.keys.length - 1,
      label: _getLabel(sliderValue.toInt()),
    );
  }

  double _sliderValueToTime(int value) => _valuesMap[value][0];

  String _getLabel(int value) => _valuesMap[value][1];
}
