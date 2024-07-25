import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/custom_styles.dart';
import '../../../../../../common/common.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/basket_buy_transactions/basket_buy_transactions_cubit.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/widgets.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import 'widgets/transaction_sorting_option_bottom_sheet.dart';

class TransactionBuyTabview extends StatefulWidget {
  const TransactionBuyTabview({
    Key? key,
    required this.basketId,
  }) : super(key: key);
  final String basketId;
  @override
  State<TransactionBuyTabview> createState() => _TransactionBuyTabviewState();
}

class _TransactionBuyTabviewState extends State<TransactionBuyTabview> {
  var selectedSortingOption = 'DATE';

  void _showBottomSheet() async {
    selectedSortingOption = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BasketBuyTransactionsCubit>(),
          child: TransactionSortingOptionBottomSheet(
            selectedSortingOption: selectedSortingOption,
            basketId: widget.basketId,
            transactionType: 'BUY',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 116,
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: const Color(0xFFEBF0FE),
                    borderRadius: BorderRadius.circular(200)),
                child: Row(
                  children: [
                    const Text(
                      'Sort By',
                      style: TextStyle(color: Color(0xFF297DFD)),
                    ),
                    Image.asset(
                      Assets.icons.sortByIcon.path.toString(),
                      height: 20,
                      width: 20,
                      color: const Color(0xFF297DFD),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        BlocBuilder<BasketBuyTransactionsCubit, BasketBuyTransactionState>(
          builder: (context, state) {
            if (state is BasketBuyTransactionInitial ||
                state is BasketBuyTransactionLoading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            if (state is BasketBuyTransactionFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.error,
              );
            }

            if (state is BasketBuyTransactionSuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.transactions.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return _BuyTransactionTile(
                      orderID: state.transactions[index].orderRef ?? '',
                      date: DateFormat('dd MMM yyyy').format(
                        DateFormat('yyyy-MM-dd').parse(
                          state.transactions[index].date ?? '01-01-2000',
                        ),
                      ),
                      amount: state.transactions[index].amount ?? 0,
                      type: state.transactions[index].type ?? '',
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _BuyTransactionTile extends StatelessWidget {
  const _BuyTransactionTile({
    required this.orderID,
    required this.date,
    required this.amount,
    required this.type,
  });

  final String orderID;
  final String date;
  final double amount;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: $orderID',
                  style: baseTextStyle14500,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 2,
                    bottom: 2,
                  ),
                  decoration: orderBoxDecoration(type),
                  child: Text(
                    type,
                    style: orderTextStyle(type),
                  ),
                ),
              ],
            ),
            const Gap(5),
            Text(
              date,
              style: baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
            ),
            const Gap(10),
            const Divider(),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Investment',
                  style: baseTextStyle1.copyWith(
                    color: const Color(0xFF47586E),
                  ),
                ),
                AmountWidget(
                  amount: amount,
                  isCompact: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
