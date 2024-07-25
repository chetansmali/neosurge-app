import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../../domain/entities/params/equity/buy_sell_transaction.dart';
import '../../../../../../../domain/entities/params/equity/ligin/smallcase_login.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../../../cubits/equity/buy_sell_transaction_cubit.dart';
import '../../../../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../../../../theme/app_colors.dart';
import '../etf_order_placed.dart';

class ETFOrderBottomSheet extends StatefulWidget {
  const ETFOrderBottomSheet({
    super.key,
    required this.amount,
    this.available,
    required this.isBuying,
    required this.name,
    this.imageUrl,
    this.symbol,
    required this.authToken,
  });
  final String name;
  final String? imageUrl;
  final double amount;
  final int? available;
  final bool isBuying;
  final String? symbol;
  final String authToken;

  @override
  State<ETFOrderBottomSheet> createState() => _ETFOrderBottomSheetState();
}

class _ETFOrderBottomSheetState extends State<ETFOrderBottomSheet> {
  final TextEditingController _textController =
      TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.isBuying ? 'Buy' : 'Sell'} Order",
                      style: baseTextStyle18500.copyWith(
                          color: widget.isBuying
                              ? AppColors.primaryColor
                              : AppColors.errorRed),
                    ),
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the bottom sheet
                      },
                    ),
                  ],
                ),
                const Gap(28),
                Row(
                  children: [
                    Text(
                      "Regular",
                      style: baseTextStyle14500.copyWith(
                          color: widget.isBuying
                              ? AppColors.primaryColor
                              : AppColors.errorRed),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary[50],
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                          color: AppColors.primary[500]!,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, right: 13, top: 4, bottom: 4),
                        child: Text(
                          'NSE',
                          style: baseTextStyle12700.copyWith(
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(28),
                Row(
                  children: [
                    Expanded(
                        child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: widget.isBuying
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (int.parse(_textController.text) > 1) {
                                    setState(() => _textController.text =
                                        '${int.parse(_textController.text) - 1}');
                                  }
                                },
                                color: widget.isBuying
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed,
                                icon: const Icon(Icons.remove_rounded),
                              ),
                              Expanded(
                                child: TextField(
                                  onTapOutside: (onTapOutside) =>
                                      FocusScopeNode().unfocus(),
                                  controller: _textController,
                                  style: baseTextStyle14400.copyWith(
                                      color: widget.isBuying
                                          ? AppColors.primaryColor
                                          : AppColors.errorRed),
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.transparent,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (!widget.isBuying) {
                                    if (int.parse(_textController.text) <
                                        widget.available!) {
                                      setState(() => _textController.text =
                                          '${int.parse(_textController.text) + 1}');
                                    }
                                  } else {
                                    setState(() => _textController.text =
                                        '${int.parse(_textController.text) + 1}');
                                  }
                                },
                                color: widget.isBuying
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed,
                                icon: const Icon(Icons.add_rounded),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -8,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white,
                            child: Text(
                              'Units',
                              style: baseTextStyle10400.copyWith(
                                  color: AppColors.neutral[200]),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const Gap(20),
                    Expanded(
                        child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: widget.isBuying
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Market',
                                style: baseTextStyle14400.copyWith(
                                    color: widget.isBuying
                                        ? AppColors.primaryColor
                                        : AppColors.errorRed),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -8,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white,
                            child: Text(
                              'Order type',
                              style: baseTextStyle10400.copyWith(
                                  color: AppColors.neutral[200]),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                if (!widget.isBuying) const Gap(12),
                if (!widget.isBuying)
                  Row(
                    children: [
                      Text('Available holdings:\t',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[300])),
                      Text(
                        '${widget.available}',
                        style: baseTextStyle12500.copyWith(
                            color: AppColors.neutral[500]),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const Gap(20),
          Divider(color: Colors.black.withOpacity(0.1)),
          const Gap(20),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Approximate amount',
                    style: baseTextStyle14500.copyWith(
                        color: AppColors.neutral[300]),
                  ),
                  Expanded(
                      child: Text(
                    '₹${(widget.amount * int.parse(_textController.text)).toStringAsFixed(2)}',
                    style: baseTextStyle14500.copyWith(
                        color: AppColors.neutral[500]),
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              const Gap(28),
              ElevatedButton(
                onPressed: () {
                  bool isTokenExpired = JwtDecoder.isExpired(widget.authToken);

                  if (isTokenExpired) {
                    context.read<SmallcaseLoginCubit>().fetchSmallcaseLogin(
                          SmallCaseLoginParams(
                            profileType: "INVESTING",
                            broker: context
                                    .read<AuthCubit>()
                                    .state
                                    .user!
                                    .equityBroker ??
                                '',
                            email:
                                context.read<AuthCubit>().state.user!.emailId,
                            smallcaseAuthToken: widget.authToken,
                          ),
                        );
                  } else {
                    context.read<BuySellTransactionCubit>().fetchBuySell(
                          BuySellTransactionParams(
                            smallcaseAuthToken: widget.authToken,
                            email:
                                context.read<AuthCubit>().state.user!.emailId,
                            orderConfig: OrderConfig(
                              securities: [
                                Security(
                                  ticker: widget.symbol ?? '',
                                  type: widget.isBuying ? 'BUY' : 'SELL',
                                  quantity: int.parse(_textController.text),
                                )
                              ],
                              type: "SECURITIES",
                            ),
                          ),
                        );
                  }
                  ;
                },
                child: BlocListener<SmallcaseLoginCubit, SmallcaseLoginState>(
                  listener: (context, smallcaseState) {
                    if (smallcaseState is SmallcaseLoginSuccess) {
                      context.read<BuySellTransactionCubit>().fetchBuySell(
                            BuySellTransactionParams(
                              smallcaseAuthToken: widget.authToken,
                              email:
                                  context.read<AuthCubit>().state.user!.emailId,
                              orderConfig: OrderConfig(
                                securities: [
                                  Security(
                                    ticker: widget.symbol ?? '',
                                    type: widget.isBuying ? 'BUY' : 'SELL',
                                    quantity: int.parse(_textController.text),
                                  ),
                                ],
                                type: "SECURITIES",
                              ),
                            ),
                          );
                    }
                  },
                  child: BlocConsumer<BuySellTransactionCubit,
                      BuySellTransactionState>(
                    listener: (context, state) {
                      if (state is BuySellTransactionSuccess) {
                        _triggerSDK(
                          state.buySellTransactionModel.transactionId,
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is BuySellTransactionLoading
                          ? Assets.animations.loading.lottie()
                          : const Text('Continue');
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _triggerSDK(String transactionId) async {
    await ScgatewayFlutterPlugin.setConfigEnvironment(
      GatewayEnvironment.PRODUCTION,
      'bullsurge',
      false,
      [
        context.read<AuthCubit>().state.user!.equityBroker ?? '',
      ],
      isAmoenabled: true,
    );

    await ScgatewayFlutterPlugin.initGateway(
      widget.authToken,
    );

    final result = await ScgatewayFlutterPlugin.triggerGatewayTransaction(
      transactionId,
    );

    Map<String, dynamic> jsonData = jsonDecode(result!);
    if (jsonData.containsKey('errorMessage') &&
        jsonData['errorMessage'] != null) {
      String errorMessage = jsonData['errorMessage'];
      if (!mounted) return;
      Utils.showWarningAlert(context, errorMessage);
      Navigator.pop(context);
    } else {
      Map<String, dynamic> firstBatch =
          (jsonData['data']['batches'] as List)[0];

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ETFOrderPlacedScreen(
            name: widget.name,
            quantity: firstBatch['orders'][0]['quantity'],
            time: DateTime.now(),
            amount: widget.amount,
            totalAmount: widget.amount * int.parse(_textController.text),
            isBuying: widget.isBuying,
            isNSE: true,
            status: firstBatch['orders'][0]['status'],
          ),
        ),
      );
    }
  }
}
