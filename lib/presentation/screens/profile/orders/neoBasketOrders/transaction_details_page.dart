import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../common/common.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/neobaskets/basket_order_details/basket_order_details_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/modified_expansion_tile.dart';
import '../../../../widgets/widgets.dart';
import '../../../mutual_funds/widgets/basket_custom_container.dart';

class BasketOrderTransactionDetailsScreen extends StatelessWidget {
  const BasketOrderTransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<BasketOrderDetailsCubit, BasketOrderDetailsState>(
        builder: (context, state) {
          if (state is BasketOrderDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is BasketOrderDetailsError) {
            return AppErrorWidget(
              errorType: state.appErrorType,
              error: state.message,
            );
          }

          if (state is BasketOrderDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.icons.neoBasketIcon.path.toString(),
                          height: 40,
                          width: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.basketOrderTransactionDetail.basketName ??
                                    '',
                                style: baseTextStyle14500,
                              ),
                              Text(
                                state.basketOrderTransactionDetail
                                        .transactionType ??
                                    '',
                                style: baseTextStyle14500.copyWith(
                                  color: state.basketOrderTransactionDetail
                                              .transactionType
                                              ?.toLowerCase() ==
                                          'buy'
                                      ? AppColors.green
                                      : const Color(0xFFCC3A3A),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  BasketCustomContainer(
                    child: Column(
                      children: [
                        _TransactionDetail(
                          title: 'Date',
                          value: DateFormat('dd MMM yyyy').format(
                            DateFormat('yyyy-MM-dd').parse(
                              state.basketOrderTransactionDetail.date ??
                                  '01-01-2000',
                            ),
                          ),
                        ),
                        _TransactionDetail(
                          title: 'Order Type',
                          value: state.basketOrderTransactionDetail.type ?? '',
                        ),
                        _TransactionDetail(
                          title: 'Total Investment',
                          value:
                              '₹ ${state.basketOrderTransactionDetail.amount}',
                        ),
                        _TransactionDetail(
                          title: 'Funds Invested in',
                          value: state.basketOrderTransactionDetail.fundsCount
                              .toString(),
                        ),
                        _TransactionDetail(
                          title: 'Order ID',
                          value: state.basketOrderTransactionDetail.orderRef
                                  ?.toUpperCase() ??
                              '',
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<BasketOrderDetailsCubit, BasketOrderDetailsState>(
                    builder: (context, state) {
                      if (state is BasketOrderDetailsLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      if (state is BasketOrderDetailsError) {
                        return AppErrorWidget(
                          errorType: state.appErrorType,
                          error: state.message,
                        );
                      }

                      if (state is BasketOrderDetailsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Funds Details (${state.basketOrderTransactionDetail.fundsCount})',
                                style: baseTextStyle14500,
                              ),
                            ),
                            const Gap(10),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.basketOrderTransactionDetail.fundsCount,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return _TransactionFundDetailTile(
                                  status: state.basketOrderTransactionDetail
                                      .funds[index].status,
                                  name: state.basketOrderTransactionDetail
                                      .funds[index].name,
                                  transactionID: state
                                      .basketOrderTransactionDetail
                                      .funds[index]
                                      .transactionID,
                                  amount: state.basketOrderTransactionDetail
                                      .funds[index].amount,
                                  nav: state.basketOrderTransactionDetail
                                      .funds[index].nav,
                                  units: state.basketOrderTransactionDetail
                                      .funds[index].units,
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TransactionFundDetailTile extends StatefulWidget {
  const _TransactionFundDetailTile({
    Key? key,
    required this.status,
    required this.name,
    required this.transactionID,
    required this.amount,
    this.units,
    this.nav,
  }) : super(key: key);

  final String status;
  final String name;
  final String transactionID;
  final double amount;
  final double? units;
  final double? nav;

  @override
  State<_TransactionFundDetailTile> createState() =>
      __TransactionFundDetailTileState();
}

class __TransactionFundDetailTileState
    extends State<_TransactionFundDetailTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: BasketCustomContainer(
        child: ModifiedExpansionTile(
          hasTrailing: false,
          textColor: Colors
              .black, // This line ensures the title color remains constant
          iconColor: Colors.black,
          trailing: Icon(
            _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 30,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          tilePadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: baseTextStyle14500,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Allow up to 2 lines. Adjust as needed.
                    ),
                  ),
                  if (widget.status.toLowerCase() != 'failed') ...[
                    const Gap(20),
                    RotatedBox(
                      quarterTurns: _isExpanded ? 1 : 3,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ]
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TransactionDetail(
                    title: 'Transaction ID',
                    value: widget.transactionID,
                  ),
                  _TransactionDetail(
                    title: 'Investment Amount',
                    value: '₹ ${widget.amount.toStringAsFixed(2)}',
                  ),
                  _buildTransactionStatusDetail(
                    title: 'Status',
                    value: widget.status,
                  ),
                  if (widget.status == 'Completed') ...[
                    _TransactionDetail(
                      title: 'Units Allocated',
                      value: widget.units?.toStringAsFixed(2) ?? '0.00',
                    ),
                    _TransactionDetail(
                      title: 'Average Purchase NAV',
                      value: '₹ ${widget.nav?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                  ]
                ],
              ),
            ],
          ),
          children: widget.status.toLowerCase() == 'failed'
              ? []
              : [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Status',
                          style: baseTextStyle14500,
                        ),
                        const Gap(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Assets.pngs.orderStatus.path.toString(),
                                  height: 72,
                                  width: 24,
                                ),
                                Image.asset(
                                  Assets.pngs.orderStatus.path.toString(),
                                  height: 72,
                                  width: 24,
                                ),
                                if (widget.status == 'Completed') ...[
                                  Assets.pngs.orderStatusGreen.image(
                                    height: 24,
                                    width: 24,
                                  )
                                ] else ...[
                                  Image.asset(
                                    Assets.pngs.orderStatusYellow.path
                                        .toString(),
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(8),
                                Text(
                                  'Payment Collected',
                                  style: baseTextStyle,
                                ),
                                const Gap(58),
                                Text(
                                  'Order Placed with AMC',
                                  style: baseTextStyle,
                                ),
                                const Gap(42),
                                Material(
                                  elevation: 0.5,
                                  borderRadius: BorderRadius.circular(6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.status == 'Completed'
                                          ? 'Units Allocated'
                                          : 'Units Allocation Waiting',
                                      style: baseTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
        ),
      ),
    );
  }

  Padding _buildTransactionStatusDetail({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
            decoration: orderBoxDecoration(value),
            child: Text(
              value,
              style: orderTextStyle(value),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionDetail extends StatelessWidget {
  const _TransactionDetail({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
          ),
          Text(
            value,
            style: baseTextStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}
