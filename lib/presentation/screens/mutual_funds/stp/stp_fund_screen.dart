import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../../domain/entities/params/mutual_funds/create_stp_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/fp_fund_details/fp_fund_details_cubit.dart';
import '../../../cubits/mutual_funds/stp/create_stp_order/create_stp_order_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../../../widgets/widgets.dart';
import '../widgets/date_picker.dart';
import '../widgets/invest_amount_widget.dart';

class StpFundScreen extends StatefulWidget {
  final UserMfScheme scheme;
  final Fund fund;
  final Fund stpFund;

  const StpFundScreen({
    Key? key,
    required this.scheme,
    required this.fund,
    required this.stpFund,
  }) : super(key: key);

  @override
  State<StpFundScreen> createState() => _StpFundScreenState();
}

class _StpFundScreenState extends State<StpFundScreen> {
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
        title: const Text('Systematic Transfer Plan'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<FpFundDetailsCubit, FpFundDetailsState>(
          builder: (context, state) {
            if (state is! FpFundDetailsLoaded) {
              return const SizedBox.shrink();
            }
            return BlocConsumer<CreateStpOrderCubit, CreateStpOrderState>(
              listener: (context, createStpOrderState) {
                if (createStpOrderState is CreateStpOrderSuccess) {
                  transactionData.clearData();
                  transactionData.fund = widget.fund;
                  transactionData.switchStpFund = widget.stpFund;
                  transactionData.amount = amountController.text;
                  transactionData.transactionType = MFTransactionTypes.stp;
                  Navigator.pushNamed(
                    context,
                    Routes.stpVerifyOtp,
                    arguments: StpFundArgs(
                      fund: widget.fund,
                      scheme: widget.scheme,
                      stpFund: widget.stpFund,
                      stpResponse: createStpOrderState.stpOrderResponse,
                    ),
                  );
                }
                if (createStpOrderState is CreateStpOrderFailure) {
                  Utils.showErrorAlert(
                    context,
                    Utils.getErrorMessage(
                      errorType: createStpOrderState.errorType,
                      msg: createStpOrderState.error,
                    ),
                  );
                }
              },
              builder: (context, createStpOrderState) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.read<CreateStpOrderCubit>().createStpOrder(
                            CreateStpOrderParams(
                              userId: context.read<AuthCubit>().state.user!.id,
                              fundAmount: double.parse(
                                  amountController.text.replaceAll(',', '')),
                              folioNumber: widget.scheme.folioNumber,
                              startDate: selectedDateObj,
                              fpMaxStpInAmount:
                                  state.fpFundDetails.maxStpInAmount!,
                              fpMinStpInAmount:
                                  state.fpFundDetails.minStpInAmount!,
                              numberOfInstallments:
                                  int.parse(installmentController.text),
                              switchInPlan: widget.fund.schemeCode,
                              switchOutPlan: widget.stpFund.schemeCode,
                              fpStpInAllowed:
                                  state.fpFundDetails.isStpInAllowed!,
                              switchInisin: widget.scheme.isin,
                              switchOutisin: widget.stpFund.isin,
                              switchInSchemeName: widget.fund.schemeNameUnique,
                              switchOutSchemeName:
                                  widget.stpFund.schemeNameUnique,
                              switchInImgUrl: widget.fund.imgUrl,
                              switchOutImgUrl: widget.stpFund.imgUrl,
                            ),
                          );
                    }
                  },
                  child: createStpOrderState is CreateStpOrderLoading
                      ? Assets.animations.loading.lottie()
                      : const Text('Confirm STP'),
                ),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<FpFundDetailsCubit, FpFundDetailsState>(
            listener: (context, state) {
              if (state is FpFundDetailsLoaded) {
                dateController.text = '${Utils.suffixText(
                  state.fpFundDetails.validStpDates!.first,
                )} of every month';
                selectedDateObj = Utils.getNextStpSwpDate(
                  state.fpFundDetails.validStpDates!.first,
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Enter Stp Amount',
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
                                        state.fpFundDetails.minStpInAmount!) {
                                      error =
                                          'Minimum amount is ${state.fpFundDetails.minStpInAmount}';
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
                          const Gap(40),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              InvestAmountWidget(
                                  amount: state.fpFundDetails.minStpInAmount!,
                                  amountController: amountController),
                              InvestAmountWidget(
                                amount: state.fpFundDetails.minStpInAmount! * 2,
                                amountController: amountController,
                              ),
                              InvestAmountWidget(
                                amount: state.fpFundDetails.minStpInAmount! * 3,
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
                              prefixText: 'STP Date',
                              prefixStyle: TextStyle(
                                color: AppColors.neutral[300]!,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              filled: true,
                              fillColor: Colors.white,
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
                                validDates: state.fpFundDetails.validStpDates!,
                                title: 'STP Installment Date',
                                transactionType: MFTransactionTypes.stp,
                                subtitle:
                                    'Your first STP installment will be on ',
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
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
                                  fpFund.minStpOutInstallments!) {
                                error =
                                    'Minimum installments is ${fpFund.minStpOutInstallments}';
                              }

                              setState(() {
                                _hasInstallmentsInputError = error != null;
                              });

                              return error;
                            },
                          ),
                          const Gap(20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Transfer to',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: widget.fund.imgUrl,
                                  height: 40,
                                  width: 40,
                                ),
                                const Gap(8),
                                Flexible(
                                  child: Text(
                                    widget.stpFund.schemeName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Change Fund',
                                style: TextStyle(
                                  color: AppColors.primary[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
              // formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }
}
