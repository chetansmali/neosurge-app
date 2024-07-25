import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../domain/entities/enums.dart';
import '../../../theme/app_colors.dart';
import 'order_styles.dart';

class SwpStepper extends HookWidget {
  final MfOrder mfOrder;

  const SwpStepper({Key? key, required this.mfOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final df = useMemoized(() => DateFormat('dd MMM yyyy, hh:mm a'));
    final df2 = useMemoized(() => DateFormat('dd MMM yyyy'));

    return EnhanceStepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: (mfOrder.submittedAt == null || mfOrder.status == MFOrderStatus.failed) ? 0 : 1,
      steps: [
        EnhanceStep(
          title: Text(
            'Swp Request Placed on Neosurge',
            style: OrderStyles.finishedStepTitleStyleLight,
          ),
          subtitle: Text(df.format(mfOrder.createdAt.toLocal()), style: OrderStyles.finishedStepSubtitleStyleLight),
          content: const SizedBox.shrink(),
          icon: const Icon(
            Icons.check_circle_outline,
            color: AppColors.green,
          ),
        ),
        //If mf payment is failed, show the failed step.
        if (mfOrder.status == MFOrderStatus.failed) ...[
          EnhanceStep(
            title: Text(
              'Swp Request Failed',
              style: OrderStyles.finishedStepTitleStyleLight,
            ),
            content: Text(df.format(mfOrder.failedAt!.toLocal()), style: OrderStyles.finishedStepSubtitleStyleLight),
            icon: const Icon(
              Icons.close_outlined,
              color: AppColors.errorRed,
            ),
          ),
        ] else if (mfOrder.status == MFOrderStatus.pending) ...[
          const EnhanceStep(title: Text('Swp request processing'), content: SizedBox.shrink(), icon: Icon(Icons.schedule_rounded, color: AppColors.darkOrange)),
        ] else ...[
          EnhanceStep(
            title: const Text('Swp Successful'),
            subtitle: Text(df2.format(mfOrder.succeededAt!.toLocal()), style: OrderStyles.finishedStepSubtitleStyleLight),
            content: const SizedBox.shrink(),
            icon: const Icon(Icons.check_circle_outline, color: AppColors.green),
          ),
        ]

        // //If we don't have submittedAt date it means payment is processing
        // else if (mfOrder.submittedAt == null) ...[
        //   EnhanceStep(
        //     title: Text(
        //       'Payment Processing',
        //       style: OrderStyles.unfinishedStepTitleStyle,
        //     ),
        //     content: const SizedBox.shrink(),
        //     icon: const Icon(
        //       Icons.schedule_outlined,
        //       color: AppColors.darkOrange,
        //     ),
        //   ),
        // ]
        // //If we have submittedAt date, it means payment is successful
        // // else ...[
        // //   EnhanceStep(
        // //     title: Text(
        // //       'Payment Successful',
        // //       style: OrderStyles.finishedStepTitleStyle,
        // //     ),
        // //     subtitle: Text(df.format(mfOrder.submittedAt!.toLocal()),
        // //         style: OrderStyles.finishedStepSubtitleStyle),
        // //     content: const SizedBox.shrink(),
        // //     icon: const Icon(
        // //       Icons.check_circle_outline,
        // //       color: AppColors.green,
        // //     ),
        // //   ),
        // //   //If further status is pending it means unit allocation has to be done
        // //   mfOrder.status == MFOrderStatus.pending
        // //       ? EnhanceStep(
        // //           title: Text(
        // //             'Unit(s) allocation in progress',
        // //             style: OrderStyles.unfinishedStepTitleStyle,
        // //           ),
        // //           subtitle: Text(
        // //               'Expect by ${df2.format(mfOrder.submittedAt!.add(const Duration(days: 3)))}',
        // //               style: OrderStyles.unfinishedStepSubtitleStyle),
        // //           content: const SizedBox.shrink(),
        // //           icon: const Icon(
        // //             Icons.schedule_outlined,
        // //             color: AppColors.darkOrange,
        // //           ),
        // //         )
        // //       : EnhanceStep(
        // //           title: Text(
        // //             'Units allocated',
        // //             style: OrderStyles.finishedStepTitleStyle,
        // //           ),
        // //           subtitle: Text(df.format(mfOrder.succeededAt!.toLocal()),
        // //               style: OrderStyles.finishedStepSubtitleStyle),
        // //           content: const SizedBox.shrink(),
        // //           icon: const Icon(
        // //             Icons.check_circle_outline,
        // //             color: AppColors.green,
        // //           ),
        // //         ),
        // // ],
      ],
      // controlsBuilder: (context, details) =>
      // mfOrder.status == MFOrderStatus.pending && mfOrder.submittedAt != null
      //     ? Container(
      //   padding: const EdgeInsets.all(12),
      //   decoration: BoxDecoration(
      //     color: AppColors.lightGrey,
      //     borderRadius: const BorderRadius.all(Radius.circular(6)),
      //     border: Border.all(
      //       color: AppColors.secondaryLightBlue,
      //       width: 0.5,
      //     ),
      //   ),
      //   child: Text(
      //     'We are currently awaiting the status on your unit allocation from AMC. Don\'t worry, the NAV applicable will be as on ${df2.format(
      //       mfOrder.createdAt.subtract(
      //         const Duration(days: 1),
      //       ),
      //     )}',
      //     style: const TextStyle(fontSize: 10.5),
      //   ),
      // )
      //     : const SizedBox.shrink(),
      controlsBuilder: (context, details) => const SizedBox.shrink(),
    );
  }
}
