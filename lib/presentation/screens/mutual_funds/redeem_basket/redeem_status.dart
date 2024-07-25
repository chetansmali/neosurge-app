import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';

class RedeemBasketStatusScreen extends StatelessWidget {
  const RedeemBasketStatusScreen({super.key});

  final bool isSuccessful = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              isSuccessful
                  ? Assets.animations.buyBasketSuccess.lottie()
                  : Assets.animations.buyBasketFail.lottie(),
              const Gap(12),
              Center(
                child: Text(
                  isSuccessful
                      ? 'Redeem Request Received!'
                      : 'Transaction Failed',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF050C1B),
                  ),
                ),
              ),
              const Gap(2),
              Center(
                child: Text(
                  isSuccessful
                      ? 'Request will be sent to AMC.'
                      : 'Unable to process your request. Please try again later.',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
              const Gap(12),
              const Spacer(),
              if (isSuccessful) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(12),
                TextButton(
                  onPressed: () {},
                  child: const Text('Track Order'),
                )
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(12),
                TextButton(
                  onPressed: () {},
                  child: const Text('Contact Support'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
