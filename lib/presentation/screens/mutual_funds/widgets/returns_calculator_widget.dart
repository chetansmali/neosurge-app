import 'dart:developer';
import 'dart:math' as math;

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/enums.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';

class ReturnsCalculatorWidget extends StatefulWidget {
  final Fund fund;

  const ReturnsCalculatorWidget({Key? key, required this.fund})
      : super(key: key);

  @override
  State<ReturnsCalculatorWidget> createState() =>
      _ReturnsCalculatorWidgetState();
}

class _ReturnsCalculatorWidgetState extends State<ReturnsCalculatorWidget>
    with SingleTickerProviderStateMixin {
  InvestmentType _investmentType = InvestmentType.monthlySip;

  TextEditingController investmentAmountController = TextEditingController(
    text: '5000',
  );

  TextEditingController yearSelectionController = TextEditingController(
    text: '5',
  );

  late final TabController _tabController;

  double totalReturns = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Returns Calculator',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.neutral[400],
        ),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppColors.primary[500],
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primary[500]!,
              width: 4,
            ),
          ),
          onTap: (value) {
            _investmentType =
                value == 0 ? InvestmentType.monthlySip : InvestmentType.lumpsum;
          },
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Monthly SIP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lumpsum',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const Gap(30),
        Row(
          children: [
            Expanded(
              child: _investmentType == InvestmentType.lumpsum
                  ? FlutterSlider(
                      values: [double.parse(investmentAmountController.text)],
                      min: widget.fund.minInitialInvestment,
                      max: 1000000,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          investmentAmountController.text =
                              lowerValue.toString();
                        });
                      },
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.primary[50]!,
                        ),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.primary[50]!,
                        ),
                        activeTrackBarHeight: 4,
                        inactiveTrackBarHeight: 4,
                      ),
                      step: FlutterSliderStep(
                          step: widget.fund.minInitialInvestment),
                      tooltip: FlutterSliderTooltip(
                        textStyle: const TextStyle(
                          fontSize: 0,
                        ),
                        boxStyle: const FlutterSliderTooltipBox(
                          decoration: null,
                        ),
                      ),
                      handlerWidth: 20,
                      handlerHeight: 20,
                      handler: FlutterSliderHandler(
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary[500],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary[300]!,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : FlutterSlider(
                      values: [double.parse(investmentAmountController.text)],
                      min: widget.fund.minSipAmount,
                      max: 50000,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          investmentAmountController.text =
                              lowerValue.toString();
                        });
                      },
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.primary[50]!,
                        ),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.primary[50]!,
                        ),
                        activeTrackBarHeight: 4,
                        inactiveTrackBarHeight: 4,
                      ),
                      step: FlutterSliderStep(step: widget.fund.minSipAmount),
                      tooltip: FlutterSliderTooltip(
                        textStyle: const TextStyle(fontSize: 0),
                        boxStyle: const FlutterSliderTooltipBox(
                          decoration: null,
                        ),
                      ),
                      handlerWidth: 20,
                      handlerHeight: 20,
                      handler: FlutterSliderHandler(
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary[500],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary[300]!,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
            ),
            const Gap(40),
            Expanded(
              child: TextFormField(
                controller: investmentAmountController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                readOnly: true,
                decoration: InputDecoration(
                  prefixText: '\u20B9 ',
                  prefixStyle: GoogleFonts.hind(
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.primary[500]!,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.primary[500]!,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For how many years?',
                    style: TextStyle(
                      color: AppColors.neutral[400]!,
                      fontSize: 12,
                    ),
                  ),
                  FlutterSlider(
                    values: [
                      double.parse(yearSelectionController.text),
                    ],
                    min: 1,
                    max: 50,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        yearSelectionController.text =
                            double.parse(lowerValue.toString())
                                .toInt()
                                .toString();
                      });
                    },
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: AppColors.primary[50]!,
                      ),
                      inactiveTrackBar: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: AppColors.primary[50]!,
                      ),
                      activeTrackBarHeight: 4,
                      inactiveTrackBarHeight: 4,
                    ),
                    step: const FlutterSliderStep(step: 1),
                    tooltip: FlutterSliderTooltip(
                      textStyle: const TextStyle(
                        fontSize: 0,
                      ),
                      boxStyle: const FlutterSliderTooltipBox(
                        decoration: null,
                      ),
                    ),
                    handlerWidth: 20,
                    handlerHeight: 20,
                    handler: FlutterSliderHandler(
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary[500],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary[300]!,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(40),
            Expanded(
              child: TextFormField(
                controller: yearSelectionController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                readOnly: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.primary[500]!,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.primary[500]!,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        Container(
          width: double.maxFinite,
          height: 1,
          decoration: const BoxDecoration(
            color: Color(0xFFDDDDDD),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: Colors.white,
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Total investment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const Gap(8),
                AmountWidget(
                  amount: _getTotalInvestment(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
            Container(
              color: AppColors.neutral[100],
              height: 30,
              width: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'After ${yearSelectionController.text} Years',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const Gap(8),
                AmountWidget(
                  amount: _getFutureValue(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: AppColors.success[500]!,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(10)
      ],
    );
  }

  double _getTotalInvestment() {
    if (_investmentType == InvestmentType.lumpsum) {
      return double.parse(investmentAmountController.text);
    } else {
      return double.parse(investmentAmountController.text) *
          (double.parse(yearSelectionController.text) * 12);
    }
  }

  double _getFutureValue() {
    late final double totalValue;

    if (_getReturns() != 0.0) {
      // FV = PV(1+r)^n
      if (_investmentType == InvestmentType.lumpsum) {
        final pv = double.parse(investmentAmountController.text);
        final r = _getReturns() / 100;
        final n = int.parse(yearSelectionController.text);
        totalValue = pv * math.pow(1 + r, n);

        ///Print Return Percentage
        log(_getReturns().toString());
        log(((totalValue - pv) * 100 / pv).toString());
      } else {
        // FV = P [ (1+i)^n-1 ] * (1+i)/i
        final p = double.parse(investmentAmountController.text);
        final i = _getReturns() / 100 / 12;
        final n = int.parse(yearSelectionController.text) * 12;
        totalValue = p * ((math.pow(1 + i, n) - 1) * (1 + i) / i);
      }
    } else {
      totalValue = 0.0;
    }

    return totalValue;
  }

  double _getReturns() {
    return widget.fund.performance.threeY != 0.0
        ? widget.fund.performance.threeY
        : widget.fund.performance.oneY;
  }
}
