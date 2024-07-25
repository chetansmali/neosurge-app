import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../theme/app_colors.dart';

class CancelSipSuccessScreen extends StatelessWidget {
  const CancelSipSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.cancel,
                size: 100,
                color: AppColors.green,
              ),
              const Text(
                'SIP cancelled successfully',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok, Got It')),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
