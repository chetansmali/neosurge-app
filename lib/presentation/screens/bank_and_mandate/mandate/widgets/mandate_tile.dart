import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../../theme/app_colors.dart';
import '../../../mutual_funds/widgets/basket_custom_container.dart';

class MandateTile extends StatelessWidget {
  const MandateTile({
    super.key,
    required this.mandate,
    this.onTap,
  });

  final UserBankMandateModel mandate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    mandate.mandateId.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: mandate.status.toLowerCase() == 'approved'
                        ? AppColors.success[50]
                        : AppColors.neutral[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    mandate.status.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: mandate.status.toLowerCase() == 'approved'
                          ? AppColors.success[500]
                          : AppColors.neutral[500],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.neutral[100],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Created on ${mandate.createdOn}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.neutral[400],
                  ),
                ),
                const Spacer(),
                if (onTap != null)
                  const Icon(
                    CupertinoIcons.arrowtriangle_right_fill,
                    color: Colors.black,
                    size: 14,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
