import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../common/decimal_input_formatter.dart';
import '../../../data/models/digital_gold/checkout_rates_model.dart';
import '../../../data/models/digital_gold/create_order_response_model.dart';
import '../../../data/models/digital_gold/gold_user.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/digital_gold/checkout_rates_cubit/get_checkout_rates_cubit.dart';
import '../../cubits/digital_gold/create_order_cubit/create_order_cubit.dart';
import '../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../cubits/digital_gold/sell_gold_silver_cubit/sell_gold_silver_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/error_info_widget.dart';

class DigitalGoldPurchaseScreen extends StatefulWidget {
  const DigitalGoldPurchaseScreen({
    super.key,
    required this.metalType,
    required this.isBuying,
  });
  final MetalType metalType;
  final bool isBuying;

  @override
  State<DigitalGoldPurchaseScreen> createState() =>
      _DigitalGoldPurchaseScreenState();
}

class _DigitalGoldPurchaseScreenState extends State<DigitalGoldPurchaseScreen> {
  Timer? _timer;
  // 5 mins
  int _seconds = 300;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _gmsController = TextEditingController();

  CreateOrderParams? createOrderParams;

  @override
  Widget build(BuildContext context) {
    final GoldUser? goldUser = context.watch<GoldUserCubit>().state.goldUser;

    return BlocListener<SellGoldSilverCubit, SellGoldSilverState>(
      listener: (context, state) {
        if (state is SellGoldSilverLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.animations.bankLoading.lottie(),
                      const Gap(10),
                      const Text(
                        'Processing your order. Please wait.',
                        textAlign: TextAlign.center,
                      ),
                      const Gap(10),
                      Text(
                        'Please do not close the app.',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is SellGoldSilverSuccess) {
          if (createOrderParams != null) {
            context.read<GoldUserCubit>().loadGoldUser();
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              Routes.digitalGoldTransactionStatus,
              arguments: DigitalGoldTransactionStatusArgs(
                isSuccess: true,
                transactionType: DGTransactionType.sell,
                orderDetails: createOrderParams!,
              ),
            );
          } else {
            Utils.showErrorAlert(context, 'Something went wrong');
          }
        }

        if (state is SellGoldSilverError) {
          Navigator.of(context).pop();
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(
                errorType: state.appErrorType, msg: state.errorMessage),
          );
        }
      },
      child: BlocConsumer<GetCheckoutRatesCubit, GetCheckoutRatesState>(
        listener: (context, state) {
          if (state is GetCheckoutRatesLoaded) {
            if (state.goldSilverUnitType == GoldSilverUnitType.gram) {
              if (_gmsController.text.isNotEmpty) {
                setState(
                  () => _amountController.text =
                      state.checkoutRates.totalAmount.toStringAsFixed(2),
                );
              }
            } else {
              if (_amountController.text.isNotEmpty) {
                setState(
                  () => _gmsController.text =
                      state.checkoutRates.metalWeight.toStringAsFixed(5),
                );
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.isBuying ? 'Buy' : 'Sell'}'
                  ' ${widget.metalType == MetalType.gold ? 'Gold' : 'Silver'}'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Gap(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _gmsController,
                                      inputFormatters: [
                                        DecimalTextInputFormatter(
                                            decimalRange: 5),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          _timerStarter();
                                          widget.isBuying
                                              ? context
                                                  .read<GetCheckoutRatesCubit>()
                                                  .getBuyCheckoutRate(
                                                    metalType: widget.metalType,
                                                    amountOrWeight:
                                                        double.parse(value),
                                                    unitType:
                                                        GoldSilverUnitType.gram,
                                                  )
                                              : context
                                                  .read<GetCheckoutRatesCubit>()
                                                  .getSellCheckoutRates(
                                                    metalType: widget.metalType,
                                                    amountOrWeight:
                                                        double.parse(value),
                                                    unitType:
                                                        GoldSilverUnitType.gram,
                                                  );
                                        } else {
                                          context
                                              .read<GetCheckoutRatesCubit>()
                                              .resetState();
                                          _amountController.text = '';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon:
                                            widget.metalType == MetalType.silver
                                                ? Assets.pngs.silverBrick
                                                    .image(scale: 1.8)
                                                : Assets.pngs.goldBrick
                                                    .image(scale: 1.8),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[50]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[50]!),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.error[50]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[400]!),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      validator: (value) => value!.isNotEmpty
                                          ? null
                                          : 'Please enter a weight',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Assets.svgs.swap.svg(),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _amountController,
                                      inputFormatters: [
                                        DecimalTextInputFormatter(
                                          decimalRange: 2,
                                        ),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          _timerStarter();
                                          widget.isBuying
                                              ? context
                                                  .read<GetCheckoutRatesCubit>()
                                                  .getBuyCheckoutRate(
                                                    metalType: widget.metalType,
                                                    amountOrWeight:
                                                        double.parse(value),
                                                    unitType: GoldSilverUnitType
                                                        .rupee,
                                                  )
                                              : context
                                                  .read<GetCheckoutRatesCubit>()
                                                  .getSellCheckoutRates(
                                                    metalType: widget.metalType,
                                                    amountOrWeight:
                                                        double.parse(value),
                                                    unitType: GoldSilverUnitType
                                                        .rupee,
                                                  );
                                        } else {
                                          context
                                              .read<GetCheckoutRatesCubit>()
                                              .resetState();
                                          _gmsController.text = '';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Assets.pngs.greenCash
                                            .image(scale: 1.8),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[50]!),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[50]!),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.error[50]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: AppColors.primary[400]!),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      validator: (value) => value!.isNotEmpty
                                          ? null
                                          : 'Please enter a price',
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${widget.metalType == MetalType.gold ? 'Gold' : 'Silver'} in grams',
                                      style: baseTextStyle12500.copyWith(
                                          color: AppColors.neutral[300]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      'INR',
                                      style: baseTextStyle12500.copyWith(
                                          color: AppColors.neutral[300]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _DefaultGramValue(
                                    onTap: () {
                                      double currentVal;

                                      if (_gmsController.text.isNotEmpty) {
                                        currentVal =
                                            double.parse(_gmsController.text) +
                                                0.1;
                                      } else {
                                        currentVal = 0.1;
                                      }

                                      _gmsController.text =
                                          currentVal.toStringAsFixed(5);

                                      _timerStarter();
                                      widget.isBuying
                                          ? context
                                              .read<GetCheckoutRatesCubit>()
                                              .getBuyCheckoutRate(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              )
                                          : context
                                              .read<GetCheckoutRatesCubit>()
                                              .getSellCheckoutRates(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              );
                                    },
                                    val: 0.1,
                                  ),
                                  _DefaultGramValue(
                                    onTap: () {
                                      double currentVal;

                                      if (_gmsController.text.isNotEmpty) {
                                        currentVal =
                                            double.parse(_gmsController.text) +
                                                2.0;
                                      } else {
                                        currentVal = 2.0;
                                      }

                                      _gmsController.text =
                                          currentVal.toStringAsFixed(5);

                                      _timerStarter();
                                      widget.isBuying
                                          ? context
                                              .read<GetCheckoutRatesCubit>()
                                              .getBuyCheckoutRate(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              )
                                          : context
                                              .read<GetCheckoutRatesCubit>()
                                              .getSellCheckoutRates(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              );
                                    },
                                    val: 2.0,
                                  ),
                                  _DefaultGramValue(
                                    onTap: () {
                                      double currentVal;

                                      if (_gmsController.text.isNotEmpty) {
                                        currentVal =
                                            double.parse(_gmsController.text) +
                                                10.0;
                                      } else {
                                        currentVal = 10.0;
                                      }

                                      _gmsController.text =
                                          currentVal.toStringAsFixed(5);

                                      _timerStarter();
                                      widget.isBuying
                                          ? context
                                              .read<GetCheckoutRatesCubit>()
                                              .getBuyCheckoutRate(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              )
                                          : context
                                              .read<GetCheckoutRatesCubit>()
                                              .getSellCheckoutRates(
                                                metalType: widget.metalType,
                                                amountOrWeight: double.parse(
                                                  _gmsController.text,
                                                ),
                                                unitType:
                                                    GoldSilverUnitType.gram,
                                              );
                                    },
                                    val: 10.0,
                                  ),
                                ],
                              ),
                              const Gap(20.0),
                              if (state is GetCheckOutRatesLoadError)
                                Column(
                                  children: [
                                    ErrorInfoWidget(
                                      otpErrorMsg: Utils.getErrorMessage(
                                          msg: state.errorMessage,
                                          errorType: state.appErrorType),
                                    ),
                                    const Gap(30.0),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (state is GetCheckoutRatesLoading)
                        const Center(child: CustomLoader()),
                    ],
                  ),
                ),
                if (state is GetCheckoutRatesLoaded)
                  Column(
                    children: [
                      Text(
                          '₹${_metalPricePlusTaxText(state.checkoutRates)?.toStringAsFixed(2)}'
                          '${widget.isBuying ? ' + 3% GST' : ''}',
                          style: baseTextStyle14500.copyWith(
                            color: AppColors.neutral[500],
                          )),
                      const Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            color: AppColors.yellowPrimary,
                          ),
                          const Gap(6),
                          Text(
                            'This price will be valid for ',
                            style: baseTextStyle12400.copyWith(
                                color: AppColors.neutral[200]),
                          ),
                          Text(
                            Utils.durationString(_seconds),
                            style: baseTextStyle12500.copyWith(
                                color: AppColors.error[500]),
                          ),
                        ],
                      ),
                      const Gap(12),
                    ],
                  ),
                BlocConsumer<CreateOrderCubit, CreateOrderState>(
                  listener: (context, subState) {
                    if (subState is CreateOrderLoadError) {
                      Navigator.of(context).pop();
                      Utils.showErrorAlert(
                        context,
                        Utils.getErrorMessage(
                            errorType: subState.errorType,
                            msg: subState.errorMessage),
                      );
                    }
                    if (subState is CreateOrderLoaded) {
                      if (widget.isBuying) {
                        _buy(subState.createOrderResponseModel);
                      } else {
                        _sell(subState.createOrderResponseModel);
                      }
                    }
                  },
                  builder: (context, subState) => ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_timer != null && _timer!.isActive) {
                          if (goldUser != null) {
                            if (!widget.isBuying) {
                              if (widget.metalType == MetalType.gold) {
                                if (goldUser.goldBalance >=
                                    double.parse(_gmsController.text)) {
                                  _initiatePayment(state.checkoutRatesModel);
                                } else {
                                  Utils.showErrorAlert(context,
                                      'Not enough gold balance to sell.');
                                }
                              } else {
                                if (goldUser.silverBalance >=
                                    double.parse(_gmsController.text)) {
                                  _initiatePayment(state.checkoutRatesModel);
                                } else {
                                  Utils.showErrorAlert(context,
                                      'Not enough silver balance to sell.');
                                }
                              }
                            } else {
                              _initiatePayment(state.checkoutRatesModel);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'Please complete your KYC to do transactions');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Transaction timed out');
                        }
                      }
                    },
                    child: (state is CreateOrderLoading)
                        ? Assets.animations.loading.lottie()
                        : Text(
                            'Proceed to ${widget.isBuying ? 'pay' : 'sell'}'),
                  ),
                ),
                const Gap(30),
              ],
            ),
          );
        },
      ),
    );
  }

  void _initiatePayment(CheckoutRatesModel? checkoutRatesModel) {
    if (checkoutRatesModel != null) {
      createOrderParams = CreateOrderParams(
        metalType: checkoutRatesModel.metalType,
        amount: checkoutRatesModel.totalAmount,
        blockId: checkoutRatesModel.goldSilverRate.blockId,
        metalWeight: checkoutRatesModel.metalWeight,
        lockPrice: checkoutRatesModel.lockPrice,
        transactionType: checkoutRatesModel.transactionType,
      );
      context.read<CreateOrderCubit>().createOrder(checkoutRatesModel);
    } else {
      Utils.showErrorAlert(context, 'Something went wrong');
    }
  }

  void _buy(CreateOrderResponseModel createOrderResponseModel) =>
      Navigator.pushReplacementNamed(
        context,
        Routes.digitalGoldPayment,
        arguments: DigitalGoldPaymentArgs(
          createOrderParams: createOrderParams!,
          createOrderResponseModel: createOrderResponseModel,
          timeOut: Duration(seconds: _seconds),
        ),
      );

  void _sell(CreateOrderResponseModel order) => context
      .read<SellGoldSilverCubit>()
      .sellGoldSilver(orderId: order.orderId);

  void _timerStarter() {
    if (_timer != null) {
      _timer!.cancel();
      _seconds = 300;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_seconds > 0) {
            setState(() => _seconds -= 1);
          } else {
            timer.cancel();
          }
        },
      );
    } else {
      _seconds = 300;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_seconds > 0) {
            setState(() => _seconds -= 1);
          } else {
            timer.cancel();
          }
        },
      );
    }
  }

  double? _metalPricePlusTaxText(CheckoutRatesModel checkoutRates) {
    try {
      return (widget.metalType == MetalType.gold
              ? widget.isBuying
                  ? checkoutRates.goldSilverRate.goldBuyRate
                  : checkoutRates.goldSilverRate.goldSellRate
              : widget.isBuying
                  ? checkoutRates.goldSilverRate.silverBuyRate
                  : checkoutRates.goldSilverRate.silverSellRate) *
          double.parse(_gmsController.text);
    } catch (e) {
      return 0.0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _amountController.dispose();
    _gmsController.dispose();
    super.dispose();
  }
}

class _DefaultGramValue extends StatelessWidget {
  const _DefaultGramValue({
    required this.onTap,
    required this.val,
  });
  final Function() onTap;
  final double val;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: AppColors.primaryColor),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '+$val gms',
          style: baseTextStyle12400.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
