import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import '../../../domain/entities/enums.dart';
import 'sip/no_mandate_dialog.dart';
import 'package:pinput/pinput.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../data/models/assisted_service/suggested_fund.dart';
import '../../../data/models/mutual_funds/fund.dart';
import '../../../data/models/mutual_funds/fund_detail.dart';
import '../../../data/models/transaction_data.dart';
import '../../../di/get_it.dart';
import '../../../domain/entities/params/mutual_funds/create_sip_order_params.dart';
import '../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mutual_funds/create_consent/create_consent_cubit.dart';
import '../../cubits/mutual_funds/lumpsum_purchase/create_lumpsum_purchase_cubit.dart';
import '../../cubits/mutual_funds/sip_order/sip_order_cubit.dart';
import '../../cubits/mutual_funds/verify_consent/verify_consent_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/resend_consentotp_button.dart';
import '../loading_screen.dart';

class ConsentOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final int consentId;
  final bool isSip;
  final bool isAssistedService;
  final Fund? fund;
  final List<SuggestedFund>? suggestedFunds;
  final FundDetail? fundDetail;
  final String? amountcontrollertext;
  final MFTransactionTypes? transactionType;
  final double? fundAmount;
  final int? numberOfInstallments;
  final String? startDate;

  const ConsentOtpScreen({
    Key? key,
    required this.mobileNumber,
    required this.consentId,
    required this.isSip,
    this.isAssistedService = false,
    this.fund,
    this.suggestedFunds,
    this.fundDetail,
    this.fundAmount,
    this.transactionType,
    this.amountcontrollertext,
    this.numberOfInstallments,
    this.startDate,
  }) : super(key: key);

  @override
  State<ConsentOtpScreen> createState() => _ConsentOtpScreenState();
}

class _ConsentOtpScreenState extends State<ConsentOtpScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String mobilelastdigits;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    mobilelastdigits =
        widget.mobileNumber.substring(widget.mobileNumber.length - 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0, vertical: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.network(
                        'https://assets6.lottiefiles.com/packages/lf20_knnylvpa.json',
                        height: 170,
                        width: 170,
                        repeat: false,
                        frameRate: FrameRate.max,
                      ),
                      const Gap(30),
                      Text(
                        'Enter Mobile OTP',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(20),
                      Text(
                        'We have sent an OTP to your mobile number ending with xxxxxx$mobilelastdigits. Please enter the OTP to continue.',
                        textAlign: TextAlign.center,
                      ),
                      const Gap(20),
                      Theme(
                        data: ThemeData(
                          textTheme: Theme.of(context).textTheme,
                        ),
                        child: MultiBlocListener(
                          listeners: [
                            BlocListener<InvestSuggestedFundsCubit,
                                InvestSuggestedFundsState>(
                              listener: (context, state) {
                                if (state is InvestSuggestedFundsLoaded) {
                                  Navigator.pushNamed(
                                      context, Routes.assistedOrderSummary,
                                      arguments:
                                          AssistedServiceOrderSummaryArgs(
                                              fundsResponse: state.result,
                                              amount: widget.fundAmount!));
                                }
                                if (state is InvestSuggestedFundsError) {
                                  Utils.showErrorAlert(
                                    context,
                                    Utils.getErrorMessage(
                                        errorType: state.appErrorType,
                                        msg: state.error),
                                  );
                                }
                              },
                            ),
                            BlocListener<CreateLumpsumPurchaseCubit,
                                CreateLumpsumPurchaseState>(
                              listener: (_, state) {
                                if (state is CreateLumpsumPurchaseSuccess) {
                                  //context.read<CreateLumpsumPurchaseCubit>().proceedtoOrderSummary(state.lumpsumPurchase);
                                  Navigator.of(context).pop(true);

                                  transactionData.clearData();
                                  transactionData.fund = widget.fund;
                                  transactionData.amount =
                                      widget.amountcontrollertext;
                                  transactionData.transactionType =
                                      widget.transactionType;

                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.lumpsumOrderSummaryScreen,
                                    arguments: LumpsumOrderSummaryArgs(
                                      fundDetail: widget.fundDetail!,
                                      lumpsumPurchase: state.lumpsumPurchase,
                                    ),
                                  );
                                }
                                if (state is CreateLumpsumPurchaseFailure) {
                                  Utils.showErrorAlert(
                                    context,
                                    Utils.getErrorMessage(
                                      errorType: state.errorType,
                                      msg: state.errorMessage,
                                    ),
                                  );
                                }
                              },
                            ),
                            BlocListener<SipOrderCubit, SipOrderState>(
                              listener: (_, state) {
                                if (state is SipNoMandateError) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => BlocProvider.value(
                                      value:
                                          context.read<GetPrimaryBankCubit>(),
                                      child: const Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: NoMandateDialog()),
                                    ),
                                  );
                                }

                                if (state is SipOrderLoadError) {
                                  Utils.showErrorAlert(
                                    context,
                                    Utils.getErrorMessage(
                                        errorType: state.errorType,
                                        msg: state.error),
                                  );
                                }
                                if (state is SipOrderLoaded) {
                                  transactionData.clearData();
                                  transactionData.fund = widget.fund;
                                  transactionData.amount =
                                      widget.amountcontrollertext;
                                  transactionData.transactionType =
                                      widget.transactionType;

                                  Navigator.pushNamed(
                                      context, Routes.sipOrderSummaryScreen,
                                      arguments: SipOrderSummaryArgs(
                                          sipOrder: state.order));
                                }
                              },
                            ),
                          ],
                          child: BlocConsumer<VerifyConsentCubit,
                              VerifyConsentState>(
                            listener: (_, state) {
                              if (state is VerifyConsentSuccess) {
                                Utils.showSuccessAlert(
                                    context, 'Verification Successful');

                                if (widget.isAssistedService) {
                                  context
                                      .read<InvestSuggestedFundsCubit>()
                                      .investSuggestedFunds(
                                        funds: widget.suggestedFunds!,
                                        userId: context
                                            .read<AuthCubit>()
                                            .state
                                            .user!
                                            .id,
                                        consentId: widget.consentId,
                                      );
                                  return;
                                }
                                if (widget.isSip) {
                                  context
                                      .read<SipOrderCubit>()
                                      .createSipOrder(CreateSipOrderParams(
                                        userId: context
                                            .read<AuthCubit>()
                                            .state
                                            .user!
                                            .id,
                                        fundPlanId:
                                            widget.fundDetail!.schemeCode,
                                        fundAmount: widget.fundAmount!,
                                        numberOfInstallments:
                                            widget.numberOfInstallments!,
                                        startDate: widget.startDate!,
                                        isin: widget.fundDetail!.isin,
                                        nav: widget.fundDetail!.nav,
                                        amcId: widget.fundDetail!.amcCode,
                                        planName:
                                            widget.fundDetail!.schemeNameUnique,
                                        mfSipConsentId: widget.consentId,
                                      ));
                                } else {
                                  final userId =
                                      context.read<AuthCubit>().state.user!.id;
                                  context
                                      .read<CreateLumpsumPurchaseCubit>()
                                      .createLumpsumPurchase(
                                        userId: userId.toString(),
                                        fundPlanId: widget.fund!.schemeCode,
                                        fundAmount: widget.fundAmount!,
                                        isin: widget.fund!.isin,
                                        nav: widget.fundDetail!.nav,
                                        amcId: widget.fund!.amcCode,
                                        planName: widget.fund!.schemeNameUnique,
                                        mfLumpsumConsentId: widget.consentId,
                                      );
                                }
                              }
                              if (state is VerifyConsentFailed) {
                                Utils.showErrorAlert(
                                  context,
                                  state.message,
                                );
                              }
                            },
                            builder: (_, state) {
                              return Pinput(
                                length: 4,
                                controller: _controller,
                                focusNode: _focusNode,
                                androidSmsAutofillMethod:
                                    AndroidSmsAutofillMethod.smsUserConsentApi,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter OTP';
                                  }
                                  if (value.length != 4) {
                                    return 'Please enter 4 digit OTP';
                                  }
                                  return null;
                                },
                                defaultPinTheme: CustomStyles.defaultPinTheme,
                                errorPinTheme:
                                    CustomStyles.defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: AppColors.errorRed,
                                    ),
                                  ),
                                ),
                                separator: const SizedBox(width: 16),
                                focusedPinTheme:
                                    CustomStyles.defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.1999999865889549),
                                        offset: Offset(0, 3),
                                        blurRadius: 16,
                                      )
                                    ],
                                  ),
                                ),
                                showCursor: true,
                                cursor: CustomStyles.pinPutCursor,
                              );
                            },
                          ),
                        ),
                      ),
                      const Gap(20),
                      BlocProvider(
                        create: (context) => getIt<CreateConsentCubit>(),
                        child: ResendConcentOtpButton(
                          isSip: widget.isSip,
                        ),
                      ),
                      const Spacer(),
                      const Gap(40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.isSip) {
                              context
                                  .read<VerifyConsentCubit>()
                                  .verifySipConsent(
                                    consentId: widget.consentId,
                                    otp: _controller.text,
                                  );
                            } else {
                              context
                                  .read<VerifyConsentCubit>()
                                  .verifyLumpsumConsent(
                                    consentId: widget.consentId,
                                    otp: _controller.text,
                                  );
                            }
                          }
                        },
                        child: const Text('Continue'),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
