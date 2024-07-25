import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'lumpsum_cart_tabview.dart';
import 'sip_cart_tabview.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: AppColors.neutral[300],
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(
                color: AppColors.secondaryViolet,
                width: 4.0,
              ),
              borderRadius: BorderRadius.circular(10),
              insets: const EdgeInsets.symmetric(horizontal: 20.0),
            ),
            tabs: const [
              Tab(
                text: 'Lumpsum',
              ),
              Tab(
                text: 'Monthly SIP',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                LumpsumCartTabView(),
                SipCartTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
