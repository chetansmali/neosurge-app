import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/lamf/lamf_loan_closure/lamf_loan_closure_cubit.dart';
import '../loan_closure_screen.dart';

Widget selectImageAsset(loanCloserStatus) {
  switch (loanCloserStatus) {
    case LoanCloserStatus.green:
      return Image.asset(
        Assets.pngs.loanClosureGreen.path.toString(),
        height: 100,
        width: 24,
      );
    case LoanCloserStatus.grey:
      return Image.asset(
        Assets.pngs.loanClosureGrey.path.toString(),
        height: 100,
        width: 24,
      );
    case LoanCloserStatus.yellow:
      return Image.asset(
        Assets.pngs.loanClosureYellow.path.toString(),
        height: 100,
        width: 24,
      );
    default:
      return const SizedBox.shrink();
  }
}

GestureDetector loanCloserStatusBannerConfirm(
    BuildContext context, String title, LoanCloserStatus loanCloserStatus) {
  return GestureDetector(
    onTap: () {},
    child: Material(
      elevation: 0.1,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      64), // Adjusted the value
              child: Text(
                title,
                style: baseTextStyle12500,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            loanCloserStatus == LoanCloserStatus.green
                ? GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Column(
                      children: [
                        const Gap(4),
                        Text(
                          'Confirm',
                          style: baseTextStyle12500.copyWith(
                              color: const Color(0xFF2E8EFF)),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    ),
  );
}

Material loanCloserStatusBanner(
    BuildContext context, String title, LoanCloserStatus loanCloserStatus) {
  return Material(
    elevation: 0.1,
    borderRadius: BorderRadius.circular(6),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width -
                    64), // Adjusted the value
            child: Text(
              title,
              style: baseTextStyle12500,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (loanCloserStatus == LoanCloserStatus.green ||
              loanCloserStatus == LoanCloserStatus.yellow)
            const Gap(2),
          Text(
            '15 Sep 2023, 4:45 PM',
            style: baseTextStyle10400.copyWith(color: const Color(0xFFB0B0B0)),
          ),
        ],
      ),
    ),
  );
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // To fit content size
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Are you sure?',
                      style: baseTextStyle18500.copyWith(
                          color: const Color(0xFF2C3137))),
                  Image.asset(
                    Assets.pngs.deleteIcon.path.toString(),
                    height: 24,
                    width: 24,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 3.0,
                      backgroundColor: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Upon loan closure, you will not be able to withdraw cash against your current credit limit',
                        style: baseTextStyle12400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Space between points
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 3.0,
                      backgroundColor: Colors.black, // Bullet point color
                    ),
                    const SizedBox(
                        width:
                            8), // Space between the bullet point and the text
                    Expanded(
                      child: Text(
                        'Your pledged mutual funds will be released',
                        style: baseTextStyle12400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    context.read<LamfLoanClosureCubit>().lamfLoanClosure();
                  },
                  child: const Text('Confirm')),
            ),
            const Gap(10),
          ],
        ),
      );
    },
  );
}
