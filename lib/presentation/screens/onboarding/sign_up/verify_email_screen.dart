import 'package:amplitude_flutter/amplitude.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../common/custom_styles.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/authentication/resend_otp_cubit/resend_otp_cubit.dart';
import '../../../cubits/authentication/verify_email_otp/verify_email_otp_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';
import '../widgets/resend_otp_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  final VerifyEmailParams verifyEmailParams;
  final VoidCallback onSuccessfulVerification;

  const VerifyEmailScreen({
    Key? key,
    required this.verifyEmailParams,
    required this.onSuccessfulVerification,
  }) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _otpErrorMsg = '';
  bool _isVerifying = false, _hasForcedError = false;

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
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.only(bottom: 20.0),
          child: BlocListener<VerifyEmailOtpCubit, VerifyEmailOtpState>(
            listener: (context, state) async {
              if (state is VerifyEmailOtpLoading) {
                _isVerifying = true;
              }

              if (state is VerifyEmailOtpSuccess) {
                _isVerifying = false;
                // Send the user id to Crashlytics so that it can be used to filter
                // crashes based on the currently logged in user.
                FirebaseCrashlytics.instance.setUserIdentifier(
                  state.user.id.toString(),
                );

                Sentry.configureScope(
                  (p0) => p0.setUser(
                    SentryUser(
                      id: state.user.id.toString(),
                      email: state.user.emailId,
                    ),
                  ),
                );

                if (kReleaseMode) {
                  final Amplitude analytics = Amplitude.getInstance();

                  await analytics.setUserProperties(
                    {
                      'user_id': state.user.id.toString(),
                      'email': state.user.emailId,
                    },
                  );
                }

                await context.read<AuthCubit>().updateUser(
                      state.user.copyWith(
                        emailId: widget.verifyEmailParams.emailId,
                        isEmailIdVerified: true,
                      ),
                    );

                widget.onSuccessfulVerification();
              }

              if (state is VerifyEmailOtpFailure) {
                _isVerifying = false;
                _otpErrorMsg = state.errorMessage;
                _hasForcedError = true;
              }
              setState(() {});
            },
            child: ElevatedButton(
              onPressed: _otpErrorMsg != null
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (_isVerifying) return;

                      if (_formKey.currentState!.validate()) {
                        var fcmToken = '';
                        try {
                          fcmToken =
                              await FirebaseMessaging.instance.getToken() ?? '';
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error getting FCM token: $e');
                          }
                        }
                        // print('FCM Token: $fcmToken');
                        //ignore:use_build_context_synchronously

                        final sessionId = widget.verifyEmailParams
                            .loginWithEmailResponseModel.sessionId!;

                        final createDateTime = widget.verifyEmailParams
                            .loginWithEmailResponseModel.creationTime!;

                        if (context.mounted) {
                          context.read<VerifyEmailOtpCubit>().verifyEmailOtp(
                                emailId: widget.verifyEmailParams.emailId,
                                otp: _controller.text,
                                sessionId: sessionId,
                                creationTime: createDateTime,
                                fcmToken: fcmToken,
                              );
                        }
                      }
                    },
              child: _isVerifying
                  ? Assets.animations.loading.lottie()
                  : const Text('Verify'),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.verifyEmailParams.emailId,
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
                      onChanged: (String value) {
                        _formKey.currentState!.validate();
                        _hasForcedError = false;
                        setState(() {});
                      },
                      errorTextStyle: const TextStyle(
                        fontSize: 0,
                      ),
                      defaultPinTheme: CustomStyles.defaultPinTheme,
                      errorPinTheme: CustomStyles.errorPinTheme,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      forceErrorState: _hasForcedError,
                      showCursor: false,
                      cursor: cursor,
                    ),
                    const Gap(8),
                    BlocProvider(
                      create: (context) => getIt<ResendOtpCubit>(),
                      child: ResendOtpButton(
                        email: widget.verifyEmailParams.emailId,
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
            ],
          ),
        ),
      ),
    );
  }
}
