import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

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

class _AppsBackgroundState extends State<AppsBackground>
    with TickerProviderStateMixin {
  late double offsetX1;
  late double offsetX2;
  late double offsetX3;
  late double offsetX4;

  final double containerWidth = 400;
  final double screenWidth = 600;

  AnimationController? _animationController;
  Map<String, FrictionSimulation> simulations = {};

  @override
  void initState() {
    super.initState();
    offsetX1 = 600 + (125 * 0);
    offsetX2 = 600 + (125 * 1);
    offsetX3 = 600 + (125 * 2);
    offsetX4 = 600 + (125 * 3);
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    // Cancel any ongoing inertia animation
    if (_animationController != null) {
      _animationController!.stop();
      _animationController!.dispose();
      _animationController = null;
      simulations.clear();
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    offsetX1 += details.delta.dx;
    offsetX2 += details.delta.dx;
    offsetX3 += details.delta.dx;
    offsetX4 += details.delta.dx;
    print(offsetX4);
    setState(() {});
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.velocity.pixelsPerSecond.dx;

    if (velocity.abs() < 50) return;

    _animationController?.dispose();

    const double friction = 0.05;

    // Create a FrictionSimulation for each offset
    simulations['offsetX1'] = FrictionSimulation(friction, offsetX1, velocity);
    simulations['offsetX2'] = FrictionSimulation(friction, offsetX2, velocity);
    simulations['offsetX3'] = FrictionSimulation(friction, offsetX3, velocity);
    simulations['offsetX4'] = FrictionSimulation(friction, offsetX4, velocity);

    // Calculate the maximum duration among all simulations
    double maxDuration = 0.0;
    for (var sim in simulations.values) {
      double simDuration = _calculateSimulationDuration(sim);
      if (simDuration > maxDuration) {
        maxDuration = simDuration;
      }
    }

    // Create the AnimationController with the max duration
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (maxDuration * 1000).ceil()),
    );

    _animationController!.addListener(() {
      setState(() {
        double time = _animationController!.value * maxDuration;
        if (!simulations['offsetX1']!.isDone(time)) {
          offsetX1 = simulations['offsetX1']!.x(time);
        }
        if (!simulations['offsetX2']!.isDone(time)) {
          offsetX2 = simulations['offsetX2']!.x(time);
        }
        if (!simulations['offsetX3']!.isDone(time)) {
          offsetX3 = simulations['offsetX3']!.x(time);
        }
        if (!simulations['offsetX4']!.isDone(time)) {
          offsetX4 = simulations['offsetX4']!.x(time);
        }
      });
    });

    _animationController!.forward();

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _animationController!.dispose();
        _animationController = null;
        simulations.clear();
      }
    });
  }

  // Function to calculate the duration of the simulation
  double _calculateSimulationDuration(FrictionSimulation simulation) {
    double duration = 0.0;
    double dt = 1 / 60; // Time increment per frame (assuming 60 FPS)
    while (!simulation.isDone(duration) && duration < 5.0) {
      duration += dt;
    }
    return duration;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
          onHorizontalDragStart: _onHorizontalDragStart,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: SizedBox(
            width: screenWidth,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.black,
              child: CustomMultiChildLayout(
                delegate: _MyCustomLayoutDelegate(
                  offsetX1: offsetX1 > 0 ? offsetX1 * factorAcceleration1 : 0,
                  offsetX2: offsetX2 > 0 ? offsetX2 * factorAcceleration2 : 0,
                  offsetX3: offsetX3 > 0 ? offsetX3 * factorAcceleration3 : 0,
                  offsetX4: offsetX4 > 0 ? offsetX4 * factorAcceleration4 : 0,
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
                      height: 600,
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
                      height: 600,
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
                      height: 600,
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
                      height: 600,
                    ),
                  ),
                ],
              ),
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

  _MyCustomLayoutDelegate({
    required this.offsetX1,
    required this.offsetX2,
    required this.offsetX3,
    required this.offsetX4,
  });

  @override
  void performLayout(Size size) {
    // Layout and position container1
    if (hasChild('container1')) {
      Size containerSize = layoutChild(
        'container1',
        BoxConstraints.loose(size),
      );
      positionChild(
        'container1',
        Offset(offsetX1, 170),
      );
    }

    // Layout and position container2
    if (hasChild('container2')) {
      Size containerSize = layoutChild(
        'container2',
        BoxConstraints.loose(size),
      );
      positionChild(
        'container2',
        Offset(offsetX2, 170),
      );
    }

    // Layout and position container3
    if (hasChild('container3')) {
      Size containerSize = layoutChild(
        'container3',
        BoxConstraints.loose(size),
      );
      positionChild(
        'container3',
        Offset(offsetX3, 170),
      );
    }

    // Layout and position container4
    if (hasChild('container4')) {
      Size containerSize = layoutChild(
        'container4',
        BoxConstraints.loose(size),
      );
      positionChild(
        'container4',
        Offset(offsetX4, 170),
      );
    }
  }

  @override
  bool shouldRelayout(_MyCustomLayoutDelegate oldDelegate) {
    return offsetX1 != oldDelegate.offsetX1 ||
        offsetX2 != oldDelegate.offsetX2 ||
        offsetX3 != oldDelegate.offsetX3 ||
        offsetX4 != oldDelegate.offsetX4;
  }
}
