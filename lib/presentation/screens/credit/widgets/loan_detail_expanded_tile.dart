import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';

class LoanDetailExpandedTile extends StatefulWidget {
  const LoanDetailExpandedTile({
    super.key,
    required this.tenure,
    required this.sanctionedAmt,
    required this.outstandingAmt,
    required this.emi,
    required this.interest,
  });
  final int tenure;
  final double sanctionedAmt, outstandingAmt, emi, interest;

  @override
  State<LoanDetailExpandedTile> createState() => _LoanDetailExpandedTileState();
}

class _LoanDetailExpandedTileState extends State<LoanDetailExpandedTile>
    with TickerProviderStateMixin {
  bool _opened = false;
  late Animation<double> _openClose;
  late Animation<double> _showDetails;
  late AnimationController _openClosecontroller;
  late AnimationController _showDetailscontroller;
  final Animatable<double> _curveAnimatable =
      CurveTween(curve: Curves.easeInOut);

  @override
  void initState() {
    _openClosecontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _openClose = _openClosecontroller.drive(
        Tween(begin: _opened ? 0.0 : 0.5, end: _opened ? 0.5 : 0.0)
            .chain(_curveAnimatable));
    _showDetailscontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _showDetails = _showDetailscontroller.drive(
        Tween(begin: _opened ? 1.0 : 0.0, end: _opened ? 0.0 : 1.0)
            .chain(_curveAnimatable));
    super.initState();
  }

  @override
  void dispose() {
    _openClosecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizeTransition(
          sizeFactor: _showDetails,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEAEAEB),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Gap(80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: widget.emi != 0
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'EMI',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[600]),
                        ),
                        const Gap(4),
                        if (widget.emi != 0)
                          AmountWidget(
                              amount: widget.emi,
                              style: baseTextStyle14500.copyWith(
                                  color: AppColors.primary[900]))
                        else
                          Text(
                            '-',
                            style: baseTextStyle14500.copyWith(
                                color: AppColors.primary[900]),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: widget.interest != 0
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Interest',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[600]),
                        ),
                        const Gap(4),
                        Text(
                          widget.interest != 0 ? '${widget.interest}%' : '-',
                          style: baseTextStyle14500.copyWith(
                              color: AppColors.primary[900]),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: widget.tenure == -1
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tenure',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[600]),
                        ),
                        const Gap(4),
                        Text(
                          widget.tenure == -1 ? '-' : '${widget.tenure} months',
                          style: baseTextStyle14500.copyWith(
                              color: AppColors.primary[900]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_opened) {
              _openClosecontroller.reverse();
              _showDetailscontroller.reverse();
            } else {
              _openClosecontroller.forward();
              _showDetailscontroller.forward();
            }
            setState(() => _opened = !_opened);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xffFFFFFF),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 8,
                    color: const Color(0xff000000).withOpacity(0.08))
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Loan Sanctioned',
                      style: baseTextStyle12400.copyWith(
                          color: const Color(0xff133C6B)),
                    ),
                    Text(
                      'Total Outstanding',
                      style: baseTextStyle12400.copyWith(
                          color: const Color(0xff133C6B)),
                    ),
                  ],
                ),
                const Gap(4),
                Row(
                  children: [
                    Expanded(
                      child: AmountWidget(
                        amount: widget.sanctionedAmt,
                        style: baseTextStyle21500.copyWith(
                            color: const Color(0xff11CE66)),
                      ),
                    ),
                    AmountWidget(
                      amount: widget.outstandingAmt,
                      style: baseTextStyle21500.copyWith(
                          color: const Color(0xffFF4949)),
                    ),
                    const Gap(20),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xff000000), width: 1),
                      ),
                      child: RotationTransition(
                        turns: _openClose,
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 18.0,
                          color: Color(0XFF000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
