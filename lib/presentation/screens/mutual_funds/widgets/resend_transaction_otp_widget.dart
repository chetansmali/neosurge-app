import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/utils.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/resend_transaction_otp/resend_transaction_otp_cubit.dart';
import '../../../theme/app_colors.dart';

const int _otpSeconds = 120;

class ResendTransactionOtpWidget extends HookWidget {
  final int transactionId;
  final MFTransactionTypes transactionType;

  const ResendTransactionOtpWidget({
    Key? key,
    required this.transactionType,
    required this.transactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seconds = useState<int>(_otpSeconds);
    late Timer timer;
    useEffect(() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds.value -= 1;
        } else {
          timer.cancel();
        }
      });
      return () => timer.cancel();
    }, const []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocListener<ResendTransactionOtpCubit, ResendTransactionOtpState>(
          listener: (context, state) {
            if (state is ResendTransactionOtpSuccess) {
              seconds.value = _otpSeconds;
              timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                if (seconds.value > 0) {
                  seconds.value -= 1;
                } else {
                  timer.cancel();
                }
              });
              // Utils.showSuccessAlert(context, 'OTP resent successfully');
            }
            if (state is ResendTransactionOtpFailure) {
              Utils.showErrorAlert(
                context,
                Utils.getErrorMessage(
                  errorType: state.errorType,
                  msg: state.error,
                ),
              );
            }
          },
          child: TextButton(
            onPressed: seconds.value != 0
                ? null
                : () {
                    context.read<ResendTransactionOtpCubit>().resendOtp(
                          userId: context.read<AuthCubit>().state.user!.id,
                          transactionId: transactionId,
                          transactionType: transactionType,
                        );
                  },
            child: Text(
              seconds.value == 0
                  ? 'Request new OTP'
                  : 'Request in ${Utils.durationString(seconds.value)}',
              style: TextStyle(
                color: AppColors.primary[500],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
