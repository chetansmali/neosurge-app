import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../common/utils.dart';
import '../../../../../domain/entities/params/equity/buy_sell_transaction.dart';
import '../../../../../domain/entities/params/equity/ligin/smallcase_login.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/buy_sell_transaction_cubit.dart';
import '../../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/keyboard_dismiss_btn.dart';
import 'order_summary.dart';

class BuySellBottomSheet extends StatefulWidget {
  final String type;
  final double? price;
  final String? symbol;
  final String authToken;
  final String? name;

  const BuySellBottomSheet({
    super.key,
    required this.type,
    this.price,
    required this.symbol,
    required this.authToken,
    required this.name,
  });

  @override
  State<BuySellBottomSheet> createState() => _BuySellBottomSheetState();
}

class _BuySellBottomSheetState extends State<BuySellBottomSheet> {
  final TextEditingController _textEditingController =
      TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    late String type = widget.type;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              bool isTokenExpired = JwtDecoder.isExpired(widget.authToken);
              log(JwtDecoder.decode(widget.authToken).toString());
              log(isTokenExpired.toString());
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
                        email: context.read<AuthCubit>().state.user!.emailId,
                        smallcaseAuthToken: widget.authToken,
                      ),
                    );
              } else {
                context.read<BuySellTransactionCubit>().fetchBuySell(
                      BuySellTransactionParams(
                        smallcaseAuthToken: widget.authToken,
                        email: context.read<AuthCubit>().state.user!.emailId,
                        orderConfig: OrderConfig(
                          securities: [
                            Security(
                              ticker: widget.symbol ?? '',
                              type: widget.type.toUpperCase(),
                              quantity: int.parse(_textEditingController.text),
                            )
                          ],
                          type: "SECURITIES",
                        ),
                      ),
                    );
              }
            },
            child: BlocListener<SmallcaseLoginCubit, SmallcaseLoginState>(
              listener: (context, smallcaseState) {
                if (smallcaseState is SmallcaseLoginSuccess) {
                  context.read<BuySellTransactionCubit>().fetchBuySell(
                        BuySellTransactionParams(
                          smallcaseAuthToken: widget.authToken,
                          email: context.read<AuthCubit>().state.user!.emailId,
                          orderConfig: OrderConfig(
                            securities: [
                              Security(
                                ticker: widget.symbol ?? '',
                                type: widget.type.toUpperCase(),
                                quantity:
                                    int.parse(_textEditingController.text),
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
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$type order',
                        style: baseTextStyle2.copyWith(
                            color: type == 'Buy'
                                ? AppColors.primaryColor
                                : AppColors.errorRed),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            Assets.icons.crossIcon.image(height: 24, width: 24),
                      ),
                    ],
                  ),
                  const Gap(34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Regular',
                        style: baseTextStyle2.copyWith(
                          color: type == 'Buy'
                              ? AppColors.primaryColor
                              : AppColors.errorRed,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 13.0,
                            right: 13,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'NSE',
                            style: baseTextStyle12700.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: type == 'Buy'
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: type == 'Buy'
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: type == 'Buy'
                                    ? AppColors.primaryColor
                                    : AppColors.errorRed,
                                width: 1,
                              ),
                            ),
                            labelText: 'Quantity',
                            floatingLabelStyle: TextStyle(
                              color: type == 'Buy'
                                  ? AppColors.primaryColor
                                  : AppColors.errorRed,
                              fontSize: 12,
                            ),
                            labelStyle: TextStyle(
                              color: type == 'Buy'
                                  ? AppColors.primaryColor
                                  : AppColors.errorRed,
                              fontSize: 12,
                            ),
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: type == 'Buy'
                                        ? AppColors.primaryColor
                                        : AppColors.errorRed,
                                    width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Market',
                                      style: baseTextStyle.copyWith(
                                        color: type == 'Buy'
                                            ? AppColors.primaryColor
                                            : AppColors.errorRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: -2,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: Text(
                                    'Order Type',
                                    style: baseTextStyle10400.copyWith(
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (type == 'Sell')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Available shares',
                          style: baseTextStyle.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          '--',
                          style: baseTextStyle,
                        )
                      ],
                    ),
                  const Gap(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Approximate amount',
                        style:
                            baseTextStyle.copyWith(color: AppColors.textGrey),
                      ),
                      Text(
                        _textEditingController.text.isNotEmpty
                            ? Utils.compactCurrency(widget.price!.toDouble() *
                                int.parse(_textEditingController.text))
                            : '0.0',
                        style: baseTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            KeyboardDismissButton(
              onDone: () {
                FocusScope.of(context).unfocus();
              },
              buildContext: context,
            ),
          ],
        ),
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
      String status = firstBatch['orders'][0]['status'];
      int quantity = firstBatch['orders'][0]['quantity'];

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(
            type: status,
            qty: quantity,
            name: widget.name ?? '',
            price: widget.price ?? 0,
          ),
        ),
      );
    }
  }
}
