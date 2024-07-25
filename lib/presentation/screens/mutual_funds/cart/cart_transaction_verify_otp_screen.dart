import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/enums.dart';

import '../../../../domain/entities/params/mutual_funds/verify_cart_purchase_otp_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/cart_lumpsum_purchase/cart_lumpsum_purchase_cubit.dart';
import '../../../cubits/mutual_funds/verify_cart_purchase_otp/verify_cart_purchase_otp_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';

class CartTransactionVerifyOtpScreen extends StatefulWidget {
  const CartTransactionVerifyOtpScreen({
    super.key,
    required this.orderRef,
  });

  final String orderRef;

  @override
  State<CartTransactionVerifyOtpScreen> createState() =>
      _CartTransactionVerifyOtpScreenState();
}

class _CartTransactionVerifyOtpScreenState
    extends State<CartTransactionVerifyOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  late final String orderRef;

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

  bool _hasForcedError = false;
  String? _otpErrorMsg;

  Timer? _timer;
  int _counter = 120;

  @override
  void initState() {
    super.initState();
    orderRef = widget.orderRef;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OTP'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                const Gap(20),
              ],
              BlocConsumer<VerifyCartPurchaseOtpCubit,
                  VerifyCartPurchaseOtpState>(
                listener: (context, state) {
                  if (state is VerifyCartPurchaseOtpSuccess) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.paymentWebView,
                      arguments: PaymentWebViewArgs(
                        url: state.verifyCartPurchaseOtpResponse.tokenUrl,
                        transactionType: MFTransactionTypes.cart,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        _hasForcedError = true;
                        setState(() {});
                        return;
                      }

                      context
                          .read<VerifyCartPurchaseOtpCubit>()
                          .verifyCartPurchaseOtp(
                            params: VerifyCartPurchaseOtpParams(
                              cartPurchaseID: widget.orderRef,
                              otp: _otpController.text,
                            ),
                          );
                    },
                    child: state is VerifyCartPurchaseOtpLoading
                        ? Assets.animations.loading.lottie()
                        : const Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                Text(
                  'sent to +91 ${context.read<AuthCubit>().state.user?.mobileNumber ?? ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF151A20),
                  ),
                ),
                const Gap(20),
                Form(
                  key: _formKey,
                  child: Pinput(
                    controller: _otpController,
                    length: 4,
                    obscureText: true,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    forceErrorState: _hasForcedError,
                    showCursor: false,
                    cursor: cursor,
                  ),
                ),
                const Gap(16),
                _counter > 0
                    ? Text(
                        'Resend OTP in ${DateFormat('mm:ss').format(DateTime(1, 1, 1, 0, 0, _counter))}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF151A20),
                        ),
                      )
                    : BlocConsumer<CartLumpsumPurchaseCubit,
                        CartLumpsumPurchaseState>(
                        listener: (context, state) {
                          if (state is CartLumpsumPurchaseSuccess) {
                            setState(() {
                              _counter = 120;
                            });
                            _timer = Timer.periodic(const Duration(seconds: 1),
                                (timer) {
                              if (mounted) {
                                setState(() {
                                  if (_counter > 0) {
                                    _counter--;
                                  } else {
                                    _timer?.cancel();
                                  }
                                });
                              }
                            });
                          }
                        },
                        builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (_counter == 0) {
                                context
                                    .read<CartLumpsumPurchaseCubit>()
                                    .initiateCartLumpsumPurchase();
                              }
                            },
                            child: state is CartLumpsumPurchaseLoading
                                ? const CircularProgressIndicator.adaptive()
                                : const Text(
                                    'Request new OTP',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryViolet,
                                    ),
                                  ),
                          );
                        },
                      ),
              ],
            ),
          ),
          KeyboardDismissButton(
            buildContext: context,
            onDone: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }
}
