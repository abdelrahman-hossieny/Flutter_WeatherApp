import 'package:flutter/material.dart';

class TemperatureDisplay extends StatelessWidget {
  final double temperature;
  final double? fontSize;

  const TemperatureDisplay({
    Key? key,
    required this.temperature,
    this.fontSize = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${temperature.round()}°',
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}