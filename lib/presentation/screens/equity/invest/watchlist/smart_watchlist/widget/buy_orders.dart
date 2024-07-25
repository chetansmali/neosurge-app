import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../../../../../../gen/assets.gen.dart';
import 'buy_sell_order_card.dart';

class BuyOrders extends StatefulWidget {
  final List<BuySellTransaction> buyTransactions;
  const BuyOrders({super.key, required this.buyTransactions});

  @override
  State<BuyOrders> createState() => _BuyOrdersState();
}

class _BuyOrdersState extends State<BuyOrders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: widget.buyTransactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.pngs.noOrders.image(),
                const Gap(24),
                Text(
                  'No stock found at the moment',
                  style: baseTextStyle2,
                ),
              ],
            )
          : ListView.builder(
              itemCount: widget.buyTransactions.length,
              itemBuilder: (context, index) {
                return BuySellOrderCard(
                  symbol: widget.buyTransactions[index].tradingSymbol ?? '',
                  qty: widget.buyTransactions[index].filledQuantity ?? 0,
                  close: widget.buyTransactions[index].averagePrice ?? 0.0,
                  companyName: widget.buyTransactions[index].companyName ?? '',
                  date: widget.buyTransactions[index].txnCompletedDateTime ??
                      DateTime.now(),
                  type: 'buy',
                );
              },
            ),
    );
  }
}
