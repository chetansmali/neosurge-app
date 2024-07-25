import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../routes/routes.dart';

class NewsBanner extends StatelessWidget {
  const NewsBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 0.2,
        child: Stack(
          children: [
            Assets.pngs.marketBannerLines.image(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your daily dose of finance',
                    style: baseTextStyle16500,
                  ),
                  const Gap(4),
                  RichText(
                    text: TextSpan(
                      style: baseTextStyle12400.copyWith(
                          color: const Color(0XFF727579)), // Default style
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Top 10',
                          style: TextStyle(
                              color: Color(0xFFFF4949),
                              fontWeight: FontWeight
                                  .w500), // Override color for "Top 10"
                        ),
                        TextSpan(
                          text: ' highlights curated for your portfolio',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.marketNews);
                              },
                              child: const Text('Explore news'))),
                      const Gap(50),
                      Assets.pngs.news.image(height: 96, width: 96)
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Assets.pngs.clock.image(height: 16,width: 16),
                  //     const Gap(10),
                  //     RichText(
                  //       text: TextSpan(
                  //         style: baseTextStyle12500.copyWith(color: Colors.black),
                  //         children: const <TextSpan>[
                  //           TextSpan(text: '22', style: TextStyle(fontWeight: FontWeight.bold)), // Bold part
                  //           TextSpan(text: ' hours left to view'), // Regular part
                  //         ],
                  //       ),
                  //     )
                  //
                  //
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
