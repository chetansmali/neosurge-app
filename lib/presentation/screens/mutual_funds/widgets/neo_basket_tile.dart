import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../theme/app_colors.dart';
import 'basket_custom_container.dart';

class NeoBasketTile extends StatelessWidget {
  const NeoBasketTile({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.basketName,
    required this.basketDescription,
    required this.cagr,
    required this.minSip,
    required this.aum,
    this.isThreeYearReturns,
  });

  final VoidCallback onTap;
  final String imageUrl;
  final String basketName;
  final String basketDescription;
  final double cagr;
  final double? minSip;
  final double aum;
  final bool? isThreeYearReturns;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFBFD1FD),
                  radius: 26,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 40,
                    height: 40,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.error[500],
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth / 1.5,
                        child: Text(
                          basketName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 2, // Set the maximum number of lines
                          overflow: TextOverflow
                              .ellipsis, // Show ellipsis (...) if the text overflows
                        ),
                      ),
                      const Gap(4),
                      SizedBox(
                        width: screenWidth / 1.5,
                        child: Text(
                          basketDescription,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF47586E),
                          ),
                          maxLines: 2, // Set the maximum number of lines
                          overflow: TextOverflow
                              .ellipsis, // Show ellipsis (...) if the text overflows
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isThreeYearReturns ?? false)
                  _BasketStatsWidget(
                    title:
                        'CAGR ${isThreeYearReturns ?? false ? '(3Y)' : '(1Y)'}',
                    value: '${cagr.toStringAsFixed(2)}%',
                    valueColor: const Color(0xFF43B649),
                  ),
                _BasketStatsWidget(
                  title: 'Min. SIP',
                  value: Utils.compactCurrency(minSip ?? 0),
                ),
                _BasketStatsWidget(
                  title: 'AUM',
                  value: '${aum.toStringAsFixed(2)} Cr',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BasketStatsWidget extends StatelessWidget {
  const _BasketStatsWidget({
    Key? key,
    required this.title,
    required this.value,
    this.valueColor = Colors.black,
  }) : super(key: key);

  final String title;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0B0B0),
          ),
        ),
        const Gap(2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
