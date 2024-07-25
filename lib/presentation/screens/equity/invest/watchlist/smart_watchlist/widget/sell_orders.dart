import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../../../../../../gen/assets.gen.dart';
import 'buy_sell_order_card.dart';

class SellOrders extends StatefulWidget {
  final List<BuySellTransaction> sellTransactions;
  const SellOrders({super.key, required this.sellTransactions});

  @override
  State<SellOrders> createState() => _SellOrdersState();
}

class _SellOrdersState extends State<SellOrders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: widget.sellTransactions.isEmpty
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
              itemCount: widget.sellTransactions.length,
              itemBuilder: (context, index) {
                return BuySellOrderCard(
                  symbol: widget.sellTransactions[index].tradingSymbol ?? '',
                  qty: widget.sellTransactions[index].filledQuantity ?? 0,
                  close: widget.sellTransactions[index].averagePrice ?? 0,
                  companyName: widget.sellTransactions[index].companyName ?? '',
                  date: widget.sellTransactions[index].txnCompletedDateTime ??
                      DateTime.now(),
                  type: 'sell',
                );
              },
            ),
    );
  }
}
