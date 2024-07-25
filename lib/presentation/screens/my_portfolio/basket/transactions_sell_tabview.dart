import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/custom_styles.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/basket_sell_transactions/basket_sell_transactions_cubit.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import 'widgets/transaction_sorting_option_bottom_sheet.dart';

class TransactionSellTabview extends StatefulWidget {
  const TransactionSellTabview({
    Key? key,
    required this.basketId,
  }) : super(key: key);

  final String basketId;

  @override
  State<TransactionSellTabview> createState() => _TransactionSellTabviewState();
}

class _TransactionSellTabviewState extends State<TransactionSellTabview> {
  var selectedSortingOption = 'DATE';

  void _showBottomSheet(BuildContext context) async {
    selectedSortingOption = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BasketSellTransactionsCubit>(),
          child: TransactionSortingOptionBottomSheet(
            selectedSortingOption: selectedSortingOption,
            basketId: widget.basketId,
            transactionType: 'SELL',
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
              _showBottomSheet(context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 116,
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 8,
                  bottom: 8,
                ),
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
        BlocBuilder<BasketSellTransactionsCubit, BasketSellTransactionState>(
            builder: (context, state) {
          if (state is BasketSellTransactionInitial ||
              state is BasketSellTransactionLoading) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          if (state is BasketSellTransactionFailure) {
            return AppErrorWidget(
              errorType: state.errorType,
              error: state.error,
            );
          }

          if (state is BasketSellTransactionSuccess) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.transactions.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return OrderDetailBox(
                    date: DateFormat('dd MMM yyyy').format(
                      DateFormat('yyyy-MM-dd').parse(
                        state.transactions[index].date ?? '01-01-2000',
                      ),
                    ),
                    amount: state.transactions[index].amount ?? 0.0,
                    orderID: state.transactions[index].orderRef,
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

class OrderDetailBox extends StatelessWidget {
  const OrderDetailBox({
    super.key,
    required this.orderID,
    required this.date,
    required this.amount,
  });

  final String orderID;
  final String date;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: $orderID',
              style: baseTextStyle14500,
            ),
            const Gap(5),
            Text(
              date,
              style: baseTextStyle1.copyWith(
                color: const Color(0xFF47586E),
              ),
            ),
            const Gap(10),
            const Divider(),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sell Amount',
                  style: baseTextStyle1.copyWith(
                    color: const Color(0xFFFB4F39),
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
