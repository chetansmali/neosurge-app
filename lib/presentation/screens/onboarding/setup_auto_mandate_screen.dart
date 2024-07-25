import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/custom_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../routes/routes.dart';

class SetupAutoMandateScreen extends StatelessWidget {
  const SetupAutoMandateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.pushNamedAndRemoveUntil(
          //           context, Routes.dashboard, (route) => false);
          //     },
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         const Text(
          //           'Setup Later',
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             color: Color(0xFF727272),
          //           ),
          //         ),
          //         Icon(
          //           Icons.adaptive.arrow_forward,
          //           color: const Color(0xFF727272),
          //         ),
          //       ],
          //     ),
          //   )
          // ],
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto Mandate',
              style: baseTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(40),
            Assets.svgs.autoMandate.svg(),
            const Gap(40),
            Text(
              'Setup your Auto Mandate for easy SIP Payments',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createAutoMandate);
                },
                child: const Text('Setup Auto Mandate')),
          ],
        ),
      ),
    );
  }
}
