import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween("opacity", Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500))
      ..tween("translateY", Tween(begin: -30.0, end: 0.0),
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);

    return CustomAnimationBuilder<Movie>(
      control: Control.play,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, value, _) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
          offset: Offset(0, value.get("translateY")),
          child: child,
        ),
      ),
    );
  }
}
