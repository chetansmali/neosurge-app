import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class MFSearchResultCard extends StatelessWidget {
  final Fund fund;

  const MFSearchResultCard({Key? key, required this.fund}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detailedFundView,
            arguments: DetailedFundViewArgs(schemeCode: fund.schemeCode),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: fund.imgUrl,
                height: 50,
                width: 50,
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(
                            fund.schemeNameUnique,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${fund.performance.threeY} %',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            fund.riskProfile.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFC0C0C0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            fund.assetCategory,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFC0C0C0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RatingBarIndicator(
                            itemBuilder: (_, index) => const Icon(
                              Icons.star,
                              color: AppColors.ratingColor,
                            ),
                            itemCount: 5,
                            rating: fund.vrRating.isNotEmpty
                                ? fund.vrRating.length.toDouble()
                                : 0,
                            itemSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
