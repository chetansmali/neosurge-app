import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 6,
        shadowColor: AppColors.textLightGrey,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 46,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Assets.icons.magniferHome.svg(),
                const Gap(10),
                Text(
                  'Search for stock eg: INFY',
                  style: baseTextStyle12600.copyWith(
                      color: AppColors.textLightGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
