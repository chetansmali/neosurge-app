import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../cubits/retirement_calculator/generate_retirement_otp_cubit.dart';
import 'retirement_resend_otp_screen.dart';
import 'package:pinput/pinput.dart';
import '../../../../common/custom_styles.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/params/retirement_calculator/submit_retirement_OTP_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/retirement_calculator/submit_retirement_otp_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';

class RetirementOTPScreen extends StatefulWidget {
  final int monthlyIncome;
  final int retirementAge;
  final int existingSavings;
  final String investmentStyle;
  final int monthlyExpense;
  final String postRetirementStyle;
  final String requestId;
  const RetirementOTPScreen(
      {super.key,
      required this.monthlyIncome,
      required this.retirementAge,
      required this.existingSavings,
      required this.investmentStyle,
      required this.monthlyExpense,
      required this.requestId,
      required this.postRetirementStyle});

  @override
  State<RetirementOTPScreen> createState() => _RetirementOTPScreenState();
}

class _RetirementOTPScreenState extends State<RetirementOTPScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _otpErrorMsg = '';
  bool _hasForcedError = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocConsumer<SubmitRetirementOtpCubit,
                SubmitRetirementOtpState>(
              listener: (context, state) {
                if (state is SubmitRetirementOtpSuccess) {
                  if (state.submitRetirementOTPModel.otpVerified == 'true') {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.planYourFutureScreen,
                      arguments: RetirementCorpusArgs(
                        monthlyIncome: widget.monthlyIncome,
                        retirementAge: widget.retirementAge,
                        existingSavings: widget.existingSavings,
                        investmentStyle: widget.investmentStyle,
                        monthlyExpense: widget.monthlyExpense,
                        postRetirementStyle: widget.postRetirementStyle,
                        requestID: widget.requestId,
                      ),
                    );
                  } else {
                    setState(() {
                      _otpErrorMsg = 'Incorrect OTP';
                      _hasForcedError = true;
                    });
                  }
                }

                if (state is SubmitRetirementOtpFailure) {
                  setState(() {
                    _otpErrorMsg = state.errorMessage;
                    _hasForcedError = true;
                  });
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state is SubmitRetirementOtpLoading) {
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      context
                          .read<SubmitRetirementOtpCubit>()
                          .verifyRetirementOtp(SubmitRetirementOTPParams(
                              requestId: widget.requestId,
                              otp: _controller.text));
                    } else {
                      setState(() {
                        _hasForcedError = true;
                      });
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(335, 60)),
                  child: state is SubmitRetirementOtpLoading
                      ? Assets.animations.loading.lottie()
                      : const Text('Verify'),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'sent to +91 ${context.read<AuthCubit>().state.user!.mobileNumber!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.mainBlack,
                      ),
                    ),
                    const Gap(20),
                    Pinput(
                      obscureText: true,
                      length: 6,
                      controller: _controller,
                      focusNode: _focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      validator: (value) {
                        String? error;
                        if (value!.isEmpty) {
                          error = 'Please enter OTP';
                        }
                        if (value.length != 6) {
                          error = 'Please enter 6 digit OTP';
                        }
                        _otpErrorMsg = error;
                        return error;
                      },
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      onChanged: (String value) {
                        _formKey.currentState!.validate();
                        _hasForcedError = false;
                        setState(() {});
                      },
                      defaultPinTheme: CustomStyles.defaultPinTheme.copyWith(
                        width: 60,
                        height: 60,
                      ),
                      errorTextStyle: const TextStyle(
                        fontSize: 0,
                      ),
                      errorText: '',
                      forceErrorState: _hasForcedError,
                      errorPinTheme: CustomStyles.errorPinTheme.copyWith(
                        width: 60,
                        height: 60,
                      ),
                      focusedPinTheme: CustomStyles.focusedPinTheme.copyWith(
                        width: 60,
                        height: 60,
                      ),
                      showCursor: false,
                      cursor: CustomStyles.pinPutCursor,
                    ),
                    const Gap(15),
                    BlocProvider(
                      create: (context) => getIt<GenerateRetirementOtpCubit>(),
                      child: RetirementResendOTPScreen(
                        mobileNumber:
                            context.read<AuthCubit>().state.user!.mobileNumber,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        isTitleVisible: false,
                      ),
                    ),
                    const Spacer(),
                    if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                      ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                      const Gap(20),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
