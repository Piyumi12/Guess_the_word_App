import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends CustomPainter{

  double currentProgress;

  Loader(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2, size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi/2,angle, false,  completeArc);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}