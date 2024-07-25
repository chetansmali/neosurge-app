import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/params/lamf/submit_import_otp_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/lamf/submit_import_otp/submit_import_otp_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../theme/app_colors.dart';
import '../../widgets/error_info_widget.dart';

class ImportLoanPhoneValidationScreen extends StatefulWidget {
  const ImportLoanPhoneValidationScreen({super.key, required this.args});
  final ImportLoanPhoneValidationArgs args;

  @override
  State<ImportLoanPhoneValidationScreen> createState() =>
      _ImportLoanPhoneValidationScreenState();
}

class _ImportLoanPhoneValidationScreenState
    extends State<ImportLoanPhoneValidationScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _otpErrorMsg = '';
  bool _hasForcedError = false;

  bool _submitting = false;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CustomScrollView(
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 24.0)),
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
                      'sent to +91${widget.args.phoneNum}',
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
                      defaultPinTheme: CustomStyles.defaultPinTheme,
                      errorPinTheme: CustomStyles.errorPinTheme,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      forceErrorState: _hasForcedError,
                      showCursor: false,
                      cursor: cursor,
                    ),
                    const Spacer(),
                    if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                      ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                      const Gap(20),
                    ],
                    BlocListener<SubmitImportOtpCubit, SubmitImportOtpState>(
                      listener: (context, state) {
                        switch (state) {
                          case SubmitImportOtpLoading():
                            setState(() => _submitting = true);
                          case SubmitImportOtpSuccess():
                            setState(() => _submitting = false);
                            // TODO: Change tabBar index to Other Loans
                            Utils.showSuccessAlert(
                                context, 'Imported loans successfully');
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          case SubmitImportOtpFailure():
                            setState(() {
                              _otpErrorMsg = 'Couldn\'t submit request';
                              _submitting = false;
                            });
                          default:
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<SubmitImportOtpCubit>()
                              .submitImportOtp(SubmitImportOtpParams(
                                questionKey: widget.args.questionKey,
                                answerKey: widget.args.answerKey,
                                accessToken: widget.args.accessToken,
                                otp: _controller.text.trim(),
                              ));
                        },
                        child: !_submitting
                            ? const Text('Continue')
                            : Assets.animations.loading.lottie(),
                      ),
                    ),
                    const Gap(24.0),
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
