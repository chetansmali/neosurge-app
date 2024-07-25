import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../data/models/user/user.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mpin/forgot_mpin/forgot_mpin_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../loading_screen.dart';

class ForgotMPinOtpScreen extends StatefulWidget {
  const ForgotMPinOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotMPinOtpScreen> createState() => _ForgotMPinOtpScreenState();
}

class _ForgotMPinOtpScreenState extends State<ForgotMPinOtpScreen> {
  late final TextEditingController _pinController;

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

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthCubit>().state.user!;
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot MPIN')),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter OTP to reset Neosurge PIN',
                      style: baseTextStyle18500.copyWith(color: Colors.black),
                    ),
                    const Gap(4.0),
                    Text(
                      'An OTP has been sent to your registered phone number '
                      '+91 ${user.mobileNumber!.replaceRange(0, 7, '*' * 7)} ',
                      style: baseTextStyle12400.copyWith(
                          color: AppColors.neutral[300]),
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.center,
                      child: BlocConsumer<ForgotMPinCubit, ForgotMPinState>(
                        listener: (context, state) {
                          if (state is ForgotMPinSuccess && state.isVerify) {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.forgotMPinSetMPin);
                          }
                        },
                        builder: (context, state) {
                          return Pinput(
                            length: 4,
                            controller: _pinController,
                            autofocus: true,
                            forceErrorState:
                                state is ForgotMPinFailure && state.isVerify,
                            onChanged: (String? value) {
                              if (state is ForgotMPinFailure &&
                                  state.isVerify) {
                                context.read<ForgotMPinCubit>().reset();
                              }
                            },
                            errorText: state is ForgotMPinFailure
                                ? Utils.getErrorMessage(
                                    errorType: state.appErrorType,
                                    msg: state.errorMessage)
                                : null,
                            errorBuilder: (context, error) {
                              if (state is! ForgotMPinFailure) {
                                return const SizedBox.shrink();
                              }
                              var errorState = state;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Utils.getErrorMessage(
                                    errorType: errorState.appErrorType,
                                    msg: errorState.errorMessage,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.errorRed,
                                  ),
                                ),
                              );
                            },
                            defaultPinTheme: CustomStyles.defaultPinTheme,
                            errorPinTheme: CustomStyles.errorPinTheme,
                            focusedPinTheme: CustomStyles.focusedPinTheme,
                            followingPinTheme: CustomStyles.followingPinTheme,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            showCursor: true,
                            cursor: cursor,
                          );
                        },
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(24.0),
          child: ElevatedButton(
              onPressed: () {
                context
                    .read<ForgotMPinCubit>()
                    .verifyOtp(otp: _pinController.text);
              },
              child: const Text('Confirm')),
        ),
      ),
    );
  }
}
