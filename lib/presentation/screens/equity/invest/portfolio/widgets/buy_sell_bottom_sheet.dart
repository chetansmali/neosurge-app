import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../di/get_it.dart';
import '../../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../../cubits/equity/buy_sell_transaction_cubit.dart';
import '../../../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../../../routes/route_arguments.dart';
import '../../../../../routes/routes.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/amount_widget.dart';
import '../../explore/buy_sell_bottom_sheet.dart';
import '../../explore/explore_dialog_box.dart';

class StockDetailBottomSheet extends StatelessWidget {
  const StockDetailBottomSheet({
    super.key,
    required this.image,
    required this.symbol,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.dayHighPrice,
    required this.dayHighPercent,
    required this.invested,
    required this.avgPrice,
    required this.ltp,
    required this.ltppercentage,
  });

  final String image;
  final String symbol;
  final String subtitle;
  final double price;
  final int qty;
  final double dayHighPrice;
  final double dayHighPercent;
  final double invested;
  final double avgPrice;
  final double ltp;
  final double ltppercentage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral[400],
                  ),
                ),
                const Spacer(),
                AmountWidget(
                  amount: price,
                  isCompact: false,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral[500],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  label: Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary[500],
                    ),
                  ),
                  backgroundColor: AppColors.primary[50],
                ),
                const Spacer(),
                Text(
                  '${dayHighPrice > 0 ? '+' : ''} ${dayHighPrice.toStringAsFixed(2)} (${dayHighPercent.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: dayHighPrice > 0
                        ? AppColors.success[500]
                        : AppColors.error[500],
                  ),
                ),
              ],
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutral[50]!,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AmountWidget(
                        amount: invested,
                        isCompact: false,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary[500],
                        ),
                      ),
                      Text(
                        'Invested',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral[200],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AmountWidget(
                        amount: dayHighPrice * qty,
                        isCompact: false,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: price * qty >= invested
                              ? AppColors.success[500]
                              : AppColors.error[500],
                        ),
                      ),
                      Text(
                        'Current',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral[200],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        return Text(
                          '${ltp > 0 ? '+' : ''} ${ltp.toStringAsFixed(2)} (${ltppercentage.toStringAsFixed(2)}%)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ltp > 0
                                ? AppColors.success[500]
                                : AppColors.error[500],
                          ),
                        );
                      }),
                      Text(
                        'Returns',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral[200],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            TextButton(
              onPressed: () {
                final smallcaseAuthToken =
                    context.read<AuthCubit>().state.user?.smallcaseAuthToken;
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
                      close: price,
                      change: ltp,
                      percentage: ltppercentage,
                      industry: '',
                      name: subtitle,
                      icon: image,
                    ),
                  );
                }
              },
              child: Text(
                'View stock details >',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary[500],
                ),
              ),
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary[500],
                    ),
                    onPressed: () {
                      _showBuySellBottomSheet(
                        context,
                        type: 'Buy',
                      );
                    },
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral[50],
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error[500],
                    ),
                    onPressed: () {
                      _showBuySellBottomSheet(
                        context,
                        type: 'Sell',
                      );
                    },
                    child: Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral[50],
                      ),
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

  void _showBuySellBottomSheet(BuildContext context, {required String type}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.85, // 85% of screen height
      ),
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<BuySellTransactionCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<SmallcaseLoginCubit>(),
            ),
          ],
          child: BuySellBottomSheet(
            authToken:
                context.read<AuthCubit>().state.user?.smallcaseAuthToken ?? '',
            type: type,
            price: price,
            symbol: symbol,
            name: subtitle,
          ),
        );
      },
    );
  }
}
