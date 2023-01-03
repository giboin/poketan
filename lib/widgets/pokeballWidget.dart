import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hackathon/widgets/semiCircle.dart';

class PokeballWidget extends StatefulWidget {
  final double diameter;

  const PokeballWidget({Key? key, required this.diameter}) : super(key: key);

  @override
  State<PokeballWidget> createState() => _PokeballWidgetState();
}

class _PokeballWidgetState extends State<PokeballWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          children: [
            SemiCircle(diameter: widget.diameter, color: Colors.red, roundUp: true,),
            SemiCircle(diameter: widget.diameter, color: Colors.white, roundUp: false,)
          ],
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}


// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
