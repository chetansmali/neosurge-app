import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../di/get_it.dart';
import '../../../domain/entities/enums.dart';
import '../../cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart';
import '../../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../../theme/app_colors.dart';
import 'widgets/buy_sell__trans_tabview.dart';
import 'widgets/delivery_tabview.dart';

class DGTxnAndDeliveryScreen extends StatefulWidget {
  const DGTxnAndDeliveryScreen({super.key});

  @override
  State<DGTxnAndDeliveryScreen> createState() => _DGTxnAndDeliveryScreenState();
}

class _DGTxnAndDeliveryScreenState extends State<DGTxnAndDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 4.0,
                dividerHeight: 0.0,
                labelColor: AppColors.neutral[900],
                unselectedLabelColor: AppColors.neutral[400],
                tabs: const [
                  Tab(text: 'Buy/Sell'),
                  Tab(text: 'Delivery'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  clipBehavior: Clip.none,
                  children: [
                    BlocProvider(
                      create: (context) => getIt<DgTransactionCubit>()
                        ..fetchTransactions(
                            transactionStatus: DgTransactionStatus.success),
                      child: const BuySellTabTransView(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<DgDeliveryTransactionCubit>()
                        ..fetchTransactions(
                            transactionStatus: DgTransactionStatus.success),
                      child: const DeliveryTabView(),
                    ),
                  ],
                ),
              ),
              const Gap(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
