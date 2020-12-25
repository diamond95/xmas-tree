import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merry Christmas',
      theme: ThemeData(textTheme: TextTheme()),
      home: XmasTree(),
    );
  }
}

class XmasTree extends StatelessWidget {
  static final List<double> _offsets =
      _generatePositions(100, 0.05).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Align(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
          child: ListView(
            children: <Widget>[
              Center(child: Icon(Icons.star, color: Colors.white)),
              SizedBox(height: 8),
              for (final x in _offsets) Light(x),
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Sretan Božić 2020!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 7),
          ),
        ),
      ),
    );
  }

  static Iterable<double> _generatePositions(int count, double acceleration) sync* {
    double x = 0;
    yield x;

    double ax = acceleration;
    for (var i = 0; i < count; i++) {
      x += ax;
      ax *= 1.5;

      final maxLateral = min(1, i / count);
      if (x.abs() > maxLateral) {
        x = maxLateral * x.sign;
        ax = x >= 0 ? -acceleration : acceleration;
      }
      yield x;
    }
  }
}



class Light extends StatefulWidget {
  static List<Color> festiveColors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.yellow
  ];

  final double x;

  final int period;
  final Color color;

  Light(this.x, {Key key})
      : period = 500 + (x.abs() * 4000).floor(),
        color = festiveColors[(x.abs() * 42).floor() % festiveColors.length],
        super(key: key);

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> {
  Color _newColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Align(
        alignment: Alignment(widget.x, 0),
        child: AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: widget.color, end: _newColor),
            duration: Duration(milliseconds: widget.period),
            onEnd: () {
              setState(() {
                _newColor =
                    _newColor == Colors.white ? widget.color : Colors.white;
              });
            },
            builder: (_, color, __) => Container(color: color),
          ),
        ),
      ),
    );
  }
}
