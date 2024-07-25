import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../di/get_it.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/set_alert_cubit.dart';
import 'set_alert_bottom_sheet.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../common/utils.dart';
import '../../../../../theme/app_colors.dart';

class SmartSearchCard extends StatelessWidget {
  final String icon;
  final String symbole;
  final String companyName;
  final double close;
  final double change;
  final double percentChange;
  final int qty;

  const SmartSearchCard({
    super.key,
    required this.icon,
    required this.symbole,
    required this.companyName,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (BuildContext _) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<SetAlertCubit>(),
                  ),
                ],
                child: SetAlertBootmSheet(
                  icon: icon,
                  symbole: symbole,
                  companyName: companyName,
                  close: close,
                  change: change,
                  percentChange: percentChange,
                  qty: qty,
                ),
              );
            });
      },
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryLightColor,
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: icon,
                    errorWidget: (context, url, error) {
                      return Text(
                        symbole.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          symbole,
                          style: baseTextStyle14400,
                        ),
                        Text(
                          Utils.compactCurrency(close),
                          style: baseTextStyle14400,
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            companyName,
                            style: baseTextStyle10400.copyWith(
                                color: AppColors.textGrey),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              change > 0
                                  ? ('+${change.toStringAsFixed(2)}')
                                  : (change.toStringAsFixed(2)),
                              style: baseTextStyle10400.copyWith(
                                color: change > 0
                                    ? AppColors.green
                                    : AppColors.errorRed,
                              ),
                            ),
                            Text(
                              ('(${percentChange.toStringAsFixed(2)}%)'),
                              style: baseTextStyle10400.copyWith(
                                  color: percentChange > 0
                                      ? AppColors.green
                                      : AppColors.errorRed),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
