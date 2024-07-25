import 'package:flutter/material.dart';
import 'basket_buy_tabview.dart';
import 'basket_sell_tabview.dart';

class NeoBasketOrderScreen extends StatelessWidget {
  const NeoBasketOrderScreen({Key? key}) : super(key: key);

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
        body: const TabBarView(
          children: [
            BasketBuyTabview(),
            BasketSellTabview(),
          ],
        ),
      ),
    );
  }
}
