import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
// Taken from Simple Animations github example repository 
// https://github.com/felixblaschke/simple_animations/blob/master/example/lib/examples/fancy_background.dart
enum _Colors { color1, color2, color3 }

class AnimatedBackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_Colors>()
      ..add(_Colors.color1, ColorTween(begin: Theme.of(context).primaryColor, end: Theme.of(context).primaryColor))
      ..add(_Colors.color2, ColorTween(begin: Theme.of(context).primaryColor, end: Colors.blue))
      ..add(_Colors.color3, ColorTween(begin: Theme.of(context).primaryColor, end: Colors.green));

    return MirrorAnimation<MultiTweenValues<_Colors>>(
      tween: tween,
      duration: Duration(seconds: 3),
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(  
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              value.get(_Colors.color1), 
              value.get(_Colors.color2),
              value.get(_Colors.color3),
            ])),
        );
      }
    );
  }
}