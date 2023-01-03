import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemiCircle extends StatelessWidget {
  final double diameter;
  final Color color;
  final bool roundUp;

  const SemiCircle ({Key? key, required this.diameter, required this.color, required this.roundUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: diameter/2,
    width: diameter,
    decoration: BoxDecoration(
      borderRadius: roundUp? BorderRadius.only(topLeft: Radius.circular(3000), topRight: Radius.circular(3000)) : BorderRadius.only(bottomLeft: Radius.circular(3000), bottomRight: Radius.circular(3000)),
      border: Border.all(width: 20),
      color: color,
    ),
    );
  }
}
