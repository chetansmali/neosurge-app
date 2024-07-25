import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart';
import '../../../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import 'dg_order_in_progress_card.dart';

class OrderInProgressListView extends HookWidget {
  const OrderInProgressListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        if (context.read<DgDeliveryTransactionCubit>().state
            is! DgDeliveryTransactionLoaded) {
          context
              .read<DgDeliveryTransactionCubit>()
              .fetchProcessingTransactions();
        }
        if (context.read<DgTransactionCubit>().state is! DgTransactionLoaded) {
          context.read<DgTransactionCubit>().fetchProcessingTransactions();
        }
        return null;
      },
      const [],
    );
    return MultiSliver(
      children: [
        BlocBuilder<DgTransactionCubit, DgTransactionState>(
          builder: (context, buySellState) {
            return BlocBuilder<DgDeliveryTransactionCubit,
                DgDeliveryTransactionState>(
              builder: (context, deliveryState) {
                if (deliveryState is DgDeliveryTransactionLoading ||
                    buySellState is DgDeliveryTransactionLoading) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (deliveryState is DgDeliveryTransactionLoadError) {
                  return AppErrorWidget(
                    errorType: deliveryState.appErrorType,
                    error: deliveryState.errorMessage,
                    onRetry: () => context
                        .read<DgDeliveryTransactionCubit>()
                        .fetchTransactions(
                            transactionStatus: DgTransactionStatus.processing,
                            pageSize: 1000),
                  );
                }
                if (buySellState is DgTransactionLoadError) {
                  return AppErrorWidget(
                    errorType: buySellState.appErrorType,
                    error: buySellState.errorMessage,
                    onRetry: () => context
                        .read<DgTransactionCubit>()
                        .fetchTransactions(
                            transactionStatus: DgTransactionStatus.processing,
                            pageSize: 1000),
                  );
                }
                if (deliveryState is DgDeliveryTransactionLoaded &&
                    buySellState is DgTransactionLoaded) {
                  final int deliveryCount =
                      deliveryState.transactionList.length;
                  final int buySellCount = buySellState.transactionList.length;
                  List<DgTransactionModel> pendingOrders = [];
                  for (int i = 0; i < deliveryCount; i++) {
                    pendingOrders.add(DgTransactionModel(
                        deliveryTransaction: deliveryState.transactionList[i]));
                  }
                  for (int i = 0; i < buySellCount; i++) {
                    pendingOrders.add(DgTransactionModel(
                        transaction: buySellState.transactionList[i]));
                  }
                  pendingOrders.sort(
                      (a, b) => b.transactionDate.compareTo(a.transactionDate));
                  if (pendingOrders.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return MultiSliver(
                    children: [
                      SliverPinnedHeader(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Order In Progress(${pendingOrders.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      SliverClip(
                        child: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DgOrderInProgressCard(
                                  pendingOrder: DgTransactionModel(
                                      transaction:
                                          pendingOrders[index].transaction,
                                      deliveryTransaction: pendingOrders[index]
                                          .deliveryTransaction)),
                            ),
                            childCount: pendingOrders.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ],
    );
  }
}
