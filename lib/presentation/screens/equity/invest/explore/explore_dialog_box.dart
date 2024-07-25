import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';

class ShowDialog extends StatefulWidget {
  const ShowDialog({super.key});

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ), // this is the key
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 8,
          top: 24,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // To make the dialog compact
          children: <Widget>[
            Text(
              'To view stock info and start investing, link to a broker',
              textAlign: TextAlign.center,
              style: baseTextStyle14600,
            ),
            const Gap(8),
            Text(
              'Link now?',
              style: baseTextStyle.copyWith(
                color: AppColors.textLightGrey,
              ),
            ),
            const Gap(42),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.equityLogin,
                );
              },
              child: const Text('Yes'),
            ),
            const Gap(10),
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(250, 48),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: baseTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
