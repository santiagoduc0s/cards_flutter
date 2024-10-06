import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:porfolio_santi/game/objects/object_3d.dart';
import 'package:porfolio_santi/models/point_3d.dart';

class Axes extends Object3D {
  Axes({required super.canvas, required super.camera});

  @override
  void draw(Canvas canvas) {
    final axisPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Origin point in world coordinates
    double originX = 0;
    double originY = 0;
    double originZ = 0;

    // Length of the axes
    double axisLength = 200;

    // X-axis from origin to (axisLength, 0, 0)
    Point3D xAxisEnd = Point3D(originX + axisLength, originY, originZ);
    // Y-axis from origin to (0, axisLength, 0)
    Point3D yAxisEnd = Point3D(originX, originY + axisLength, originZ);
    // Z-axis from origin to (0, 0, axisLength)
    Point3D zAxisEnd = Point3D(originX, originY, originZ + axisLength);

    // Project origin and ends
    Offset origin2D = project3D(Point3D(originX, originY, originZ));
    Offset xAxisEnd2D = project3D(Point3D(xAxisEnd.x, xAxisEnd.y, xAxisEnd.z));
    Offset yAxisEnd2D = project3D(Point3D(yAxisEnd.x, yAxisEnd.y, yAxisEnd.z));
    Offset zAxisEnd2D = project3D(Point3D(zAxisEnd.x, zAxisEnd.y, zAxisEnd.z));

    axisPaint.color = Colors.red;
    canvas.drawLine(origin2D, xAxisEnd2D, axisPaint);

    axisPaint.color = Colors.green;
    canvas.drawLine(origin2D, yAxisEnd2D, axisPaint);

    axisPaint.color = Colors.blue;
    canvas.drawLine(origin2D, zAxisEnd2D, axisPaint);
  }
}
