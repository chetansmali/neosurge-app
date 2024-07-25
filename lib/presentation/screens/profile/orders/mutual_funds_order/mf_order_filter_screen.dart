import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../../../domain/entities/enums.dart';
import '../../../../cubits/mutual_funds/mf_orders_filter_sort/mf_orders_filter_sort_cubit.dart';
import '../../../../theme/app_colors.dart';

class MFOrderFilterSortScreen extends HookWidget {
  const MFOrderFilterSortScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsCubit = context.read<MfOrdersFilterSortCubit>();
    final orderStatusFilter = useState(fsCubit.state.orderStatus);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          if (orderStatusFilter.value != null)
            TextButton(
              onPressed: () {
                orderStatusFilter.value = null;
              },
              child: const Text(
                'Clear',
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Order Status'),
                Wrap(
                  children: List.generate(
                    3,
                    (index) {
                      final mfOrderStatus = MFOrderStatus.values[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ChoiceChip(
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.borderColorGrey,
                          elevation: 2,
                          labelStyle: TextStyle(
                              color: mfOrderStatus == orderStatusFilter.value
                                  ? Colors.white
                                  : Colors.black),
                          label: Text(MFOrderStatus.values[index].toString()),
                          selected: orderStatusFilter.value == mfOrderStatus,
                          onSelected: (selected) {
                            orderStatusFilter.value = mfOrderStatus;
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                const Spacer(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(0, 4),
                ),
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const Gap(30),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (orderStatusFilter.value == null) {
                          fsCubit.clearFilter();
                        } else {
                          fsCubit.applyFilter(orderStatusFilter.value!);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
