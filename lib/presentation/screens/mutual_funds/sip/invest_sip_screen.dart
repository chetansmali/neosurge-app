import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/tooltip/tooltip_position_offset.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../common/extensions.dart';
import '../../../../data/models/mutual_funds/fp_fund_details.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/add_to_cart_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../../cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/add_to_cart/add_to_cart_cubit.dart';
import '../../../cubits/mutual_funds/create_consent/create_consent_cubit.dart';
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
import '../widgets/date_picker.dart';
import '../widgets/invest_amount_widget.dart';

class InvestSIPScreen extends HookWidget {
  final Fund fund;
  final FundDetail fundDetail;
  final FpFundDetails fpFundDetails;

  const InvestSIPScreen(
      {Key? key,
      required this.fund,
      required this.fundDetail,
      required this.fpFundDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final sipDateController = useTextEditingController(
        text:
            '${Utils.suffixText(fpFundDetails.validSipDates!.first)} of every month');
    final amountController = useTextEditingController();
    final installment = useState<int>(fpFundDetails.minSipInstallments!);
    final isUntilCancelled = useState<bool>(true);
    final double minSipAmount =
        fpFundDetails.minSipAmount! < 1000 ? 1000 : fpFundDetails.minSipAmount!;
    final selectedDateObj = useRef<DateTime>(
        Utils.getNextSipDate(fpFundDetails.validSipDates!.first));

    /////

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIP'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
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
                        },
                        builder: (context, state) {
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
                                            purchaseType:
                                                InvestmentType.monthlySip,
                                            schemeCode: fund.schemeCode,
                                            amount: double.parse(
                                              amountController.text
                                                  .replaceAll(',', ''),
                                            ),
                                            sipParams: SipParams(
                                              installments:
                                                  isUntilCancelled.value
                                                      ? 360
                                                      : installment.value,
                                              invDate:
                                                  selectedDateObj.value.day,
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
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
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
                                          getIt<SipOrderCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<CreateLumpsumPurchaseCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          getIt<GetPrimaryBankCubit>(),
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
                                    isSip: true,
                                    fund: fund,
                                    fundDetail: fundDetail,
                                    amountcontrollertext: amountController.text,
                                    transactionType: MFTransactionTypes.sip,
                                    fundAmount: double.parse(amountController
                                        .text
                                        .replaceAll(',', '')),
                                    numberOfInstallments: isUntilCancelled.value
                                        ? 360
                                        : installment.value,
                                    startDate: DateFormat('yyyy-MM-dd')
                                        .format(selectedDateObj.value),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is CreateConsentFailed) {
                            Utils.showErrorAlert(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
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
                                      .createSipConsent();
                                } else {
                                  Utils.showErrorAlert(
                                    context,
                                    'Mobile number not found!',
                                  );
                                }
                              }
                            },
                            child: state is CreateConsentLoading
                                ? Assets.animations.loading.lottie()
                                : const Text('Invest Now'),
                          );
                        },
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.center,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              double amount =
                                  double.parse(value.replaceAll(',', ''));
                              if (amount < minSipAmount) {
                                return 'Minimum amount is ${minSipAmount.toCurrency()}';
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
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              filled: false,
                              prefixStyle: GoogleFonts.hind(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixText: '\u20B9',
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Gap(40),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        InvestAmountWidget(
                            amount: minSipAmount,
                            amountController: amountController),
                        InvestAmountWidget(
                          amount: minSipAmount * 2,
                          amountController: amountController,
                        ),
                        InvestAmountWidget(
                          amount: minSipAmount * 3,
                          amountController: amountController,
                        ),
                      ],
                    ),
                    const Gap(24),
                    TextFormField(
                      readOnly: true,
                      controller: sipDateController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary[50]!,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary[50]!,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary[50]!,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primary[50]!,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.error[500]!,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.error[500]!,
                          ),
                        ),
                        filled: true,
                        suffixIcon: SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(
                            child: Assets.svgs.calendarMinimalistic.svg(
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        prefixText: 'SIP Date',
                        prefixStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.neutral[300],
                        ),
                      ),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral[300]!,
                      ),
                      onTap: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (_) => DatePicker(
                          validDates: fpFundDetails.validSipDates!,
                          title: 'Sip Installment Date',
                          transactionType: MFTransactionTypes.sip,
                          subtitle: 'Next sip installment will be on ',
                          dateController: sipDateController,
                        ),
                      ).then(
                        (value) => value != null
                            ? selectedDateObj.value = value
                            : null,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select sip start date';
                        }
                        return null;
                      },
                    ),
                    const Gap(40),
                    !isUntilCancelled.value
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(20),
                              FlutterSlider(
                                key: const Key('slider'),
                                values: [
                                  installment.value.toDouble(),
                                ],
                                min: fpFundDetails.minSipInstallments!
                                    .toDouble(),
                                max: 360,
                                handlerWidth: 20,
                                handlerHeight: 20,
                                trackBar: CustomStyles.flutterSliderTrackbar,
                                tooltip: FlutterSliderTooltip(
                                  boxStyle: const FlutterSliderTooltipBox(
                                      decoration: null),
                                  custom: (value) => Text(
                                    '${value.toInt()} months',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alwaysShowTooltip: true,
                                  positionOffset:
                                      FlutterSliderTooltipPositionOffset(
                                          top: -10),
                                ),
                                handler: CustomStyles.flutterSliderHandler,
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  installment.value = lowerValue.toInt();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(fpFundDetails.minSipInstallments
                                        .toString()),
                                    const Text('360'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    CheckboxListTile.adaptive(
                      value: isUntilCancelled.value,
                      onChanged: (value) => isUntilCancelled.value = value!,
                      title: const Text(
                        'Maximum Investment Period',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
