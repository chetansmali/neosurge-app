import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/widgets.dart';

class DGPortfolioExpandedTile extends StatefulWidget {
  const DGPortfolioExpandedTile({
    super.key,
    required this.metalType,
    required this.amount,
    required this.investedVal,
  });

  final MetalType metalType;
  final double amount, investedVal;

  @override
  State<DGPortfolioExpandedTile> createState() =>
      _DGPortfolioExpandedTileState();
}

class _DGPortfolioExpandedTileState extends State<DGPortfolioExpandedTile>
    with TickerProviderStateMixin {
  bool _opened = true;
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
    return BlocBuilder<GoldSilverRatesCubit, GoldSilverRatesState>(
      builder: (context, state) {
        if (state is GoldSilverRatesLoaded) {
          return Stack(
            children: [
              SizeTransition(
                sizeFactor: _showDetails,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutral[50],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Gap(60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Current',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.neutral[600]),
                              ),
                              const Gap(4),
                              AmountWidget(
                                amount: widget.amount != 0
                                    ? widget.amount *
                                        (widget.metalType == MetalType.gold
                                            ? state.goldSilverRates.goldSellRate
                                            : state
                                                .goldSilverRates.silverSellRate)
                                    : 0,
                                style: baseTextStyle14500.copyWith(
                                    color: AppColors.primary[900]),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Invested',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.neutral[600]),
                              ),
                              const Gap(4),
                              AmountWidget(
                                amount: widget.investedVal != 0
                                    ? widget.investedVal
                                    : 0,
                                style: baseTextStyle14500.copyWith(
                                  color: AppColors.primary[900],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Returns',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.neutral[600]),
                              ),
                              const Gap(4),
                              _ReturnTextCalculator(
                                metal: widget.metalType,
                                goldRate: state.goldSilverRates.goldSellRate,
                                silverRate:
                                    state.goldSilverRates.silverSellRate,
                                amount: widget.amount,
                                invested: widget.investedVal,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Row(
                    children: [
                      widget.metalType == MetalType.gold
                          ? Assets.pngs.goldBrick.image()
                          : Assets.pngs.silverBrick.image(),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          'Digital ${widget.metalType}',
                          style: baseTextStyle14500.copyWith(
                              color: AppColors.neutral[500]),
                        ),
                      ),
                      GradientText(
                        '${widget.amount} gm',
                        gradient: widget.metalType == MetalType.gold
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFFFFD21F),
                                  Color(0xFFFBB217),
                                  Color(0xFFFDE74A),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  Color(0xFF326CF9),
                                  Color(0xFF699CFC),
                                  Color(0xFF9FCBFF),
                                ],
                              ),
                      ),
                      const Gap(8),
                      RotationTransition(
                        turns: _openClose,
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(
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
            child: const CustomLoader(),
          );
        }
      },
    );
  }
}

class _ReturnTextCalculator extends StatelessWidget {
  const _ReturnTextCalculator({
    required this.metal,
    required this.goldRate,
    required this.silverRate,
    required this.amount,
    required this.invested,
  });
  final MetalType metal;
  final double goldRate, silverRate, amount, invested;

  @override
  Widget build(BuildContext context) {
    final double current =
        (metal == MetalType.gold ? goldRate : silverRate) * amount;
    if (invested == 0) {
      return Text('-',
          style: baseTextStyle14500.copyWith(color: AppColors.primary[900]));
    }
    if (invested > current) {
      final double perc = ((invested - current) / current) * 100.0;
      return Text(
          '-${(invested - current).toStringAsFixed(2)} (${perc.toStringAsFixed(2)}%)',
          style: baseTextStyle14500.copyWith(color: AppColors.error[500]));
    } else {
      final double perc = ((current - invested) / invested) * 100.0;
      return Text(
          '${(current - invested).toStringAsFixed(2)} (${perc.toStringAsFixed(2)}%)',
          style: baseTextStyle14500.copyWith(color: AppColors.success[500]));
    }
  }
}
