import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/common.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../data/models/transaction_data.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/create_swp_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/fp_fund_details/fp_fund_details_cubit.dart';
import '../../../cubits/mutual_funds/swp/create_swp_order/create_swp_order_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../../../widgets/primary_bank_card.dart';
import '../../../widgets/widgets.dart';

import '../widgets/date_picker.dart';
import '../widgets/invest_amount_widget.dart';

class SwpFundScreen extends StatefulWidget {
  final UserMfScheme scheme;
  final Fund fund;

  const SwpFundScreen({Key? key, required this.scheme, required this.fund})
      : super(key: key);

  @override
  State<SwpFundScreen> createState() => _SwpFundScreenState();
}

class _SwpFundScreenState extends State<SwpFundScreen> {
  bool _hasInstallmentsInputError = false;
  bool _hasAmountInputError = false;
  String _amountInputError = '';
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final installmentController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDateObj = Utils.getNextStpSwpDate(1);
  UserBank? userBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Systematic Withdrawal Plan'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<FpFundDetailsCubit, FpFundDetailsState>(
            builder: (context, state) {
          if (state is! FpFundDetailsLoaded) {
            return const SizedBox.shrink();
          }

          return BlocConsumer<CreateSwpOrderCubit, CreateSwpOrderState>(
            listener: (context, createSwpOrderState) {
              if (createSwpOrderState is CreateSwpOrderSuccess) {
                transactionData.clearData();
                transactionData.fund = widget.fund;
                transactionData.bank = userBank;
                transactionData.amount = amountController.text;
                transactionData.transactionType = MFTransactionTypes.swp;
                Navigator.pushNamed(
                  context,
                  Routes.swpVerifyOtp,
                  arguments: SwpFundArgs(
                    fund: widget.fund,
                    scheme: widget.scheme,
                    swpResponse: createSwpOrderState.swpOrderResponse,
                  ),
                );
              }
              if (createSwpOrderState is CreateSwpOrderFailure) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                    errorType: createSwpOrderState.errorType,
                    msg: createSwpOrderState.error,
                  ),
                );
              }
            },
            builder: (context, createSwpOrderState) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    context.read<CreateSwpOrderCubit>().createSwpOrder(
                          CreateSwpOrderParams(
                            userId: context.read<AuthCubit>().state.user!.id,
                            fundAmount: double.parse(
                              amountController.text.replaceAll(
                                ',',
                                '',
                              ),
                            ),
                            folioNumber: widget.scheme.folioNumber,
                            isin: widget.scheme.isin,
                            fundPlanId: widget.fund.schemeCode,
                            schemeName: widget.scheme.name,
                            imgUrl: widget.fund.imgUrl,
                            minSwpAmount: state.fpFundDetails.minSwpAmount!,
                            maxSwpAmount: state.fpFundDetails.maxSwpAmount!,
                            numberOfInstallments:
                                int.parse(installmentController.text),
                            startDate: selectedDateObj,
                            swpAllowed: state.fpFundDetails.isSwpAllowed!,
                          ),
                        );
                  }
                },
                child: createSwpOrderState is CreateSwpOrderLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Confirm SWP'),
              ),
            ),
          );
        }),
      ),
      body: Stack(
        children: [
          BlocConsumer<FpFundDetailsCubit, FpFundDetailsState>(
            listener: (context, state) {
              if (state is FpFundDetailsLoaded) {
                dateController.text = '${Utils.suffixText(
                  state.fpFundDetails.validSwpDates!.first,
                )} of every month';
                selectedDateObj = Utils.getNextStpSwpDate(
                  state.fpFundDetails.validSwpDates!.first,
                );
              }
            },
            builder: (context, state) {
              if (state is FpFundDetailsLoading) {
                return const Center(
                  child: CustomLoader(),
                );
              }
              if (state is FpFundDetailsError) {
                return Center(
                  child: AppErrorWidget(
                      errorType: state.errorType, error: state.error),
                );
              }
              if (state is FpFundDetailsLoaded) {
                final fpFund = state.fpFundDetails;
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(20),
                          const Text(
                            'Enter Swp Amount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9D9D9D),
                              fontSize: 12,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 240,
                              child: TextFormField(
                                controller: amountController,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                validator: (String? value) {
                                  String? error;

                                  if (value == null || value.isEmpty) {
                                    error = 'Please enter amount';
                                    _hasAmountInputError = true;
                                  } else {
                                    double amount = double.parse(
                                      value
                                          .replaceAll(',', '')
                                          .replaceAll('\u20B9', ''),
                                    );
                                    if (amount <
                                        state.fpFundDetails.minSwpAmount!) {
                                      error =
                                          'Minimum amount is ${state.fpFundDetails.minSwpAmount}';
                                    }
                                  }
                                  setState(() {
                                    _hasAmountInputError = error != null;
                                    _amountInputError = error ?? '';
                                  });

                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 32,
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
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  filled: false,
                                  prefixText: '\u20B9',
                                  prefixStyle: TextStyle(
                                    color: AppColors.mainBlack,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.hind().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_hasAmountInputError) ...[
                            Text(
                              _amountInputError,
                              style: TextStyle(
                                color: AppColors.error[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                          const Gap(12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              InvestAmountWidget(
                                amount: state.fpFundDetails.minSwpAmount!,
                                amountController: amountController,
                              ),
                              InvestAmountWidget(
                                amount: state.fpFundDetails.minSwpAmount! * 2,
                                amountController: amountController,
                              ),
                              InvestAmountWidget(
                                amount: state.fpFundDetails.minSwpAmount! * 3,
                                amountController: amountController,
                              ),
                            ],
                          ),
                          const Gap(24),
                          TextFormField(
                            readOnly: true,
                            controller: dateController,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.neutral[300],
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                                maxHeight: 40,
                                maxWidth: 40,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Assets.svgs.calendarMinimalistic.svg(),
                              ),
                              prefixText: 'SWP Date',
                              prefixStyle: TextStyle(
                                color: AppColors.neutral[300]!,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
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
                                validDates: state.fpFundDetails.validSwpDates!,
                                title: 'Swp Installment Date',
                                transactionType: MFTransactionTypes.swp,
                                subtitle:
                                    'Your first swp installment will be on ',
                                dateController: dateController,
                              ),
                            ).then(
                              (value) => value != null
                                  ? selectedDateObj = value
                                  : null,
                            ),
                          ),
                          const Gap(20),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: installmentController,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter installments',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              suffixIcon: _hasInstallmentsInputError
                                  ? Icon(
                                      Icons.error,
                                      color: AppColors.error[500]!,
                                    )
                                  : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.error[500],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primary[50]!,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.error[500]!,
                                  width: 1,
                                ),
                              ),
                            ),
                            validator: (value) {
                              String? error;

                              if (value == null || value.isEmpty) {
                                error = 'Please enter installments';
                              } else if (int.parse(value) <
                                  fpFund.minSwpInstallments!) {
                                error =
                                    'Minimum installments is ${fpFund.minSwpInstallments}';
                              }

                              setState(() {
                                _hasInstallmentsInputError = error != null;
                              });

                              return error;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          const Gap(20),
                          BlocConsumer<GetPrimaryBankCubit,
                              GetPrimaryBankState>(
                            listener: (context, state) {
                              if (state is GetPrimaryBankLoaded) {
                                setState(() {
                                  userBank = state.bankDetails;
                                });
                              }
                            },
                            builder: (context, state) {
                              if (state is GetPrimaryBankLoaded) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Transfer to',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(16),
                                    PrimaryBankCard(
                                      bank: state.bankDetails,
                                      padding: const EdgeInsets.all(0),
                                      isVerifiedIconVisible: true,
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: AppColors.alert[50]!,
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Text(
                                      'The amount will be credited to your primary bank account',
                                      style: TextStyle(
                                        color: AppColors.alert[500]!,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          KeyboardDismissButton(
            buildContext: context,
            onDone: () {
              FocusManager.instance.primaryFocus?.unfocus();
              formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }
}
