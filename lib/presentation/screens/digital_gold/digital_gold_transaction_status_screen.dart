import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../data/models/digital_gold/razor_pay_error_response_model.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';

class DigitalGoldTransactionStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final DGTransactionType transactionType;
  final RazorPayErrorResponseModel? errorResponse;
  final CreateOrderParams orderDetails;

  const DigitalGoldTransactionStatusScreen({
    Key? key,
    required this.isSuccess,
    required this.transactionType,
    required this.orderDetails,
    this.errorResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transactionType == DGTransactionType.delivery) {
      Timer(const Duration(seconds: 2), () {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSuccess) ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.gifs.dgPaymentSuccess.image(
                          height: 200,
                          width: 200,
                        ),
                        const Gap(40),
                        if (transactionType != DGTransactionType.sell)
                          Text(
                              transactionType == DGTransactionType.delivery
                                  ? 'On the way!'
                                  : 'Payment complete',
                              style: baseTextStyle21500.copyWith(
                                  color: AppColors.neutral[500])),
                        const Gap(32),
                        if (transactionType != DGTransactionType.delivery)
                          _OrderDetailsContainer(
                              isSuccess: isSuccess,
                              orderDetails: orderDetails,
                              transactionType: transactionType)
                        else
                          Text(
                            'Your Digital Gold delivery is on the way',
                            style: baseTextStyle14400.copyWith(
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.digitalGoldDelivery),
                        child: const Text('Get delivery'),
                      )),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (transactionType != DGTransactionType.delivery) {
                              final oldNaveTab =
                                  context.read<NavCubit>().state.navTabEntity;
                              context.read<NavCubit>().changeTab(
                                    oldNaveTab.copyWith(
                                      mainTabIndex: 4,
                                      portfolioTabIndex: 1,
                                    ),
                                  );

                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            }
                          },
                          child: Text(
                            transactionType == DGTransactionType.delivery
                                ? 'Ok, Got it'
                                : 'Go home',
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.gifs.dgPaymentFailure.image(
                          height: 200,
                          width: 200,
                        ),
                        const Gap(40),
                        Text(
                          'Payment failed',
                          style: baseTextStyle21500.copyWith(
                              color: AppColors.neutral[500]),
                        ),
                        const Gap(32),
                        if (transactionType != DGTransactionType.delivery)
                          _OrderDetailsContainer(
                            isSuccess: isSuccess,
                            orderDetails: orderDetails,
                            transactionType: transactionType,
                          )
                        else
                          Text(
                            'Failed to place your Digital Gold delivery order',
                            style: baseTextStyle14400.copyWith(
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        const Gap(40),
                      ],
                    ),
                  ),
                  if (transactionType != DGTransactionType.delivery)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel')),
                        ),
                        const Gap(30),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Try Again')),
                        ),
                      ],
                    ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderDetailsContainer extends StatelessWidget {
  const _OrderDetailsContainer({
    required this.orderDetails,
    required this.transactionType,
    required this.isSuccess,
  });

  final bool isSuccess;
  final CreateOrderParams orderDetails;
  final DGTransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: AppColors.neutral[50]!)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              orderDetails.metalType == MetalType.gold
                  ? Assets.pngs.goldBrick.image(scale: 1.5)
                  : Assets.pngs.silverBrick.image(scale: 1.5),
              const Gap(8.0),
              Expanded(
                child: Text(
                  'Digital ${orderDetails.metalType == MetalType.gold ? 'Gold' : 'Silver'}',
                  style: baseTextStyle16500.copyWith(
                      color: AppColors.neutral[400]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: transactionType == DGTransactionType.buy
                      ? AppColors.primary[50]
                      : AppColors.error[50],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Text(
                  transactionType == DGTransactionType.buy ? 'Buy' : 'Sell',
                  style: baseTextStyle12500.copyWith(
                      color: transactionType == DGTransactionType.buy
                          ? AppColors.primaryColor
                          : AppColors.errorRed),
                ),
              ),
            ],
          ),
          const Gap(12.0),
          Divider(color: AppColors.neutral[50]),
          const Gap(12.0),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Quantity',
                style:
                    baseTextStyle14400.copyWith(color: AppColors.neutral[400]),
              )),
              Text(
                '${orderDetails.metalWeight} gm',
                style:
                    baseTextStyle14500.copyWith(color: AppColors.neutral[500]),
              ),
            ],
          ),
          const Gap(8.0),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Amount ${transactionType == DGTransactionType.buy ? isSuccess ? 'paid' : 'payable' : isSuccess ? 'received' : 'receivable'}',
                style:
                    baseTextStyle14400.copyWith(color: AppColors.neutral[400]),
              )),
              Text(
                Utils.compactCurrency(orderDetails.amount),
                style:
                    baseTextStyle14500.copyWith(color: AppColors.neutral[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
