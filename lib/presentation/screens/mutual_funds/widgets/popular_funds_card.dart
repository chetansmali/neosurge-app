import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class PopularFundsCard extends StatelessWidget {
  const PopularFundsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detailedFundView,
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.pngs.axisLarge.image(),
              const Gap(5),
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Axis Small Cap Fund Direct Growth',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        '45.31%',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '3Y Returns',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFC0C0C0),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Very High Risk',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFC0C0C0),
                    ),
                  ),
                  const Text(
                    'Small Cap',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFC0C0C0),
                    ),
                  ),
                  RatingBarIndicator(
                    itemBuilder: (_, index) => const Icon(
                      Icons.star,
                      color: AppColors.ratingColor,
                    ),
                    itemCount: 5,
                    rating: 3,
                    itemSize: 10,
                  ),
                  const Gap(80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
