import 'package:flutter/material.dart';
import 'package:porfolio_santi/game/utils/camera.dart';
import 'package:porfolio_santi/models/point_3d.dart';

abstract class Object3D {
  Object3D({
    required this.canvas,
    required this.camera,
  });

  Canvas canvas;
  Camera3D camera;

  void draw(Canvas canvas);

  Offset project3D(
    Point3D point,
  ) {
    double scale = camera.focalLength / (camera.cameraZ - point.z);

    double projectedX = (point.x - camera.cameraX) * scale;
    double projectedY = (point.y - camera.cameraY) * scale;

    return Offset(
        projectedX + camera.screenCenterX, projectedY + camera.screenCenterY);
  }
}
