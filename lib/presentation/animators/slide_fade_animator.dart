import 'package:flutter/material.dart';

///This widget is used to the slide and fade animation from bottom to top.

class SlideFadeAnimator extends StatefulWidget {
  /// The widget to display that needs the animation.
  final Widget child;

  ///The delay in milliseconds before the animation starts.

  final int? delay;

  ///The offset from where the animation should start to.
  ///End Offset will be Offset.zero.
  final Offset? startOffset;

  final bool isRepeat;

  /// The duration of the animation in milliseconds.
  /// The default value is 800 milliseconds.
  final int? duration;

  const SlideFadeAnimator({Key? key, required this.child, this.delay, this.duration, this.startOffset, this.isRepeat = false}) : super(key: key);

  @override
  State<SlideFadeAnimator> createState() => _SlideFadeAnimatorState();
}

class _SlideFadeAnimatorState extends State<SlideFadeAnimator> with TickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 800));
    _animOffset = Tween<Offset>(begin: widget.startOffset ?? const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.decelerate,
      ),
    );

    if (widget.delay == null) {
      if (widget.isRepeat) {
        _animController.repeat(reverse: true);
      } else {
        _animController.forward();
      }
    } else {
      Future.delayed(Duration(milliseconds: widget.delay!), () {
        if (mounted) {
          if (widget.isRepeat) {
            _animController.repeat(reverse: true);
          } else {
            _animController.forward();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
