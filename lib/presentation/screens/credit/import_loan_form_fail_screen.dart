import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';

class ImportLoanFormFailScreen extends StatelessWidget {
  const ImportLoanFormFailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Gap(24.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Assets.svgs.dataNotFound.svg(height: 240),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: baseTextStyle14400.copyWith(
                            color: AppColors.neutral[500]),
                        children: [
                          const TextSpan(text: 'This mobile number has '),
                          TextSpan(
                              text: 'not been registered ',
                              style: baseTextStyle14500.copyWith(
                                  color: AppColors.errorRed)),
                          const TextSpan(
                              text:
                                  'with CIBIL. Please complete your registration '
                                  'to proceed with importing your loans.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Go to Dashboard"),
            ),
            const Gap(24.0),
          ],
        ),
      ),
    );
  }
}
