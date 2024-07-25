import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/authentication/resend_otp_cubit/resend_otp_cubit.dart';
import '../../../cubits/authentication/verify_mobile_otp/verify_mobile_otp_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';
import '../widgets/resend_otp_button.dart';

class VerifyMobileScreen extends StatefulWidget {
  final String mobileNumber;

  const VerifyMobileScreen({
    Key? key,
    required this.mobileNumber,
    required this.onSuccess,
  }) : super(key: key);

  final VoidCallback onSuccess;

  @override
  State<VerifyMobileScreen> createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.only(bottom: 20.0),
          child: BlocConsumer<VerifyMobileOtpCubit, VerifyMobileOtpState>(
            listener: (context, state) {
              if (state is VerifyMobileOtpSuccess) {
                final currentState =
                    context.read<AuthCubit>().state as Authenticated;
                context.read<AuthCubit>().updateUser(currentState.user!
                    .copyWith(
                        isMobileNumberVerified: true,
                        mobileNumber: widget.mobileNumber));
                widget.onSuccess.call();
              }
              if (state is VerifyMobileOtpFailure) {
                setState(() {
                  _otpErrorMsg = state.errorMessage;
                  _hasForcedError = true;
                });
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state is VerifyMobileOtpLoading) {
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    context.read<VerifyMobileOtpCubit>().verifyMobileOtp(
                        mobileNumber: widget.mobileNumber,
                        otp: _controller.text);
                  } else {
                    setState(() {
                      _hasForcedError = true;
                    });
                  }
                },
                child: state is VerifyMobileOtpLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              );
            },
          ),
        ),
        body: CustomScrollView(
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
                      'sent to +91 ${widget.mobileNumber}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.mainBlack,
                      ),
                    ),
                    const Gap(20),
                    Pinput(
                      obscureText: true,
                      length: 4,
                      controller: _controller,
                      focusNode: _focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      validator: (value) {
                        String? error;
                        if (value!.isEmpty) {
                          error = 'Please enter OTP';
                        }
                        if (value.length != 4) {
                          error = 'Please enter 4 digit OTP';
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
                    const Gap(20),
                    BlocProvider(
                      create: (context) => getIt<ResendOtpCubit>(),
                      child: ResendOtpButton(
                        mobileNumber: widget.mobileNumber,
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
