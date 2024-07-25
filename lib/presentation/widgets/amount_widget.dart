import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/utils.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.amount,
    this.isCompact = true,
    this.style,
    this.postText = '',
    this.preText = '',
    this.isDecimal = true,
    this.hasSpace = true,
  });

  final double amount;
  final bool isCompact;
  final String postText;
  final String preText;
  final TextStyle? style;
  final bool isDecimal;
  final bool hasSpace;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: preText,
            style: style,
          ),
          TextSpan(
            text: '\u20B9${hasSpace ? ' ' : ''}',
            style: GoogleFonts.hind(
              textStyle: style,
            ),
          ),
          TextSpan(
            text: isCompact
                ? Utils.compactCurrencyWithoutSymbol(amount)
                : isDecimal
                    ? amount.toStringAsFixed(2)
                    : amount.toInt().toString(),
            style: style,
          ),
          TextSpan(
            text: postText,
            style: style,
          ),
        ],
      ),
    );
  }
}
