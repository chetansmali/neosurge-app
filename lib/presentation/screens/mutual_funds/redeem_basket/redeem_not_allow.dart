import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../widgets/basket_custom_container.dart';

class BasketRedeemNotAllow extends StatelessWidget {
  const BasketRedeemNotAllow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Basket'),
      ),
      body: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Within Lock-in Period',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFBFD1FD),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Assets.pngs.basketLargeCap.image(),
                  ),
                ),
                const Gap(16),
                const Text(
                  'Sectoral Technology Basket',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Gap(32),
            const Text(
              'You cannot redeem this basket!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFCC3A3A),
              ),
            ),
            const Gap(12),
            const Text(
              'All funds in this basket have a lock-in period of 3 years. You can redeem these funds only after 3 years from the date of investment.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF47586E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
