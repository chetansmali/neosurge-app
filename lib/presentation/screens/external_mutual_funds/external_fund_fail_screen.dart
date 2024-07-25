import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../theme/app_colors.dart';

class ImportExternalFundFailScreen extends StatelessWidget {
  const ImportExternalFundFailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Lottie.asset(
                'assets/animations/fund_import_fail.json',
                height: 200,
              ),
              const Gap(24),
              const Text(
                'No investments found!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.mainBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Looks like your PAN EAZNZ2341A does not have\nany mutual fund investments linked with mobile number\n+91 8862023908.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Continue with alternate mobile'),
                ),
              ),
              const Gap(16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('I\'ll do it later'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
