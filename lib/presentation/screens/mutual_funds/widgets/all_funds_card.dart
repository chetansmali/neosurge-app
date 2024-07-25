import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/mutual_funds/mutual_fund.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import 'basket_custom_container.dart';

class AllFundsCard extends StatelessWidget {
  final MutualFund mutualFund;

  const AllFundsCard({
    Key? key,
    required this.mutualFund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasketCustomContainer(
      // margin: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detailedFundView,
            arguments: DetailedFundViewArgs(
              schemeCode: mutualFund.schemeCode,
            ),
          );
        },
        child: Column(
          children: [
            Row(
              children: [
                if (mutualFund.imgUrl != null) ...[
                  CachedNetworkImage(
                    imageUrl: mutualFund.imgUrl!,
                    height: 50,
                    width: 50,
                  ),
                  const Gap(10),
                ],
                Expanded(
                  child: Text(
                    mutualFund.schemeName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFundDetail(
                  title: 'AUM',
                  value: AmountWidget(
                    amount: mutualFund.fundSize,
                    hasSpace: false,
                    postText: ' Cr',
                    isCompact: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                _buildFundDetail(
                  title: 'Expense Ratio',
                  value: Text(
                    mutualFund.expenseRatio.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                _buildFundDetail(
                  title: '3Y Returns',
                  value: Text(
                    '${getReturns(ReturnsType.threeYear)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: (getReturns(ReturnsType.threeYear) ?? 0.0) >= 0
                          ? AppColors.success[500]
                          : AppColors.error[500],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildFundDetail({
    required String title,
    required Widget value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.neutral[200],
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        value,
      ],
    );
  }

  double? getReturns(ReturnsType returns) {
    switch (returns) {
      case ReturnsType.threeYear:
        return mutualFund.threeY;
      case ReturnsType.fiveYear:
        return mutualFund.fiveY;
      case ReturnsType.oneYear:
        return mutualFund.oneY;
    }
  }
}
