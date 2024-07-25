import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/params/mutual_funds/edit_cart_params.dart';
import '../../../../gen/assets.gen.dart';

import '../../../../common/utils.dart';
import '../../../cubits/mutual_funds/edit_cart/edit_cart_cubit.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../widgets/invest_amount_widget.dart';

class EditCartLumpsumScreen extends HookWidget {
  final int cartID;
  final double initialAmount;

  const EditCartLumpsumScreen({
    required this.cartID,
    required this.initialAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final amountController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lumpsum'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SafeArea(
          child: BlocConsumer<EditCartCubit, EditCartState>(
            listener: (_, state) {
              if (state is EditCartSuccess) {
                Utils.showSuccessSnackbar(
                    context: context,
                    message: 'Successfully edited the cart item');
                Navigator.pop(context);
                Navigator.pop(context);
              }
              if (state is EditCartFail) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      msg: state.error, errorType: state.errorType),
                );
              }
            },
            builder: (context, state) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                FocusScope.of(context).unfocus();
                await context.read<EditCartCubit>().editCart(
                        params: EditCartParams(
                      cartItemID: cartID,
                      newAmount: double.parse(
                              amountController.text.replaceAll(',', ''))
                          .round(),
                    ));
              },
              child: state is EditCartLoading
                  ? Assets.animations.loading.lottie(
                      width: 30,
                      height: 30,
                    )
                  : const Text('Save Changes'),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                const Text(
                  'Enter Investment Amount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9D9D9D),
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlign: TextAlign.center,
                        validator: (String? value) =>
                            (value == null || value.isEmpty)
                                ? 'Please enter amount'
                                : null,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'en_IN',
                            decimalDigits: 0,
                            symbol: '',
                          ),
                        ],
                        decoration: InputDecoration(
                          filled: false,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          prefixStyle: GoogleFonts.hind(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixText: //rupee
                              '\u20B9',
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InvestAmountWidget(
                        amount: 1000, amountController: amountController),
                    InvestAmountWidget(
                      amount: 25000,
                      amountController: amountController,
                    ),
                    InvestAmountWidget(
                      amount: 50000,
                      amountController: amountController,
                    ),
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
    );
  }
}
