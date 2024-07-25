import 'package:flutter/material.dart';
import 'transactions_buy_tabview.dart';
import 'transactions_sell_tabview.dart';

class BasketTransactionsScreen extends StatelessWidget {
  const BasketTransactionsScreen({
    Key? key,
    required this.basketId,
  }) : super(key: key);
  final String basketId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Orders'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'BUY'),
              Tab(text: 'SELL'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TransactionBuyTabview(
              basketId: basketId,
            ),
            TransactionSellTabview(
              basketId: basketId,
            ),
          ],
        ),
      ),
    );
  }
}
