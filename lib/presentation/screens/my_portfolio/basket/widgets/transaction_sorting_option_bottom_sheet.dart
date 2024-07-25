import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../domain/entities/params/neobaskets/basket_buy_transaction_params.dart';
import '../../../../../domain/entities/params/neobaskets/basket_sell_transaction_params.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/neobaskets/basket_buy_transactions/basket_buy_transactions_cubit.dart';
import '../../../../cubits/neobaskets/basket_sell_transactions/basket_sell_transactions_cubit.dart';

class TransactionSortingOptionBottomSheet extends StatelessWidget {
  const TransactionSortingOptionBottomSheet({
    super.key,
    required this.selectedSortingOption,
    required this.basketId,
    required this.transactionType,
  });

  final String selectedSortingOption;
  final String basketId;
  final String transactionType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Sort by',
                      style: baseTextStyle16500,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      Assets.icons.sortByIcon.path.toString(),
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    Assets.icons.crossIconSolidBlack.path.toString(),
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Gap(5),
            const Divider(),
            const Gap(5),
            InkWell(
              onTap: () {
                _refreshData(context, 'DATE');
                Navigator.pop(context, 'DATE');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: baseTextStyle14500,
                  ),
                  Image.asset(
                    selectedSortingOption == 'DATE'
                        ? Assets.icons.upPointedArrow.path.toString()
                        : Assets.svgs.calenderSortIcon.path.toString(),
                    height: 24,
                    width: 24,
                  )
                ],
              ),
            ),
            const Gap(5),
            const Divider(),
            const Gap(5),
            InkWell(
              onTap: () {
                _refreshData(context, 'INVEST');
                Navigator.pop(context, 'INVEST');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Investment', style: baseTextStyle14400),
                  Image.asset(
                    selectedSortingOption == 'INVEST'
                        ? Assets.icons.upPointedArrow.path.toString()
                        : Assets.icons.rupeesIcon.path.toString(),
                    height: 24,
                    width: 24,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _refreshData(
    BuildContext context,
    String s,
  ) {
    if (transactionType == 'BUY') {
      context.read<BasketBuyTransactionsCubit>().getBasketBuyTransactions(
            BasketBuyTransactionParams(
              basketId: basketId,
              sortBy: s,
            ),
          );
    } else {
      context.read<BasketSellTransactionsCubit>().getBasketSellTransactions(
            BasketSellTransactionParams(
              basketId: basketId,
              sortBy: s,
            ),
          );
    }
  }
}
