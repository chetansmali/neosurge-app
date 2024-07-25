import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/utils.dart';
import '../cubits/mutual_funds/create_consent/create_consent_cubit.dart';

const int _otpSeconds = 120;

class ResendConcentOtpButton extends HookWidget {
  final bool isSip;

  const ResendConcentOtpButton({Key? key, required this.isSip})
      : super(key: key);

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
    return Column(children: [
      Text(
        'Didn\'t receive OTP?',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      BlocListener<CreateConsentCubit, CreateConsentState>(
        listener: (context, state) {
          if (state is CreateConsentSuccess) {
            seconds.value = _otpSeconds;
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if (seconds.value > 0) {
                seconds.value -= 1;
              } else {
                timer.cancel();
              }
            });
            Utils.showSuccessAlert(context, 'OTP resent successfully');
          }
        },
        child: TextButton(
            onPressed: seconds.value != 0
                ? null
                : () {
                    if (isSip) {
                      context.read<CreateConsentCubit>().createSipConsent();
                    } else {
                      context.read<CreateConsentCubit>().createLumpsumConsent();
                    }
                  },
            child: Text(seconds.value == 0
                ? 'Resend'
                : 'Resend in ${Utils.durationString(seconds.value)}')),
      ),
    ]);
  }
}
