import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Demo5Page extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

// #docregion print-state
class _LogoAppState extends State<Demo5Page>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    // #docregion AnimationController, tweens
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #enddocregion AnimationController, tweens
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
// #docregion print-state
}

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class UsedInTutorialTextOnly extends _LogoAppState {
  UsedInTutorialTextOnly() {
    // ignore: unused_local_variable
    CurvedAnimation animation;
    Animation<double> sizeAnimation;
    Animation<double> opacityAnimation;
    Tween<double> tween;
    ColorTween colorTween;

    // #docregion CurvedAnimation
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    // #enddocregion CurvedAnimation

    // #docregion tweens
    sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
    opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);
    // #enddocregion tweens

    // #docregion tween
    tween = Tween<double>(begin: -200, end: 0);
    // #enddocregion tween

    // #docregion colorTween
    colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
    // #enddocregion colorTween
  }

  Animation<int> usedInTutorialOnly1() {
    // #docregion IntTween
    final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<int> alpha =
        IntTween(begin: 0, end: 255).animate(controller);
    // #enddocregion IntTween
    return alpha;
  }

  Animation<int> usedInTutorialOnly2() {
    // #docregion IntTween-curve
    final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    final Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
    // #enddocregion IntTween-curve
    return alpha;
  }
}

// #docregion ShakeCurve
class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}
