import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../data/models/digital_gold/gold_silver_rates_model.dart';
import '../../../domain/entities/enums.dart';
import '../../cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart';
import '../../theme/app_colors.dart';

class LiveRateWidget extends StatefulWidget {
  final bool isGold;

  const LiveRateWidget({Key? key, required this.isGold}) : super(key: key);

  @override
  State<LiveRateWidget> createState() => _LiveRateWidgetState();
}

class _LiveRateWidgetState extends State<LiveRateWidget> {
  @override
  void initState() {
    if (context.read<GoldSilverRatesCubit>().state is GoldSilverRatesInitial) {
      context.read<GoldSilverRatesCubit>().fetchGoldRates();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.error[50],
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              const Icon(
                Icons.sensors,
                color: AppColors.errorRed,
                size: 16.0,
              ),
              const Gap(4.0),
              Text(
                'Live Rates',
                style: baseTextStyle12500.copyWith(color: AppColors.errorRed),
              ),
            ],
          ),
        ),
        const Gap(12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<GoldSilverRatesCubit, GoldSilverRatesState>(
              builder: (context, state) {
                if (state is GoldSilverRatesLoaded) {
                  return Text(
                    getRates(state.goldSilverRates, state.quantity),
                    style: baseTextStyle12400.copyWith(
                      color: AppColors.neutral[400],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        )
      ],
    );
  }

  String getRates(
      GoldSilverRatesModel goldSilverRates, GoldSilverRatesQuantity quantity) {
    if (widget.isGold) {
      return "${NumberFormat.currency(
        decimalDigits: 2,
        locale: 'en-IN',
        symbol: '₹',
      ).format(goldSilverRates.goldBuyRate)} / gm";
    } else {
      return "${NumberFormat.currency(
        decimalDigits: 2,
        locale: 'en-IN',
        symbol: '₹',
      ).format(goldSilverRates.silverBuyRate)} / gm";
    }
  }
}
