import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/switch/switch_order_response.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/resend_transaction_otp/resend_transaction_otp_cubit.dart';
import '../../../cubits/mutual_funds/verify_transaction_otp/verify_transaction_otp_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../widgets/error_info_widget.dart';
import '../widgets/resend_transaction_otp_widget.dart';

class SwitchFundVerifyOtpScreen extends StatefulWidget {
  final Fund fund;
  final Fund switchFund;
  final UserMfScheme scheme;
  final SwitchOrderResponse switchOrderResponse;

  const SwitchFundVerifyOtpScreen({
    Key? key,
    required this.fund,
    required this.switchFund,
    required this.scheme,
    required this.switchOrderResponse,
  }) : super(key: key);

  @override
  State<SwitchFundVerifyOtpScreen> createState() =>
      _SwitchFundVerifyOtpScreenState();
}

class _SwitchFundVerifyOtpScreenState extends State<SwitchFundVerifyOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasForcedError = false;
  String? _otpErrorMsg;
  final _otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
                'Your switch request will be cancelled if you leave this screen.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text('Leave'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Enter Transaction OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'sent to +91 ${context.read<AuthCubit>().state.user!.mobileNumber}',
                      ),
                      const Gap(20),
                      Pinput(
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
                        cursor: CustomStyles.pinPutCursor,
                      ),
                      const Gap(16),
                      BlocProvider(
                        create: (context) => getIt<ResendTransactionOtpCubit>(),
                        child: ResendTransactionOtpWidget(
                          transactionType: MFTransactionTypes.switchTransaction,
                          transactionId: widget.switchOrderResponse.id,
                        ),
                      ),
                      const Spacer(),
                      if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                        ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                        const Gap(20),
                      ],
                      BlocConsumer<VerifyTransactionOtpCubit,
                          VerifyTransactionOtpState>(
                        listener: (context, state) {
                          if (state is VerifyTransactionOtpSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.mfTransactionStatus,
                              (route) => route.isFirst,
                              arguments: MfTransactionStatusArgs(
                                transactionStatus: MfTransactionStatus.success,
                                transactionType:
                                    MFTransactionTypes.switchTransaction,
                                isAssistedService: widget.scheme.isAssistedFund,
                              ),
                            );
                          }
                          if (state is VerifyTransactionOtpFailure) {
                            setState(() {
                              _otpErrorMsg = Utils.getErrorMessage(
                                errorType: state.errorType,
                                msg: state.error,
                              );

                              _hasForcedError = true;
                            });
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<VerifyTransactionOtpCubit>()
                                    .verifyTransactionOtp(
                                      otp: _otpController.text,
                                      transactionId:
                                          widget.switchOrderResponse.id,
                                      transactionType:
                                          MFTransactionTypes.switchTransaction,
                                    );
                              }
                            },
                            child: state is VerifyTransactionOtpLoading
                                ? Assets.animations.loading.lottie()
                                : const Text('Continue'),
                          );
                        },
                      ),
                      const Gap(20),
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
