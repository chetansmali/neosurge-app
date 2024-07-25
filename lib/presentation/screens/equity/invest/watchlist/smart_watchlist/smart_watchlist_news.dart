import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../common/custom_styles.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_colors.dart';

class SmartWatchlistNews extends StatelessWidget {
  final String description;
  final String source;
  final int date;
  final double sentiment;
  const SmartWatchlistNews(
      {super.key,
      required this.description,
      required this.source,
      required this.date,
      required this.sentiment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: sentiment > 0
            ? AppColors.green.withOpacity(0.1)
            : AppColors.errorRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: sentiment > 0
              ? AppColors.green.withOpacity(0.2)
              : AppColors.errorRed.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 55,
                  width: 2,
                  decoration: BoxDecoration(
                    color: sentiment > 0 ? AppColors.green : AppColors.errorRed,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.52,
                      ),
                      child: Text(
                        description,
                        style: baseTextStyle12500,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(10),
                    sentiment > 0
                        ? Assets.gifs.trendingUp.image(
                            height: 24,
                            width: 24,
                          )
                        : Assets.gifs.trendingDown.image(
                            height: 24,
                            width: 24,
                          )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          source,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: baseTextStyle10400.copyWith(
                              color: AppColors.textGrey),
                        ),
                      ),
                      Text(
                        Utils.dateTime(date),
                        style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
