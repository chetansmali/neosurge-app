import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class AddBankErrorScreen extends StatelessWidget {
  final AppErrorType errorType;
  final String? msg;
  const AddBankErrorScreen(
      {super.key, required this.errorType, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.animations.bankDepositeError
                  .lottie(height: 120, width: 130),
              const Gap(24),
              Text(
                errorType.toString(),
                style: baseTextStyle14500.copyWith(color: AppColors.errorRed),
              ),
              const Gap(8),
              Text(
                msg ?? '',
                style: baseTextStyle12400.copyWith(color: AppColors.textGrey),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Try again',
            style: baseTextStyle16500.copyWith(color: AppColors.primaryWhite),
          ),
        ),
      ),
    );
  }
}
