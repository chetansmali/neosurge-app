import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class RetirementSortBottomSheet extends StatefulWidget {
  const RetirementSortBottomSheet({super.key});

  @override
  State<RetirementSortBottomSheet> createState() =>
      _RetirementSortBottomSheetState();
}

class _RetirementSortBottomSheetState extends State<RetirementSortBottomSheet> {
  int selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Financial Year', style: baseTextStyle18500),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Assets.icons.crossIcon.image(height: 20, width: 24),
                ),
              ],
            ),
            const Gap(32),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '2022-2023',
                    style: baseTextStyle14400,
                  ),
                  leading: Radio(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('2021-2022', style: baseTextStyle14400),
                  leading: Radio(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Gap(60),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Apply',
                style:
                    baseTextStyle16500.copyWith(color: AppColors.primaryWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
