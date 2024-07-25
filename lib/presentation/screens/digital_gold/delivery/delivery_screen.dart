import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/digital_gold/delivery_product_cubit/delivery_product_cubit.dart';
import '../../../theme/app_colors.dart';
import 'gold_deliver_tabview.dart';
import 'silver_deliver_tabview.dart';

class DigitalGoldDeliveryScreen extends StatelessWidget {
  const DigitalGoldDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Get Delivery')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              labelColor: AppColors.neutral[900],
              labelStyle: baseTextStyle14500,
              unselectedLabelColor: AppColors.neutral[400],
              unselectedLabelStyle: baseTextStyle14400,
              indicatorColor: AppColors.primaryColor,
              indicatorWeight: 4.0,
              dividerHeight: 0.0,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Gold'),
                Tab(text: 'Silver'),
              ],
            ),
            const Gap(24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select your option',
                    style: baseTextStyle16500.copyWith(color: Colors.black),
                  ),
                  Text(
                    'Making and Delivery charges calculated at next step',
                    style: baseTextStyle10400.copyWith(
                        color: AppColors.neutral[400]),
                  ),
                ],
              ),
            ),
            const Gap(12.0),
            Expanded(
              child: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) => getIt<DeliveryProductCubit>()
                      ..getDeliveryProducts(MetalType.gold),
                    child: const GoldDeliverTabView(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<DeliveryProductCubit>()
                      ..getDeliveryProducts(MetalType.silver),
                    child: const SilverDeliverTabView(),
                  ),
                ],
              ),
            ),
            const Gap(30.0),
          ],
        ),
      ),
    );
  }
}
