import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/params/mutual_funds/add_to_cart_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/mutual_funds/add_to_cart/add_to_cart_cubit.dart';
import '../../../cubits/mutual_funds/create_consent/create_consent_cubit.dart';

import '../../../../common/extensions.dart';
import '../../../../common/utils.dart';
import '../../../../data/models/mutual_funds/fp_fund_details.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/is_scheme_present/is_scheme_present_cubit.dart';
import '../../../cubits/mutual_funds/lumpsum_purchase/create_lumpsum_purchase_cubit.dart';
import '../../../cubits/mutual_funds/sip_order/sip_order_cubit.dart';
import '../../../cubits/mutual_funds/verify_consent/verify_consent_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../consent_otp_screen.dart';
import '../widgets/invest_amount_widget.dart';

class InvestLumpsumScreen extends HookWidget {
  final Fund fund;
  final FundDetail fundDetail;
  final FpFundDetails fpFundDetails;

  const InvestLumpsumScreen({
    Key? key,
    required this.fund,
    required this.fundDetail,
    required this.fpFundDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final inrFormatter = useMemoized(
      () =>
          NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0),
      const [],
    );
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
          child: BlocBuilder<IsSchemePresentCubit, IsSchemePresentState>(
            builder: (context, state) {
              if (state is IsSchemePresentLoading) {
                return const Center(child: CustomLoader());
              }

              if (state is IsSchemePresentSuccess) {
                final bool isPresent = state.isSchemePresent;

                return Row(
                  children: [
                    Expanded(
                      child: BlocConsumer<AddToCartCubit, AddToCartState>(
                          listener: (context, state) {
                        if (state is AddToCartSuccess) {
                          Utils.showSuccessSnackbar(
                            context: context,
                            message: 'Successfully added to cart',
                            action: SnackBarAction(
                              label: 'Go To Cart',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.mutualFundsCart,
                                );
                              },
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.primary[500]!,
                              width: 1,
                            ),
                            foregroundColor: AppColors.primary[500],
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: isPresent
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.mutualFundsCart,
                                  );
                                }
                              : () {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  context.read<AddToCartCubit>().addToCart(
                                        params: AddToCartParams(
                                          purchaseType: InvestmentType.lumpsum,
                                          schemeCode: fund.schemeCode,
                                          amount: double.parse(
                                            amountController.text
                                                .replaceAll(',', ''),
                                          ),
                                        ),
                                      );
                                },
                          child: isPresent
                              ? const Text('Go to Cart')
                              : state is AddToCartLoading
                                  ? const CircularProgressIndicator.adaptive()
                                  : const Text('Add to Cart'),
                        );
                      }),
                    ),
                    const Gap(20),
                    Expanded(
                      child:
                          BlocConsumer<CreateConsentCubit, CreateConsentState>(
                        listener: (_, state) {
                          if (state is CreateConsentSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<CreateLumpsumPurchaseCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<SipOrderCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<VerifyConsentCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<CreateConsentCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<InvestSuggestedFundsCubit>(),
                                    ),
                                  ],
                                  child: ConsentOtpScreen(
                                    mobileNumber:
                                        state.createConsentModel.mobile,
                                    consentId: state.createConsentModel.id,
                                    isSip: false,
                                    fund: fund,
                                    fundDetail: fundDetail,
                                    amountcontrollertext: amountController.text,
                                    transactionType: MFTransactionTypes.lumpsum,
                                    fundAmount: double.parse(
                                      amountController.text.replaceAll(',', ''),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is CreateConsentFailed) {
                            Utils.showErrorAlert(context, state.message);
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
                            String mobilenumber = context
                                    .read<AuthCubit>()
                                    .state
                                    .user!
                                    .mobileNumber ??
                                '';
                            if (mobilenumber.isNotEmpty) {
                              context
                                  .read<CreateConsentCubit>()
                                  .createLumpsumConsent();
                            } else {
                              Utils.showErrorAlert(
                                context,
                                'Mobile number not found!',
                              );
                            }
                          },
                          child: state is CreateConsentLoading
                              ? Assets.animations.loading.lottie(
                                  width: 30,
                                  height: 30,
                                )
                              : const Text('Invest Now'),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is IsSchemePresentFail) {
                return const Center(
                  child: ErrorInfoWidget(
                      otpErrorMsg: 'Something went wrong, please try again'),
                );
              }

              return const SizedBox();
            },
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          double amount = value.removeCommas;
                          if (amount <
                              (fund.folioNumber != null
                                  ? fpFundDetails.minAdditionalInvestment!
                                  : fpFundDetails.minInitialInvestment!)) {
                            return 'Minimum amount is ${inrFormatter.format(fpFundDetails.minInitialInvestment)}';
                          }
                          return null;
                        },
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
                        amount: fund.folioNumber != null
                            ? fpFundDetails.minAdditionalInvestment!
                            : fpFundDetails.minInitialInvestment!,
                        amountController: amountController),
                    InvestAmountWidget(
                      amount: (fund.folioNumber != null
                              ? fpFundDetails.minAdditionalInvestment!
                              : fpFundDetails.minInitialInvestment!) *
                          2,
                      amountController: amountController,
                    ),
                    InvestAmountWidget(
                      amount: (fund.folioNumber != null
                              ? fpFundDetails.minAdditionalInvestment!
                              : fpFundDetails.minInitialInvestment!) *
                          3,
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
