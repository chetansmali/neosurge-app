import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/neobaskets/basket_fund.dart';
import '../../../theme/app_colors.dart' show AppColors;

class BasketSchemeDetailCard extends StatefulWidget {
  const BasketSchemeDetailCard({
    super.key,
    required this.basketFund,
    this.animatedCard = true,
  });

  final BasketFund basketFund;

  final bool animatedCard;

  @override
  State<BasketSchemeDetailCard> createState() => _BasketSchemeDetailCardState();
}

class _BasketSchemeDetailCardState extends State<BasketSchemeDetailCard> {
  bool isCardOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: [
            if (widget.animatedCard)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isCardOpen ? -55 : 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 38.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: AppColors.lightGrey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        children: [
                          _buildInvestedAndReturn(
                            titleOne: 'Return (3Y)',
                            valueOne: '${widget.basketFund.returns ?? '0.0'}%',
                            titleTwo: 'AUM',
                            valueTwo:
                                '${widget.basketFund.aum?.toStringAsFixed(2)} Cr',
                            titleThree: 'Exit Load',
                            valueThree: '${widget.basketFund.exitLoad}%',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCardOpen = !isCardOpen;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://mutualfunds.neosurge.money/${widget.basketFund.logoUrl}',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Text(
                              widget.basketFund.fundName ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Icon(
                            isCardOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInvestedAndReturn(
                        titleOne: 'Category',
                        valueOne: widget.basketFund.fundCategory ?? '',
                        titleTwo: '',
                        valueTwo: '',
                        titleThree: 'Allocation',
                        valueThree:
                            '${widget.basketFund.allocationPercentage}%',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: !isCardOpen ? 0 : 75,
        ),
      ],
    );
  }

  Row _buildInvestedAndReturn({
    required String titleOne,
    required String valueOne,
    required String titleTwo,
    required String valueTwo,
    required String titleThree,
    required String valueThree,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleOne,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
            Text(
              valueOne,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleTwo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
            Row(
              children: [
                Text(
                  valueTwo,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Gap(4),
              ],
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleThree,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
            Row(
              children: [
                Text(
                  valueThree,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Gap(4),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
