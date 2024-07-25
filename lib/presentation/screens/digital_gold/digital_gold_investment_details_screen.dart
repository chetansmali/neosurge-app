import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../di/get_it.dart';
import '../../../domain/entities/enums.dart';
import '../../cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart';
import '../../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../../theme/app_colors.dart';
import '../my_portfolio/widgets/my_portfolio_gold_info_card.dart';
import 'widgets/buy_sell__trans_tabview.dart';
import 'widgets/delivery_tabview.dart';

class DigitalGoldInvestmentDetailsScreen extends HookWidget {
  const DigitalGoldInvestmentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Investment Details'),
        ),
        body: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const SliverAppBar(
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: MyPortfolioGoldInfoCard(isFullView: true),
                    ),
                    collapsedHeight: 450,
                    expandedHeight: 450,
                    automaticallyImplyLeading: false,
                  ),
                ];
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Transaction History',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        color: Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        BlocProvider(
                          create: (context) => getIt<DgTransactionCubit>()
                            ..fetchTransactions(
                                transactionStatus: DgTransactionStatus.success),
                          child: const BuySellTabTransView(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              getIt<DgDeliveryTransactionCubit>()
                                ..fetchTransactions(
                                    transactionStatus:
                                        DgTransactionStatus.success),
                          child: const DeliveryTabView(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) => AnimatedPositioned(
                bottom: scrollController.offset > 450 ? 20 : -80,
                left: MediaQuery.of(context).size.width / 2 - 30,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
