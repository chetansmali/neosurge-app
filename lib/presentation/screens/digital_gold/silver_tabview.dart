import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../di/get_it.dart';
import '../../../domain/entities/enums.dart';
import '../../cubits/digital_gold/checkout_rates_cubit/get_checkout_rates_cubit.dart';
import '../../cubits/digital_gold/silver_chart_cubit/silver_chart_cubit.dart';
import 'live_rate_widget.dart';
import 'widgets/dg_buy_sell_button.dart';
import 'widgets/dg_order_banner.dart';
import 'widgets/dg_order_delivery_banner.dart';
import 'widgets/silver_chart.dart';

class SilverTabview extends HookWidget {
  const SilverTabview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Gap(16),
          Column(
            children: [
              const LiveRateWidget(isGold: false),
              const Gap(20),
              BlocProvider(
                create: (context) => getIt<SilverChartCubit>()
                  ..fetchSilverData(GoldSilverTimePeriod.sixMonth),
                child: const SilverChart(),
              ),
              const Gap(20),
            ],
          ),
          BlocProvider(
            create: (context) => getIt<GetCheckoutRatesCubit>(),
            child: const DGBuySellButtons(metalType: MetalType.silver),
          ),
          const Gap(32),
          const DGOrderDeliveryBanner(),
          const Gap(20),
          const DGOrderProgressBanner(),
          const Gap(16),
        ],
      ),
    );
  }
}
