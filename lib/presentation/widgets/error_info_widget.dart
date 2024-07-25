import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/app_colors.dart';

class ErrorInfoWidget extends StatelessWidget {
  const ErrorInfoWidget({
    super.key,
    required String? otpErrorMsg,
    this.backgroundColor,
    this.foregroundColor,
    this.textAlign,
  }) : _otpErrorMsg = otpErrorMsg;

  final String? _otpErrorMsg;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _otpErrorMsg == null
        ? const Gap(0)
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.errorRed.withOpacity(0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: foregroundColor ?? AppColors.errorRed,
                ),
                const Gap(4),
                Expanded(
                  child: Text(
                    _otpErrorMsg!,
                    textAlign: textAlign ?? TextAlign.left,
                    style: TextStyle(
                      color: foregroundColor ?? AppColors.errorRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
