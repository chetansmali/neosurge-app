import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../common/utils.dart';
import '../../../../domain/entities/params/retirement_calculator/generate_retirement_OTP_params.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/retirement_calculator/generate_retirement_otp_cubit.dart';
import '../../../theme/app_colors.dart';

const int _otpSeconds = 120;

class RetirementResendOTPScreen extends HookWidget {
  final String? mobileNumber;
  final bool? isTitleVisible;
  final CrossAxisAlignment? crossAxisAlignment;

  const RetirementResendOTPScreen({
    Key? key,
    this.mobileNumber,
    this.isTitleVisible = true,
    this.crossAxisAlignment,
  })  : assert(mobileNumber != null, "mobileNumber must be provided"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final seconds = useState<int>(_otpSeconds);
    late Timer timer;
    useEffect(
      () {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (seconds.value > 0) {
            seconds.value -= 1;
          } else {
            timer.cancel();
          }
        });
        return () => timer.cancel();
      },
      const [],
    );
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        if (isTitleVisible ?? true)
          Text(
            'Didn\'t receive OTP?',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        BlocListener<GenerateRetirementOtpCubit, GenerateRetirementOtpState>(
          listener: (context, state) {
            if (state is GenerateRetirementOtpSuccess) {
              seconds.value = _otpSeconds;
              timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                if (seconds.value > 0) {
                  seconds.value -= 1;
                } else {
                  timer.cancel();
                }
              });
            }
          },
          child: TextButton(
            onPressed: seconds.value != 0
                ? null
                : () {
                    if (mobileNumber != null) {
                      context
                          .read<GenerateRetirementOtpCubit>()
                          .getRetirementotp(
                            GenerateRetirementOTPParams(
                              mobileNumber: context
                                  .read<AuthCubit>()
                                  .state
                                  .user!
                                  .mobileNumber!,
                            ),
                          );
                    }
                  },
            child: Text.rich(
              TextSpan(
                text: 'Request new OTP',
                style: TextStyle(
                  fontSize: 12,
                  color: seconds.value != 0
                      ? AppColors.mainBlack
                      : AppColors.secondaryViolet,
                ),
                children: seconds.value == 0
                    ? []
                    : [
                        const TextSpan(
                          text: ' in ',
                        ),
                        TextSpan(
                          text: Utils.durationString(seconds.value),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryViolet,
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
