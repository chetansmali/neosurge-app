import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../cubits/neobaskets/basket_buy_order/basket_buy_order_cubit.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/amount_widget.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../mutual_funds/widgets/basket_custom_container.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../../common/common.dart';
import 'widgets/filter_and_sort_bottom_sheet.dart';

class BasketBuyTabview extends StatefulWidget {
  const BasketBuyTabview({Key? key}) : super(key: key);

  @override
  State<BasketBuyTabview> createState() => _BasketBuyTabviewState();
}

class _BasketBuyTabviewState extends State<BasketBuyTabview> {
  var selectedFilterOption = 'LUMPSUM';
  var selectedSortingOption = 'DATE';

  void _showBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BasketBuyOrderCubit>(),
          child: FilterAndSortBottomSheet(
            selectedFilterOption: selectedFilterOption,
            selectedSortingOption: selectedSortingOption,
            transactionType: 'BUY',
          ),
        );
      },
    );

    if (result != null) {
      selectedFilterOption = result['selectedFilterOption'];
      selectedSortingOption = result['selectedSortingOption'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        GestureDetector(
          onTap: () {
            _showBottomSheet(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF0FE),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: const Text(
                  'Filters',
                  style: TextStyle(
                    color: Color(0xFF297DFD),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        BlocBuilder<BasketBuyOrderCubit, BasketBuyOrderState>(
          builder: (context, state) {
            if (state is BasketBuyOrderInitial ||
                state is BasketBuyOrderLoading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            if (state is BasketBuyOrderError) {
              return AppErrorWidget(
                errorType: state.appErrorType,
                error: state.message,
              );
            }

            if (state is BasketBuyOrderLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.basketOrders.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return OrderDetailBox(
                      orderID: state.basketOrders[index].orderRef ?? '',
                      basketName: state.basketOrders[index].basketName ?? '',
                      date: DateFormat('dd MMM yyyy').format(
                        DateFormat('yyyy-MM-dd').parse(
                          state.basketOrders[index].date ?? '01-01-2000',
                        ),
                      ),
                      amount: state.basketOrders[index].amount ?? 0,
                      type: state.basketOrders[index].type ?? '',
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

class OrderDetailBox extends StatelessWidget {
  const OrderDetailBox({
    super.key,
    required this.orderID,
    required this.basketName,
    required this.date,
    required this.amount,
    required this.type,
  });

  final String basketName;
  final String orderID;
  final String date;
  final double amount;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.basketOrderTransactionDetailsScreen,
          arguments: BasketTransactionDetailsArgs(
            orderRef: orderID,
          ),
        );
      },
      child: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  basketName,
                  style: baseTextStyle14500,
                ),
                AmountWidget(
                  amount: amount,
                  isCompact: false,
                ),
              ],
            ),
            const Gap(5),
            Text(
              'Order ID: $orderID',
              style: baseTextStyle1,
            ),
            const Gap(5),
            Text(
              date,
              style: baseTextStyle1.copyWith(
                color: const Color(0xFF47586E),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                const Icon(
                  Icons.arrow_right,
                  size: 45,
                  color: Colors.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
