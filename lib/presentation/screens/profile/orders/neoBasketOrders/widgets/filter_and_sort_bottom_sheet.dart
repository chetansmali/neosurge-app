import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../domain/entities/params/neobaskets/basket_buy_order_param.dart';
import '../../../../../../domain/entities/params/neobaskets/basket_sell_order_param.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/neobaskets/basket_buy_order/basket_buy_order_cubit.dart';
import '../../../../../cubits/neobaskets/basket_sell_order/basket_sell_order_cubit.dart';

class FilterAndSortBottomSheet extends StatelessWidget {
  const FilterAndSortBottomSheet({
    super.key,
    required this.selectedFilterOption,
    required this.selectedSortingOption,
    required this.transactionType,
  });

  final String selectedFilterOption;
  final String selectedSortingOption;
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
            // const Text(
            //   'Filter by',
            //   style: baseTextStyle16500,
            // ),
            // const Gap(5),
            // const Divider(),
            // const Gap(5),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         _closeBottomSheet(context, 'ALL', selectedSortingOption);
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 12,
            //           vertical: 6,
            //         ),
            //         decoration: orderBoxDecoration('All'),
            //         child: Text('All', style: orderTextStyle('All')),
            //       ),
            //     ),
            //     const Gap(10),
            //     GestureDetector(
            //       onTap: () {
            //         _closeBottomSheet(
            //             context, 'LUMPSUM', selectedSortingOption);
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 12,
            //           vertical: 6,
            //         ),
            //         decoration: orderBoxDecoration('Lumpsum'),
            //         child: Text('Lumpsum', style: orderTextStyle('Lumpsum')),
            //       ),
            //     ),
            //     const Gap(10),
            //     GestureDetector(
            //       onTap: () {
            //         _closeBottomSheet(context, 'SIP', selectedSortingOption);
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 12,
            //           vertical: 6,
            //         ),
            //         decoration: orderBoxDecoration('SIP'),
            //         child: Text('SIP', style: orderTextStyle('SIP')),
            //       ),
            //     ),
            //   ],
            // ),
            // const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sort by', style: baseTextStyle16500),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Assets.icons.crossIconSolidBlack.image(
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Gap(5),
            const Divider(),
            const Gap(5),
            InkWell(
              onTap: () {
                _closeBottomSheet(context, selectedFilterOption, 'DATE');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: baseTextStyle14400,
                  ),
                  selectedSortingOption == 'DATE'
                      ? Assets.svgs.sortUp.svg()
                      : Assets.svgs.calenderSortIcon.svg(),
                ],
              ),
            ),
            const Gap(5),
            const Divider(),
            const Gap(5),
            InkWell(
              onTap: () {
                _closeBottomSheet(context, selectedFilterOption, 'INVEST');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Investment', style: baseTextStyle14400),
                  selectedSortingOption == 'INVEST'
                      ? Assets.svgs.sortUp.svg()
                      : Assets.svgs.calenderSortIcon.svg(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _closeBottomSheet(BuildContext context, String filter, String sort) {
    Navigator.pop(
      context,
      {
        'selectedFilterOption': filter,
        'selectedSortingOption': sort,
      },
    );

    if (transactionType == 'BUY') {
      context.read<BasketBuyOrderCubit>().getBasketBuyOrder(
            BasketBuyOrderParam(
              sortBy: selectedSortingOption.toLowerCase(),
            ),
          );
    } else {
      context.read<BasketSellOrderCubit>().getBasketSellOrder(
            BasketSellOrderParam(
              sortBy: selectedSortingOption.toLowerCase(),
            ),
          );
    }
  }
}
