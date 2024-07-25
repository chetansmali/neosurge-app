import 'package:flutter/material.dart';

import '../../../../common/custom_styles.dart';

class CircularCountIndicator extends StatelessWidget {
  const CircularCountIndicator({
    super.key,
    required this.data,
    required this.bgColor,
    required this.fgColor,
  });
  final String data;
  final Color bgColor, fgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      child: Text(
        data,
        style: baseTextStyle12600.copyWith(color: fgColor),
      ),
    );
  }
}
