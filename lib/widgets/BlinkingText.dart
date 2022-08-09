// @dart=2.9
import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  final String text;

  BlinkingText(this.text);

  @override
  _BlinkingAnimationState createState() { return _BlinkingAnimationState(this.text);}
}

class _BlinkingAnimationState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;
  String text;

  _BlinkingAnimationState(this.text);

  initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
        //duration: const Duration(milliseconds: 1000), vsync: this);

    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    animation =
        ColorTween(begin: Colors.white, end: Colors.red).animate(curve);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
            child: Text(text,
                style: TextStyle(color: animation.value)),
          );
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}