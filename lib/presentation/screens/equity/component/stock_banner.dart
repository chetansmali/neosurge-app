import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';

import '../../../../common/common.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../invest/explore/explore_dialog_box.dart';

class StockBanner extends StatelessWidget {
  final String symbol;
  final String name;
  final double close;
  final double change;
  final double percentage;
  final String? icon;
  final String industry;

  const StockBanner({
    super.key,
    required this.symbol,
    required this.name,
    required this.close,
    required this.change,
    required this.percentage,
    required this.icon,
    required this.industry,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final smallcaseAuthToken =
          context.watch<AuthCubit>().state.user?.smallcaseAuthToken;
      return GestureDetector(
        onTap: () {
          if (smallcaseAuthToken == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ShowDialog();
              },
            );
          } else {
            Navigator.pushNamed(
              context,
              Routes.exploreStockDetail,
              arguments: StockDetailsArgs(
                symbolName: symbol,
                close: close,
                change: change,
                percentage: percentage,
                industry: industry,
                name: name,
                icon: icon ?? '',
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryLightColor,
                ),
                child: Center(
                  child: icon != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: icon!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Text(
                              symbol.substring(0, 1),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Text(symbol.substring(0, 2)),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: baseTextStyle14500.copyWith(
                          color: AppColors.neutral[500]),
                    ),
                    const Gap(2),
                    Text(
                      name,
                      style: baseTextStyle10400.copyWith(
                          color: AppColors.neutral[400]),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountWidget(
                      amount: close,
                      style: baseTextStyle14500.copyWith(
                          color: AppColors.neutral[500])),
                  const Gap(2),
                  Text(
                    '${change.isNegative ? '' : '+'}${change.toStringAsFixed(2)} '
                    '(${percentage.toStringAsFixed(2)}%)',
                    style: baseTextStyle10400.copyWith(
                      color: change.isNegative
                          ? AppColors.error[500]
                          : AppColors.success[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
