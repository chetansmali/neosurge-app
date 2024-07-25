import 'package:flutter/material.dart';

import '../../../../data/models/mutual_funds/fund.dart';

class FundCardHeader extends StatelessWidget {
  final Fund fund;
  final ScrollController scrollController;
  final double? maxHeight;
  final double? minHeight;

  const FundCardHeader(
      {Key? key,
      required this.fund,
      required this.scrollController,
      this.maxHeight,
      this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: AnimatedBuilder(
        animation: scrollController,
        builder: (context, child) => AnimatedOpacity(
          opacity: scrollController.offset > 90 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(fund.schemeNameUnique),
        ),
      ),
    );
  }
}
