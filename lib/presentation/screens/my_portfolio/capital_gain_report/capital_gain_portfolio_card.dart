import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_container.dart';

class CapitalGainPortFolioCard extends StatelessWidget {
  final double? capitalgain;
  final double? absolutegain;
  final double? taxablegain;
  final String term;
  const CapitalGainPortFolioCard(
      {super.key,
      required this.capitalgain,
      required this.absolutegain,
      required this.taxablegain,
      required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: CustomContainer(
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInvestedAndReturn(
                    titleOne: 'Absolute Gains',
                    valueOne: Utils.compactCurrency(
                      absolutegain ?? 0.0,
                    ),
                    titleTwo: 'Taxable Gains',
                    valueTwo: Utils.compactCurrency(taxablegain ?? 0.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildInvestedAndReturn({
    required String titleOne,
    required String valueOne,
    required String titleTwo,
    required String valueTwo,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleOne,
                style: baseTextStyle14400.copyWith(color: AppColors.textGrey),
              ),
              const Gap(4),
              Text(
                valueOne,
                style: baseTextStyle16500.copyWith(color: AppColors.mainBlack),
              )
            ],
          ),
        ),
        const Gap(40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleTwo,
                style: baseTextStyle14400.copyWith(color: AppColors.textGrey),
              ),
              const Gap(4),
              Text(
                valueTwo,
                style: baseTextStyle16500.copyWith(color: AppColors.mainBlack),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
