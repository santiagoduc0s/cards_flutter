import 'package:flutter/material.dart';
import 'package:porfolio_santi/widgets/metaballs_background.dart';
import 'package:flutter/scheduler.dart';

void main() {
  timeDilation = 4.0; // Slow down animations by a factor of 2
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MetaballsBackground(),
    ),
  );
}
