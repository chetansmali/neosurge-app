import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class StartAssistedServiceScreen extends StatelessWidget {
  const StartAssistedServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.svgs.startAssistedService.svg(),
            const Gap(20),
            Text(
              'Your Perfect Investment Plan in under 3 Minutes',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.secondaryViolet),
            ),
            const Gap(20),
            const Text(
              'Answer these questions to help us plan and analyze the best investment strategy for you',
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.assistedServiceQuiz);
                },
                child: const Text('Get Started'))
          ],
        ),
      ),
    );
  }
}
