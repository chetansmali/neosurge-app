import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../cubits/neobaskets/basket_sell_order/basket_sell_order_cubit.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/amount_widget.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../mutual_funds/widgets/basket_custom_container.dart';
import 'widgets/filter_and_sort_bottom_sheet.dart';

class BasketSellTabview extends StatefulWidget {
  const BasketSellTabview({Key? key}) : super(key: key);

  @override
  State<BasketSellTabview> createState() => _BasketSellTabviewState();
}

class _BasketSellTabviewState extends State<BasketSellTabview> {
  var selectedFilterOption = 'LUMPSUM';

  var selectedSortingOption = 'DATE';

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BasketSellOrderCubit>(),
          child: FilterAndSortBottomSheet(
            selectedFilterOption: selectedFilterOption,
            selectedSortingOption: selectedSortingOption,
            transactionType: 'SELL',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    borderRadius: BorderRadius.circular(200)),
                child: const Text(
                  'Sort By',
                  style: TextStyle(
                    color: Color(0xFF297DFD),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        BlocBuilder<BasketSellOrderCubit, BasketSellOrderState>(
          builder: (context, state) {
            if (state is BasketSellOrderInitial ||
                state is BasketSellOrderLoading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            if (state is BasketSellOrderError) {
              return AppErrorWidget(
                errorType: state.appErrorType,
                error: state.message,
              );
            }

            if (state is BasketSellOrderLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.basketOrders.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return OrderDetailBox(
                      orderID: state.basketOrders[index].orderRef,
                      basketName: state.basketOrders[index].basketName ?? '',
                      date: DateFormat('dd MMM yyyy').format(
                        DateFormat('yyyy-MM-dd').parse(
                          state.basketOrders[index].date ?? '01-01-2001',
                        ),
                      ),
                      amount: state.basketOrders[index].amount ?? 0,
                      type: state.basketOrders[index].status ?? 'NA',
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
    required this.basketName,
    required this.date,
    required this.amount,
    required this.type,
    required this.orderID,
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
                )
              ],
            ),
            const Gap(5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                date,
                style: baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
              ),
              const Icon(
                Icons.arrow_right,
                size: 45,
                color: Colors.black,
              )
            ]),
            Container(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
              decoration: orderBoxDecoration(type),
              child: Text(type, style: orderTextStyle(type)),
            ),
            const Gap(5),
          ],
        ),
      ),
    );
  }
}
