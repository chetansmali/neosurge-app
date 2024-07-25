import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/extensions.dart';
import '../../../../../data/models/assisted_service/suggested_fund.dart';

class SuggestedFundCard extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final SuggestedFund fund;

  const SuggestedFundCard({Key? key, required this.cardColor, required this.textColor, required this.fund}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: fund.imgUrl,
                height: 50,
                width: 50,
              ),
              const Gap(10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fund.name),
                  Row(
                    children: [
                      Text(
                        '${fund.isThematic ? 'Thematic' : 'Non-Thematic'} ',
                        style: const TextStyle(fontSize: 8),
                      ),
                      // const Gap(10),
                      // const Text(
                      //   'Nav \u20B9 50.7',
                      //   style: TextStyle(fontSize: 8),
                      // ),
                    ],
                  ),
                ],
              ))
            ],
          ),
          const Gap(10),
          Row(
            children: [
              _TwoColText(textColor: textColor, title: 'Returns (1 Year)', value: '${fund.performance.oneY.toStringAsFixed(2)} %'),
              // 3years
              _TwoColText(textColor: textColor, title: 'Returns (3 Year)', value: '${fund.performance.threeY.toStringAsFixed(2)} %'),
              // 5years
              _TwoColText(textColor: textColor, title: 'Returns (5 Year)', value: '${fund.performance.fiveY.toStringAsFixed(2)} %'),
            ],
          ),
          const Gap(10),
          Text(
            'Fund Allocated\t\t\t\t\t\t \u20b9 ${fund.amount.toCurrency()}',
            style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TwoColText extends StatelessWidget {
  final Color textColor;
  final String title;
  final String value;

  const _TwoColText({Key? key, required this.textColor, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 14,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 8),
          )
        ],
      ),
    );
  }
}
