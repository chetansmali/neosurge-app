import 'dart:async';

import 'package:flutter/material.dart';

class AutoWidgetSwitcher extends StatefulWidget {
  /// The list of widgets to be animated cyclically.
  final List<Widget> children;

  /// The duration of the animation. Defaults to 300 milliseconds.
  final Duration animationDuration;

  /// The duration of the pause between animations. Defaults to 1 second.
  final Duration delayDuration;

  const AutoWidgetSwitcher({Key? key, required this.children, this.animationDuration = const Duration(seconds: 2), this.delayDuration = const Duration(seconds: 2)})
      : assert(children.length > 1, 'children must have at least 2 items'),
        super(key: key);

  @override
  State<AutoWidgetSwitcher> createState() => _AutoWidgetSwitcherState();
}

class _AutoWidgetSwitcherState extends State<AutoWidgetSwitcher> {
  late final Timer _timer;
  int _currentWidgetIndex = 0;
  Widget? _currentWidget;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.delayDuration, (_) {
      setState(() {
        _currentWidgetIndex = (_currentWidgetIndex + 1) % widget.children.length;
        _currentWidget = widget.children[_currentWidgetIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.animationDuration,
      reverseDuration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        //scale and fade animation
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.8, end: 1.0)),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: _currentWidget,
    );
  }
}
