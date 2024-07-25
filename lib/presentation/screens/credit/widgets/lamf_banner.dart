import 'package:flutter/material.dart';

import '../../../../common/custom_styles.dart';
import '../../../widgets/amount_widget.dart';

class LamfBanner extends StatelessWidget {
  const LamfBanner(
      {super.key,
      required this.title,
      required this.value,
      required this.small});
  final String title;
  final double value;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF133C6B), // Left color
            Color(0xFF121517), // Right color
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: small
                    ? baseTextStyle10400.copyWith(color: Colors.white)
                    : baseTextStyle14400.copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AmountWidget(
                amount: value,
                isCompact: false,
                style: small
                    ? baseTextStyle18500.copyWith(color: Colors.white)
                    : baseTextStyle32500.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
