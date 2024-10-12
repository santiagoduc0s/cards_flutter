import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppsBackground(),
    ),
  );
}

class AppsBackground extends StatefulWidget {
  @override
  _AppsBackgroundState createState() => _AppsBackgroundState();
}

class _AppsBackgroundState extends State<AppsBackground> {
  late double offsetX1;
  late double offsetX2;
  late double offsetX3;
  late double offsetX4;

  final double containerWidth = 400;
  final double screenWidth = 600;

  @override
  void initState() {
    super.initState();
    offsetX1 = 600 + (containerWidth * 0);
    offsetX2 = 600 + 150;
    offsetX3 = 600 + 250;
    offsetX4 = 600 + 350;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    offsetX1 += details.delta.dx;
    offsetX2 += details.delta.dx;
    offsetX3 += details.delta.dx;
    offsetX4 += details.delta.dx;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final factorAcceleration1 = offsetX1 / (screenWidth - containerWidth);
    final factorAcceleration2 = offsetX2 / (screenWidth - containerWidth);
    final factorAcceleration3 = offsetX3 / (screenWidth - containerWidth);
    final factorAcceleration4 = offsetX4 / (screenWidth - containerWidth);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          child: SizedBox(
            width: screenWidth,
            height: 700,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  left: offsetX1 > 0 ? offsetX1 * factorAcceleration1 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    width: containerWidth,
                    height: 600,
                  ),
                ),
                Positioned(
                  left: offsetX2 > 0 ? offsetX2 * factorAcceleration2 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    width: containerWidth,
                    height: 600,
                  ),
                ),
                Positioned(
                  left: offsetX3 > 0 ? offsetX3 * factorAcceleration3 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow,
                    ),
                    width: containerWidth,
                    height: 600,
                  ),
                ),
                Positioned(
                  left: offsetX4 > 0 ? offsetX4 * factorAcceleration4 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange,
                    ),
                    width: containerWidth,
                    height: 600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
