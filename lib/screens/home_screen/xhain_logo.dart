import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xdoor/screens/home_screen/progress.dart';
import 'dart:core';

class XHainLogo extends StatefulWidget {
  const XHainLogo({Key? key}) : super(key: key);

  @override
  State<XHainLogo> createState() => _XHainLogoState();
}

class _XHainLogoState extends State<XHainLogo> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 8),
    animationBehavior: AnimationBehavior.normal,
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<Progress>(context);
    if (progress.get()) {
      _controller.forward(from: 0);
    } else {
      print('finished!');
      _controller.animateTo(_roundUpTo(_controller.value, 1 / 8));
    }
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(50),
            child: Image.asset('assets/images/logo.png'),
          ),
          RotationTransition(
            turns: _animation,
            child: Image.asset('assets/images/gear.png'),
          )
        ],
      ),
    );
  }

  static double _roundUpTo(double n, double x) {
    return (n / x).ceilToDouble() * x;
  }
}
