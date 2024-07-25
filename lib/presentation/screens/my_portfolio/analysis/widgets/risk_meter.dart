import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'analysis_section_card.dart';

class RiskMeter extends StatelessWidget {
  const RiskMeter({
    super.key,
    required this.equityPercentage,
  });
  final double equityPercentage;
  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Risk Indicator',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Divider(),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 130,
                startAngle: 180,
                showLabels: false,
                showAxisLine: false,
                endAngle: 0,
                axisLabelStyle: const GaugeTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                canScaleToFit: true,
                // backgroundImage: AssetImage(
                //   'assets/pngs/Ellipse 1.png',
                // ),
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 20,
                    color: const Color(0xFF30AD43),
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                    startValue: 22,
                    endValue: 42,
                    color: const Color(0xFF84BD32),
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                    startValue: 44,
                    endValue: 64,
                    color: const Color(0xFFD1D80F),
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                    startValue: 66,
                    endValue: 86,
                    color: const Color(0xFFFEE114),
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                    startValue: 88,
                    endValue: 108,
                    color: const Color(0xFFFF8888),
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                    startValue: 110,
                    endValue: 130,
                    color: const Color(0xFFFF5656),
                    startWidth: 20,
                    endWidth: 20,
                    // label: 'Very High',
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: _getNeedleValue(),
                    knobStyle: const KnobStyle(
                      knobRadius: 0.1,
                      borderColor: Colors.white,
                      borderWidth: 0.02,
                    ),
                    needleEndWidth: 9,
                    needleStartWidth: 0,
                    needleLength: 0.8,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'Low',
                    value: 10,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'Low Moderate',
                    value: 30,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'Moderate',
                    value: 52,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'Moderately High',
                    value: 76,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'High',
                    value: 98,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                  const MarkerPointer(
                    markerType: MarkerType.text,
                    text: 'Very High',
                    value: 120,
                    textStyle: GaugeTextStyle(fontSize: 11),
                    offsetUnit: GaugeSizeUnit.factor,
                    markerOffset: -0.12,
                  ),
                ],
              ),
            ],
          ),
          const Gap(4),
          Center(
            child: Chip(
              label: Text(
                _getRiskLevel(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              backgroundColor: _getRiskColor(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRiskLevel() {
    if (equityPercentage >= 0 && equityPercentage <= 10) {
      return 'Low';
    } else if (equityPercentage >= 11 && equityPercentage <= 30) {
      return 'Low Moderate';
    } else if (equityPercentage >= 31 && equityPercentage <= 50) {
      return 'Moderate';
    } else if (equityPercentage >= 51 && equityPercentage <= 70) {
      return 'Moderately High';
    } else if (equityPercentage >= 71 && equityPercentage <= 90) {
      return 'High';
    } else if (equityPercentage >= 91 && equityPercentage <= 100) {
      return 'Very High';
    } else {
      return '';
    }
  }

  Color _getRiskColor() {
    if (equityPercentage >= 0 && equityPercentage <= 10) {
      return const Color(0xFF30AD43);
    } else if (equityPercentage >= 11 && equityPercentage <= 30) {
      return const Color(0xFF84BD32);
    } else if (equityPercentage >= 31 && equityPercentage <= 50) {
      return const Color(0xFFD1D80F);
    } else if (equityPercentage >= 51 && equityPercentage <= 70) {
      return const Color(0xFFFEE114);
    } else if (equityPercentage >= 71 && equityPercentage <= 90) {
      return const Color(0xFFFF8888);
    } else if (equityPercentage >= 91 && equityPercentage <= 100) {
      return const Color(0xFFFF5656);
    } else {
      return Colors.white;
    }
  }

  double _getNeedleValue() {
    if (equityPercentage >= 0 && equityPercentage <= 10) {
      return 10;
    } else if (equityPercentage >= 11 && equityPercentage <= 30) {
      return 30;
    } else if (equityPercentage >= 31 && equityPercentage <= 50) {
      return 52;
    } else if (equityPercentage >= 51 && equityPercentage <= 70) {
      return 76;
    } else if (equityPercentage >= 71 && equityPercentage <= 90) {
      return 98;
    } else if (equityPercentage >= 91 && equityPercentage <= 100) {
      return 120;
    } else {
      return 0;
    }
  }
}
