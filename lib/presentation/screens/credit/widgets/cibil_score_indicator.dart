import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../theme/app_colors.dart';

class CIBILScoreIndicator extends StatelessWidget {
  const CIBILScoreIndicator({
    super.key,
    required this.score,
  });
  final double score;

  @override
  Widget build(BuildContext context) {
    final double formattedScore = Utils.mapRange(score, 300, 900, 0, 100);

    return Column(
      children: [
        Text(
          'CIBIL Score',
          style: baseTextStyle16500.copyWith(color: AppColors.neutral[400]),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      height: constraints.maxWidth / 1.1,
                      width: constraints.maxWidth / 1.1,
                      child: Column(
                        children: [
                          Flexible(
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  startAngle: 180,
                                  showLabels: false,
                                  showAxisLine: false,
                                  showTicks: false,
                                  endAngle: 0,
                                  canScaleToFit: true,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 41,
                                      color: AppColors.error[400],
                                      startWidth: 15,
                                      endWidth: 15,
                                    ),
                                    GaugeRange(
                                      startValue: 43,
                                      endValue: 57.5,
                                      color: AppColors.alert[400],
                                      startWidth: 15,
                                      endWidth: 15,
                                    ),
                                    GaugeRange(
                                      startValue: 59.5,
                                      endValue: 74,
                                      color: AppColors.success[200],
                                      startWidth: 15,
                                      endWidth: 15,
                                    ),
                                    GaugeRange(
                                      startValue: 76,
                                      endValue: 100,
                                      color: AppColors.success[500],
                                      startWidth: 15,
                                      endWidth: 15,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      enableAnimation: true,
                                      animationType: AnimationType.elasticOut,
                                      value: formattedScore,
                                      knobStyle: const KnobStyle(
                                        knobRadius: 0.1,
                                        borderColor: Colors.white,
                                        borderWidth: 0.02,
                                      ),
                                      needleEndWidth: 6,
                                      needleStartWidth: 0,
                                      needleLength: 0.7,
                                    ),
                                    const MarkerPointer(
                                      markerType: MarkerType.text,
                                      value: 10,
                                      offsetUnit: GaugeSizeUnit.factor,
                                    ),
                                    const MarkerPointer(
                                      markerType: MarkerType.text,
                                      value: 30,
                                      offsetUnit: GaugeSizeUnit.factor,
                                    ),
                                    const MarkerPointer(
                                      markerType: MarkerType.text,
                                      value: 52,
                                      offsetUnit: GaugeSizeUnit.factor,
                                    ),
                                    const MarkerPointer(
                                      markerType: MarkerType.text,
                                      value: 76,
                                      offsetUnit: GaugeSizeUnit.factor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                score.ceil().toString(),
                                style: baseTextStyle21500.copyWith(
                                    color: AppColors.neutral[500]),
                              ),
                              Text(
                                _calculateLabel(score),
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.neutral[200]),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     if (refreshable) const Gap(20),
                          //     Column(
                          //       children: [
                          //         Text(
                          //           score.ceil().toString(),
                          //           style: baseTextStyle21500.copyWith(
                          //               color: AppColors.neutral[500]),
                          //         ),
                          //         Text(
                          //           _calculateLabel(score),
                          //           style: baseTextStyle12400.copyWith(
                          //               color: AppColors.neutral[200]),
                          //         ),
                          //       ],
                          //     ),
                          //     if (refreshable)
                          //       IconButton(
                          //         onPressed: onTap,
                          //         icon: const Icon(Icons.sync_rounded),
                          //         color: AppColors.primary[500],
                          //         visualDensity: VisualDensity.compact,
                          //       ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Gap(8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.error[400],
                        ),
                        height: 10.0,
                        width: 10.0,
                      ),
                      const Gap(8),
                      Text(
                        'Poor',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.mainBlack.withOpacity(0.8)),
                      ),
                      const Spacer(),
                      Text(
                        '300 - 550',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.textLightGrey),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Gap(8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.alert[400],
                        ),
                        height: 10.0,
                        width: 10.0,
                      ),
                      const Gap(8),
                      Text(
                        'Average',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.mainBlack.withOpacity(0.8)),
                      ),
                      const Spacer(),
                      Text(
                        '550 - 650',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.textLightGrey),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Gap(8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.success[200],
                        ),
                        height: 10.0,
                        width: 10.0,
                      ),
                      const Gap(8),
                      Text(
                        'Good',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.mainBlack.withOpacity(0.8)),
                      ),
                      const Spacer(),
                      Text(
                        '650 - 750',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.textLightGrey),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Gap(8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.success[500],
                        ),
                        height: 10.0,
                        width: 10.0,
                      ),
                      const Gap(8),
                      Text(
                        'Excellent',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.mainBlack.withOpacity(0.8)),
                      ),
                      const Spacer(),
                      Text(
                        '750 - 900',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.textLightGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _calculateLabel(double value) {
    switch (value) {
      case >= 300 && <= 550:
        return 'Poor';
      case >= 550 && <= 650:
        return 'Average';
      case > 650 && <= 750:
        return 'Good';
      case > 750 && <= 900:
        return 'Excellent';
      default:
        return 'Undefined';
    }
  }
}
