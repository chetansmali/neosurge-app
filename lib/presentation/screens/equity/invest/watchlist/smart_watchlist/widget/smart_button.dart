import 'package:flutter/material.dart';

class SmartButton extends StatefulWidget {
  final Widget child;

  SmartButton({
    required this.child,
  });

  @override
  State<SmartButton> createState() => _SmartButtonState();
}

class _SmartButtonState extends State<SmartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // late added here

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            // width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red.shade50,
                    Colors.white,
                    Colors.red.shade50
                  ],
                  stops: [
                    0.0,
                    _controller.value,
                    1.0
                  ]),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.child,
            ),
          );
        });
  }
}
