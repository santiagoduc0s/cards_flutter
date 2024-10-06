class Camera3D {
  double cameraX;
  double cameraY;
  double cameraZ;
  double focalLength;

  double screenCenterX;
  double screenCenterY;
  
  Camera3D({
    required this.cameraX,
    required this.cameraY,
    required this.cameraZ,
    required this.focalLength,
    required this.screenCenterX,
    required this.screenCenterY,
  });
}
