import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class BankCardWidget extends StatelessWidget {
  final UserBank bank;

  const BankCardWidget({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.08))
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary[50],
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: bank.imageUrl != null
                  ? Image.network(
                      bank.imageUrl!,
                      height: 30.0,
                      width: 30.0,
                      errorBuilder: (context, error, stackTrace) =>
                          Assets.icons.bank.svg(
                              height: 30.0,
                              width: 30.0,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn)),
                    )
                  : Assets.icons.bank.svg(
                      height: 30.0,
                      width: 30.0,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn)),
            ),
          ),
          const Gap(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bank.bankName,
                  style: baseTextStyle14500.copyWith(
                      color: AppColors.neutral[900]),
                ),
                const Gap(4.0),
                Text(
                  'XXXXXXXX${bank.accountNumber.substring(bank.accountNumber.length - 4)}',
                  style: baseTextStyle12400.copyWith(
                      color: AppColors.neutral[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
