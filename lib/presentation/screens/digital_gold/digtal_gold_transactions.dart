import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_colors.dart';
import 'widgets/buy_sell__trans_tabview.dart';
import 'widgets/delivery_tabview.dart';

class DigitalGoldTransactionsScreen extends StatelessWidget {
  const DigitalGoldTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFEAEAEA), borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelColor: Colors.white,
                      tabs: [
                        Tab(text: 'Buy/Sell'),
                        Tab(text: 'Delivery'),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Gap(20),
            const Expanded(
                child: TabBarView(children: [
              BuySellTabTransView(),
              DeliveryTabView(),
            ])),
          ],
        ),
      ),
    );
  }
}
