import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Rwendobarchart extends StatelessWidget {
  const Rwendobarchart({
    super.key,
    required this.width,
    required this.label,
    required this.percent,
  });
  final width;
  final label;
  final percent;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        LinearPercentIndicator(
          percent: percent,
          lineHeight: 15,
          width: width * 0.7,
          progressColor: Colors.blue,
        ),
      ],
    );
  }
}
