import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart';
import '../../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../../routes/routes.dart';
import '../../digital_gold/widgets/metal_image.dart';

class MyPortfolioGoldInfoCard extends StatelessWidget {
  final bool isFullView;

  const MyPortfolioGoldInfoCard({Key? key, this.isFullView = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goldUser = context.watch<GoldUserCubit>().state.goldUser!;
    // final inrFormatter = NumberFormat.currency(
    //   locale: 'en-IN',
    //   symbol: '₹',
    //   decimalDigits: 2,
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Investments',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(10),
        InkWell(
          onTap: () => isFullView ? null : Navigator.pushNamed(context, Routes.digitalGoldInvestmentDetails),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFDDDDDD)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      MetalImage(metalType: MetalType.gold, size: isFullView ? 80 : null),
                      const Gap(2),
                      const Text(
                        'Gold Grams',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      if (isFullView) ...[
                        const Gap(20),
                        _TwoColText(title: 'Total Investment', subtitle: '${goldUser.goldBalance} grams'),
                        const Gap(20),
                        _TwoColText(title: 'Available to sell', subtitle: '${goldUser.transactionalGoldBalance} grams'),
                        const Gap(20),
                        BlocBuilder<GoldSilverRatesCubit, GoldSilverRatesState>(
                          builder: (context, state) {
                            return _TwoColText(
                                title: 'Current Value',
                                subtitle: (goldUser.transactionalGoldBalance * (state is GoldSilverRatesLoaded ? state.goldSilverRates.goldSellRate : 0)).toCurrencyWithSymbol(decimalDigits: 2));
                          },
                        ),
                        const Gap(20),
                        _TwoColText(
                          title: 'Cost of Investment ',
                          subtitle: (goldUser.totalGoldInvestment.toCurrencyWithSymbol(decimalDigits: 2)),
                        ),
                        const Gap(20),
                      ] else ...[
                        Text(
                          '${goldUser.transactionalGoldBalance} grams',
                          style: const TextStyle(fontSize: 10),
                        ),
                        const Gap(20),
                      ]
                    ],
                  ),
                ),
                SizedBox(
                  height: isFullView ? 300 : 100,
                  child: const VerticalDivider(thickness: 1),
                ),
                Expanded(
                  child: Column(
                    children: [
                      MetalImage(metalType: MetalType.silver, size: isFullView ? 80 : null),
                      const Gap(2),
                      const Text(
                        'Silver Grams',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      if (isFullView) ...[
                        const Gap(20),
                        _TwoColText(title: 'Total Investment', subtitle: '${goldUser.silverBalance} grams'),
                        const Gap(20),
                        _TwoColText(title: 'Available to sell', subtitle: '${goldUser.transactionalSilverBalance} grams'),
                        const Gap(20),
                        BlocBuilder<GoldSilverRatesCubit, GoldSilverRatesState>(
                          builder: (context, state) {
                            return _TwoColText(
                                title: 'Current Value',
                                subtitle: (goldUser.transactionalSilverBalance * (state is GoldSilverRatesLoaded ? state.goldSilverRates.silverSellRate : 0)).toCurrencyWithSymbol(decimalDigits: 2));
                          },
                        ),
                        const Gap(20),
                        _TwoColText(title: 'Cost of Investment ', subtitle: goldUser.totalSilverInvestment.toCurrencyWithSymbol(decimalDigits: 2)),
                        const Gap(20),
                      ] else ...[
                        Text(
                          '${goldUser.transactionalSilverBalance} grams',
                          style: const TextStyle(fontSize: 10),
                        ),
                        const Gap(20),
                      ]
                    ],
                  ),
                ),
                // if (isFullView) ...[
                //   _TwoColText(title: 'Total Investments', subtitle: '${goldUser.totalGoldInvestment} grams'),
                // ]
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _TwoColText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TwoColText({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Color(
                0xFFC0C0C0,
              ),
              fontSize: 12),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
