import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mood/views/home/widgets/animated_background_gradient.dart';
import 'package:mood/views/home/widgets/animated_wave.dart';
// Taken from Simple Animations github example repository 
// https://github.com/felixblaschke/simple_animations/blob/master/example/lib/examples/fancy_background.dart
class FancyBackgroundApp extends StatelessWidget {
  final Widget child; // Child to be displayed 
  FancyBackgroundApp(this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackgroundGradient()),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}