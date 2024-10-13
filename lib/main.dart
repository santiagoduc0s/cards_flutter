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

late double containerWidth;
late double containerHeight;

late double screenWidth;

class _AppsBackgroundState extends State<AppsBackground>
    with TickerProviderStateMixin {
  late double offsetX1;
  late double offsetX2;
  late double offsetX3;
  late double offsetX4;
  late double offsetX5;
  late double offsetX6;
  late double offsetX7;
  late double offsetX8;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final m = MediaQuery.of(context).size.width * 0.26;
      offsetX1 = (m * 0);
      offsetX2 = (m * 1);
      offsetX3 = (m * 2);
      offsetX4 = (m * 3);
      offsetX5 = (m * 4);
      offsetX6 = (m * 5);
      offsetX7 = (m * 6);
      offsetX8 = (m * 7);
      setState(() {});
    });
    offsetX1 = (125 * 0);
    offsetX2 = (125 * 1);
    offsetX3 = (125 * 2);
    offsetX4 = (125 * 3);
    offsetX5 = (125 * 4);
    offsetX6 = (125 * 5);
    offsetX7 = (125 * 6);
    offsetX8 = (125 * 7);
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    // Cancel any ongoing animation
    animationController?.stop();
    animationController?.dispose();
    animationController = null;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    offsetX1 += details.delta.dx;
    offsetX2 += details.delta.dx;
    offsetX3 += details.delta.dx;
    offsetX4 += details.delta.dx;
    offsetX5 += details.delta.dx;
    offsetX6 += details.delta.dx;
    offsetX7 += details.delta.dx;
    offsetX8 += details.delta.dx;
    setState(() {});
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // Remove previous animation controller
    animationController?.dispose();

    double centerX = screenWidth / 2;

    // Calculate the center position of each container
    double centerOffsetX1 = offsetX1 + containerWidth / 2;
    double centerOffsetX2 = offsetX2 + containerWidth / 2;
    double centerOffsetX3 = offsetX3 + containerWidth / 2;
    double centerOffsetX4 = offsetX4 + containerWidth / 2;
    double centerOffsetX5 = offsetX5 + containerWidth / 2;
    double centerOffsetX6 = offsetX6 + containerWidth / 2;
    double centerOffsetX7 = offsetX7 + containerWidth / 2;
    double centerOffsetX8 = offsetX8 + containerWidth / 2;

    Map<String, double> containerCenters2 = {
      'offsetX1': offsetX2,
      'offsetX2': offsetX3,
      'offsetX3': offsetX4,
      'offsetX4': offsetX5,
      'offsetX5': offsetX6,
      'offsetX6': offsetX7,
      'offsetX7': offsetX8,
      'offsetX8': offsetX8,
    };

    // Create a map of container centers
    Map<String, double> containerCenters = {
      'offsetX1': centerOffsetX1,
      'offsetX2': centerOffsetX2,
      'offsetX3': centerOffsetX3,
      'offsetX4': centerOffsetX4,
      'offsetX5': centerOffsetX5,
      'offsetX6': centerOffsetX6,
      'offsetX7': centerOffsetX7,
      'offsetX8': centerOffsetX8,
    };

    // Calculate distances from container centers to screen center
    Map<String, double> distances = {
      'offsetX1': (centerOffsetX1 - centerX).abs(),
      'offsetX2': (centerOffsetX2 - centerX).abs(),
      'offsetX3': (centerOffsetX3 - centerX).abs(),
      'offsetX4': (centerOffsetX4 - centerX).abs(),
      'offsetX5': (centerOffsetX5 - centerX).abs(),
      'offsetX6': (centerOffsetX6 - centerX).abs(),
      'offsetX7': (centerOffsetX7 - centerX).abs(),
      'offsetX8': (centerOffsetX8 - centerX).abs(),
    };

    // Find the closest container
    String closestOffsetKey =
        distances.entries.reduce((a, b) => a.value < b.value ? a : b).key;

    // Calculate delta to center the closest container
    double delta = centerX - (containerCenters2[closestOffsetKey]!);

    // Store initial offsets
    double initialOffsetX1 = offsetX1;
    double initialOffsetX2 = offsetX2;
    double initialOffsetX3 = offsetX3;
    double initialOffsetX4 = offsetX4;
    double initialOffsetX5 = offsetX5;
    double initialOffsetX6 = offsetX6;
    double initialOffsetX7 = offsetX7;
    double initialOffsetX8 = offsetX8;

    // Create animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Animation<double> animation = Tween<double>(begin: 0, end: delta).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeOut,
      ),
    );

    animationController!.addListener(() {
      setState(() {
        double currentDelta = animation.value;
        offsetX1 = initialOffsetX1 + currentDelta;
        offsetX2 = initialOffsetX2 + currentDelta;
        offsetX3 = initialOffsetX3 + currentDelta;
        offsetX4 = initialOffsetX4 + currentDelta;
        offsetX5 = initialOffsetX5 + currentDelta;
        offsetX6 = initialOffsetX6 + currentDelta;
        offsetX7 = initialOffsetX7 + currentDelta;
        offsetX8 = initialOffsetX8 + currentDelta;
      });
    });

    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        animationController!.dispose();
        animationController = null;
      }
    });

    animationController!.forward();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    containerWidth = MediaQuery.of(context).size.width * 0.7;
    containerHeight = MediaQuery.of(context).size.height * 0.6;
    screenWidth = MediaQuery.of(context).size.width;

    final factorAcceleration1 = offsetX1 / (screenWidth - containerWidth);
    final factorAcceleration2 = offsetX2 / (screenWidth - containerWidth);
    final factorAcceleration3 = offsetX3 / (screenWidth - containerWidth);
    final factorAcceleration4 = offsetX4 / (screenWidth - containerWidth);
    final factorAcceleration5 = offsetX5 / (screenWidth - containerWidth);
    final factorAcceleration6 = offsetX6 / (screenWidth - containerWidth);
    final factorAcceleration7 = offsetX7 / (screenWidth - containerWidth);
    final factorAcceleration8 = offsetX8 / (screenWidth - containerWidth);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onHorizontalDragStart: _onHorizontalDragStart,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: SizedBox(
            child: CustomMultiChildLayout(
              delegate: _MyCustomLayoutDelegate(
                offsetX1: offsetX1 > 0 ? offsetX1 * factorAcceleration1 : 0,
                offsetX2: offsetX2 > 0 ? offsetX2 * factorAcceleration2 : 0,
                offsetX3: offsetX3 > 0 ? offsetX3 * factorAcceleration3 : 0,
                offsetX4: offsetX4 > 0 ? offsetX4 * factorAcceleration4 : 0,
                offsetX5: offsetX5 > 0 ? offsetX5 * factorAcceleration5 : 0,
                offsetX6: offsetX6 > 0 ? offsetX6 * factorAcceleration6 : 0,
                offsetX7: offsetX7 > 0 ? offsetX7 * factorAcceleration7 : 0,
                offsetX8: offsetX8 > 0 ? offsetX8 * factorAcceleration8 : 0,
              ),
              children: [
                LayoutId(
                  id: 'container1',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container2',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container3',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container4',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container5',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container6',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container7',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
                LayoutId(
                  id: 'container8',
                  child: Visibility(
                    visible: false,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      width: containerWidth,
                      height: containerHeight,
                    ),
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

class _MyCustomLayoutDelegate extends MultiChildLayoutDelegate {
  final double offsetX1;
  final double offsetX2;
  final double offsetX3;
  final double offsetX4;
  final double offsetX5;
  final double offsetX6;
  final double offsetX7;
  final double offsetX8;

  _MyCustomLayoutDelegate({
    required this.offsetX1,
    required this.offsetX2,
    required this.offsetX3,
    required this.offsetX4,
    required this.offsetX5,
    required this.offsetX6,
    required this.offsetX7,
    required this.offsetX8,
  });

  @override
  void performLayout(Size size) {
    final height = size.height;
    final mediumHeightContainer = containerHeight / 2;
    final top = height / 2 - mediumHeightContainer;
    if (hasChild('container1')) {
      layoutChild('container1', BoxConstraints.loose(size));
      positionChild('container1', Offset(offsetX1, top));
    }

    if (hasChild('container2')) {
      layoutChild('container2', BoxConstraints.loose(size));
      positionChild('container2', Offset(offsetX2, top));
    }

    if (hasChild('container3')) {
      layoutChild('container3', BoxConstraints.loose(size));
      positionChild('container3', Offset(offsetX3, top));
    }

    if (hasChild('container4')) {
      layoutChild('container4', BoxConstraints.loose(size));
      positionChild('container4', Offset(offsetX4, top));
    }

    if (hasChild('container5')) {
      layoutChild('container5', BoxConstraints.loose(size));
      positionChild('container5', Offset(offsetX5, top));
    }

    if (hasChild('container6')) {
      layoutChild('container6', BoxConstraints.loose(size));
      positionChild('container6', Offset(offsetX6, top));
    }

    if (hasChild('container7')) {
      layoutChild('container7', BoxConstraints.loose(size));
      positionChild('container7', Offset(offsetX7, top));
    }

    if (hasChild('container8')) {
      layoutChild('container8', BoxConstraints.loose(size));
      positionChild('container8', Offset(offsetX8, top));
    }
  }

  @override
  bool shouldRelayout(_MyCustomLayoutDelegate oldDelegate) {
    return offsetX1 != oldDelegate.offsetX1 ||
        offsetX2 != oldDelegate.offsetX2 ||
        offsetX3 != oldDelegate.offsetX3 ||
        offsetX4 != oldDelegate.offsetX4 ||
        offsetX5 != oldDelegate.offsetX5 ||
        offsetX6 != oldDelegate.offsetX6 ||
        offsetX7 != oldDelegate.offsetX7 ||
        offsetX8 != oldDelegate.offsetX8;
  }
}
