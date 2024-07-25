import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';

import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../widgets/amount_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';

class BasketPortfolioFund extends StatelessWidget {
  const BasketPortfolioFund({
    super.key,
    required this.fund,
  });

  final Fund fund;

  @override
  Widget build(BuildContext context) {
    return BasketCustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://mutualfunds.neosurge.money/${fund.logoUrl}',
                height: 48,
                width: 48,
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  fund.fundName,
                  style: baseTextStyle14500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Allow up to 2 lines.
                ),
              ),
            ],
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current',
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFFB0B0B0)),
                  ),
                  const Gap(10),
                  AmountWidget(
                    amount: fund.current,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invested',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFFB0B0B0),
                    ),
                  ),
                  const Gap(10),
                  AmountWidget(
                    amount: fund.invested,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Returns',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFFB0B0B0),
                    ),
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AmountWidget(
                        amount: fund.returns,
                      ),
                      if (fund.returnsPercentage != null) ...[
                        const Gap(4),
                        Text(
                          '(${fund.returnsPercentage?.toStringAsFixed(2)}%)',
                          style: baseTextStyle.copyWith(
                            color: const Color(0xFF43B649),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              )
            ],
          ),
          const Divider(
            height: 30,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Folio Number',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF47586E),
                    ),
                  ),
                  Text(
                    fund.folioNumber,
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF1D242D),
                    ),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Units',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF47586E),
                    ),
                  ),
                  Text(
                    fund.units.toStringAsFixed(2),
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF1D242D),
                    ),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Average Purchase NAV',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF47586E),
                    ),
                  ),
                  Text(
                    fund.avgNav.toStringAsFixed(2),
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF1D242D),
                    ),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Allocation %',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF47586E),
                    ),
                  ),
                  Text(
                    '${fund.allocationPercentage.toStringAsFixed(2)}%',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF1D242D),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
