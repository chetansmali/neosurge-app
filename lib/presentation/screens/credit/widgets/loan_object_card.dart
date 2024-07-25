import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class LoanObjectCard extends StatelessWidget {
  final String title, cardNumber, bankName, status, accountID;
  final Color statusTextColor;

  const LoanObjectCard({
    Key? key,
    required this.title,
    required this.cardNumber,
    required this.bankName,
    required this.status,
    required this.statusTextColor,
    required this.accountID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.otherLoansDetailedScreen,
              arguments: OtherLoanDetailScreenArgs(accountID: accountID));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: CustomStyles.defaultCardShadow()),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                child: Text(
                  title,
                  style: baseTextStyle14500.copyWith(
                      color: const Color(0xFF2c3137)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(12),
              Text(
                cardNumber,
                style:
                    baseTextStyle14500.copyWith(color: const Color(0xFF2c3137)),
              ),
              const Gap(12),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary[100],
                ),
                child: Icon(
                  Icons.north_east_rounded,
                  size: 16.0,
                  color: AppColors.primary[500],
                ),
              ),
            ]),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: baseTextStyle12500.copyWith(
                      color: const Color(0xFF727579)),
                ),
                const Spacer(),
                Text(
                  status,
                  style: baseTextStyle12500.copyWith(color: statusTextColor),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
