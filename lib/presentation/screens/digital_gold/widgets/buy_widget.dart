import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/extensions.dart';
import '../../../../common/utils.dart';
import '../../../../data/models/digital_gold/gold_user.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/digital_gold/checkout_rates_cubit/get_checkout_rates_cubit.dart';
import '../../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';

class BuyWidget extends HookWidget {
  final MetalType metalType;

  const BuyWidget({Key? key, required this.metalType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoldUser? goldUser = context.watch<GoldUserCubit>().state.goldUser;
    final buyAmountController = useTextEditingController();
    final buyGmsController = useTextEditingController();

    return BlocConsumer<GetCheckoutRatesCubit, GetCheckoutRatesState>(
      listener: (context, state) {
        if (state is GetCheckoutRatesLoaded) {
          if (state.goldSilverUnitType == GoldSilverUnitType.gram) {
            if (buyGmsController.text.isNotEmpty) {
              buyAmountController.text =
                  state.checkoutRates.totalAmount.toCurrency(decimalDigits: 2);
            }
          } else {
            if (buyAmountController.text.isNotEmpty) {
              buyGmsController.text =
                  state.checkoutRates.metalWeight.toString();
            }
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    //Grams Text Field
                    SizedBox(
                      width: 140,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: buyGmsController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context
                                .read<GetCheckoutRatesCubit>()
                                .getBuyCheckoutRate(
                                    metalType: metalType,
                                    amountOrWeight: double.parse(value),
                                    unitType: GoldSilverUnitType.gram);
                          } else {
                            buyAmountController.text = '';
                            context.read<GetCheckoutRatesCubit>().resetState();
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Grams', prefixText: 'g. '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Assets.icons.swap.svg(),
                    ),
                    //Amount Text Field
                    SizedBox(
                      width: 140,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: buyAmountController,
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                decimalDigits: 0, locale: 'en_IN', symbol: '')
                          ],
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              context
                                  .read<GetCheckoutRatesCubit>()
                                  .getBuyCheckoutRate(
                                      metalType: metalType,
                                      amountOrWeight: value.removeCommas,
                                      unitType: GoldSilverUnitType.rupee);
                            } else {
                              buyGmsController.text = '';
                              context
                                  .read<GetCheckoutRatesCubit>()
                                  .resetState();
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: 'Amount', prefixText: '₹ ')),
                    ),
                    const Spacer(),
                  ],
                ),
                BlocBuilder<GetCheckoutRatesCubit, GetCheckoutRatesState>(
                  builder: (context, state) {
                    if (state is GetCheckOutRatesLoadError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Utils.getErrorMessage(
                            errorType: state.appErrorType,
                            msg: state.errorMessage,
                          ),
                          style: const TextStyle(
                              color: AppColors.errorRed, fontSize: 10),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const Spacer(),
                BlocBuilder<GetCheckoutRatesCubit, GetCheckoutRatesState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: state is GetCheckoutRatesLoaded
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      if (goldUser != null) {
                                        Navigator.pushNamed(
                                            context, Routes.checkOut,
                                            arguments: state.checkoutRates);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please complete your KYC to do transactions');
                                      }
                                    }
                                  : null,
                              child: const Text('CHECK OUT'),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            if (state is GetCheckoutRatesLoading) ...[
              const Align(
                child: Center(
                  child: CustomLoader(),
                ),
              )
            ]
          ],
        );
      },
    );
  }
}
