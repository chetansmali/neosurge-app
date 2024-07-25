import 'package:flutter/material.dart';

class SlideRightAnimator extends StatefulWidget {
  const SlideRightAnimator({Key? key, required this.child, this.delay, this.rightOffset = 0}) : super(key: key);

  final Widget child;
  final int? delay;
  final double rightOffset;

  @override
  State<SlideRightAnimator> createState() => _SlideRightAnimatorState();
}

class _SlideRightAnimatorState extends State<SlideRightAnimator> with TickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800), lowerBound: 0.4, upperBound: 1.0);
    _animOffset = Tween<Offset>(begin: Offset(-0.5 - widget.rightOffset, 0), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: Curves.easeInOut));
    if (widget.delay != null) {
      Future.delayed(Duration(milliseconds: widget.delay!), () {
        if (mounted) _animController.repeat(reverse: true);
      });
    } else {
      _animController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animOffset, child: widget.child);
  }
}
