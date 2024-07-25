import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../gen/assets.gen.dart';

class EmptyPortfolioView extends StatelessWidget {
  final String? message;
  final TextStyle? messageStyle;

  const EmptyPortfolioView({Key? key, this.message, this.messageStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.svgs.emptyVector.svg(height: 180),
          const Gap(20),
          Text(
            message ?? 'Your portfolio is empty',
            textAlign: TextAlign.center,
            style: messageStyle ?? Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
