import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../gen/assets.gen.dart';
import 'credit_screen.dart';

class LoanClosureReqSubmitted extends StatelessWidget {
  const LoanClosureReqSubmitted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreditScreen()));
              },
              child: const Text('Done')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.animations.loanClosureReqSubmitted.lottie(),
            Text(
              'Loan closure request submitted',
              style: baseTextStyle16500,
            ),
            const Gap(32),
            Text(
              'This may take upto 3 days. Keep an eye out for an NOC on your registered email',
              style:
                  baseTextStyle12400.copyWith(color: const Color(0xFF565A5F)),
            ),
          ],
        ),
      ),
    );
  }
}
