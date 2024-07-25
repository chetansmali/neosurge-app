import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RatioBottomSheet extends StatelessWidget {
  const RatioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'What does Redeem by Ratio mean?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000),
              ),
            ),
          ),
          const Gap(16),
          const Text(
            'You can redeem your basket completely or partially in the ratio of allocation split of the funds at two levels: ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF47586E),
            ),
          ),
          const Gap(16),
          const Text.rich(
            TextSpan(
              text: '1. ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF47586E),
              ),
              children: [
                TextSpan(
                  text: 'Invested Value:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF297DFD),
                  ),
                ),
                TextSpan(
                  text:
                      ' Here the redeem happens at the ratio at which you had invested in the basket and at allocation split the funds were invested in.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          const Text.rich(
            TextSpan(
              text: '2. ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF47586E),
              ),
              children: [
                TextSpan(
                  text: 'Current Value:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF297DFD),
                  ),
                ),
                TextSpan(
                  text:
                      ' Here the redeem happens at the ratio at which your current value of the basket is and at allocation split the funds are currently at.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Understood'),
            ),
          ),
        ],
      ),
    );
  }
}
