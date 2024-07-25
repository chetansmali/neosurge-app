import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../theme/app_colors.dart';

class ConfirmPrimaryBottomSheet extends StatelessWidget {
  const ConfirmPrimaryBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.info_rounded,
                color: AppColors.primaryColor,
              ),
              Gap(5),
              Text(
                'Information',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
          const Divider(),
          const Text('Are you sure you want to change your primary bank account?'),
          const Gap(5),
          const Text('Your existing SIP installments will continue being debited from older mandate'),
          const Gap(5),
          const Text('Your new SIP installments will be debited from your new primary mandate'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Gap(5),
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.textGreyGold),
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const Gap(5),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
