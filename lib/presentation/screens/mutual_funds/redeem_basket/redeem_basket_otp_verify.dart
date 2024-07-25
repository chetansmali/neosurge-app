import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/params/neobaskets/verify_basket_redeem_consent_param.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/basket_redeem_order_verify/basket_redeem_order_verify_cubit.dart';
import '../../../cubits/neobaskets/basket_order_consent/basket_order_consent_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';

class RedeemBasketOtpScreen extends StatefulWidget {
  const RedeemBasketOtpScreen({
    super.key,
    required this.redeemptionRef,
    required this.consentId,
  });

  final String redeemptionRef;
  final String consentId;

  @override
  State<RedeemBasketOtpScreen> createState() => _RedeemBasketOtpScreenState();
}

class _RedeemBasketOtpScreenState extends State<RedeemBasketOtpScreen> {
  String? _otpErrorMsg;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hasForcedError = false;

  final TextEditingController _otpController = TextEditingController();

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

  String consentId = '';
  late Timer _timer;
  int _counter = 120;

  @override
  void initState() {
    super.initState();

    consentId = widget.consentId;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          _timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _formKey.currentState!.save();
                    context
                        .read<BasketRedeemOrderVerifyCubit>()
                        .verifyRedeemOrder(
                          VerifyBasketRedeemConsentParams(
                            consentId: consentId,
                            otp: _otpController.text,
                            redemptionRef: widget.redeemptionRef,
                          ),
                        );
                  }
                },
                child: BlocConsumer<BasketRedeemOrderVerifyCubit,
                    BasketRedeemOrderVerifyState>(
                  listener: (context, state) {
                    if (state is BasketRedeemOrderVerified) {
                      Navigator.of(context).pushNamed(
                        Routes.redeemBasketStatusScreen,
                      );
                    } else if (state is BasketRedeemOrderVerifyError) {
                      _hasForcedError = true;
                      _otpErrorMsg = state.error;
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    return state is BasketRedeemOrderVerifying
                        ? Assets.animations.loading.lottie()
                        : const Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                  },
                ),
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
                  'sent to +91 ${context.read<AuthCubit>().state.user!.mobileNumber}',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    forceErrorState: _hasForcedError,
                    showCursor: false,
                    cursor: cursor,
                  ),
                ),
                const Gap(16),
                if (_counter > 0) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Resend OTP in ${DateFormat('mm:ss').format(DateTime(0, 0, 0, 0, 0, _counter))}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryViolet,
                      ),
                    ),
                  ),
                ] else ...[
                  BlocConsumer<BasketOrderConsentCubit,
                      BasketOrderConsentState>(
                    listener: (context, state) {
                      if (state is BasketOrderConsentCreated) {
                        consentId = state.consentModel.id.toString();
                        setState(() {
                          _counter = 120;
                        });
                        _timer = Timer.periodic(
                          const Duration(
                            seconds: 1,
                          ),
                          (timer) {
                            if (mounted) {
                              setState(() {
                                if (_counter > 0) {
                                  _counter--;
                                } else {
                                  _timer.cancel();
                                }
                              });
                            }
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          context
                              .read<BasketOrderConsentCubit>()
                              .createBasketOrderConsent();
                        },
                        child: state is BasketOrderConsentCreating
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
                ]
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
