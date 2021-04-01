import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          width: widget.size,
          height: widget.size,
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: ClockPainter(),
            ),
          )),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerfillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xff748ef6), Color(0xff7700ff)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0XFFEA74AB), Color(0XFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerfillBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
