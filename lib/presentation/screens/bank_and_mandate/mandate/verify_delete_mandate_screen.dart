import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/verify_delete_mandate_cubit/verify_delete_mandate_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';

class VerifyDeleteMandateScreen extends StatefulWidget {
  const VerifyDeleteMandateScreen({
    super.key,
    required this.deleteMandateRefId,
  });

  final String deleteMandateRefId;

  @override
  State<VerifyDeleteMandateScreen> createState() =>
      _VerifyDeleteMandateScreenState();
}

class _VerifyDeleteMandateScreenState extends State<VerifyDeleteMandateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  bool _hasForcedError = false;
  String? _otpErrorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cancel SIP',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              BlocConsumer<VerifyDeleteMandateCubit, VerifyDeleteMandateState>(
            listener: (context, state) {
              if (state is VerifyDeleteMandateSuccess) {
                Navigator.of(context).pop();
              }
              if (state is VerifyDeleteMandateError) {
                setState(() {
                  _otpErrorMsg = state.errorMessage;
                });
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                    ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                    const Gap(20),
                  ],
                  ElevatedButton(
                    child: state is VerifyDeleteMandateLoading
                        ? Assets.animations.loading.lottie()
                        : const Text(
                            'Verify OTP',
                          ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<VerifyDeleteMandateCubit>()
                            .verifyDeleteMandate(
                              deleteId: widget.deleteMandateRefId,
                              otp: _otpController.text,
                            );
                      } else {
                        setState(() {
                          _hasForcedError = true;
                        });
                      }
                    },
                  ),
                ],
              );
            },
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
