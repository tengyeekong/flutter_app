import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Demo4Page extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

// #docregion print-state
class _LogoAppState extends State<Demo4Page>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  // #enddocregion print-state

  @override
  Widget build(BuildContext context) => GrowTransition(
    animation: animation,
        child: LogoWidget(),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
// #docregion print-state
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Center(
    child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => SizedBox(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
        child: child),
  );
}
// #enddocregion GrowTransition

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const FlutterLogo(),
      );
}
