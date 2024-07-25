import 'package:flutter/material.dart';
import 'sell_orders.dart';

import '../../../../../../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import 'buy_orders.dart';

class OrdersScreen extends StatefulWidget {
  final Transactions transactions;
  const OrdersScreen({super.key, required this.transactions});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Tab> tabs = [
    const Tab(text: 'buy'),
    const Tab(text: 'sell'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BuyOrders(buyTransactions: widget.transactions.buyTransactions),
          SellOrders(sellTransactions: widget.transactions.sellTransactions),
        ],
      ),
    );
  }
}
