import 'package:flutter/material.dart';

import '../../../../../../../common/common.dart';

class ETFBuySellButton extends StatelessWidget {
  const ETFBuySellButton(
      {super.key, required this.title, required this.color, this.onTap});
  final String title;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          boxShadow: [
            BoxShadow(blurRadius: 8.0, color: Colors.black.withOpacity(0.08))
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          title,
          style: baseTextStyle14500.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
