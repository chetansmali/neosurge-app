import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_passbook_params.dart';
import '../../cubits/retirement_calculator/retirement_passbook_cubit.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/custom_container.dart';
import 'widget/investment_options_card.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'widget/retirement_corpus_card.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_corpus_params.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_inflation_calculator_params.dart';
import '../../cubits/retirement_calculator/retirement_corpus_cubit.dart';
import '../../cubits/retirement_calculator/retirement_inflation_calculator_cubit.dart';
import '../../widgets/app_error_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../common/custom_styles.dart';
import '../../theme/app_colors.dart';

class PlanYourFutureScreen extends StatefulWidget {
  final int monthlyIncome;
  final int retirementAge;
  final int existingSavings;
  final int monthlyExpense;
  final String investmentStyle;
  final String postRetirementStyle;
  final String requestID;

  const PlanYourFutureScreen({
    super.key,
    required this.monthlyIncome,
    required this.retirementAge,
    required this.existingSavings,
    required this.monthlyExpense,
    required this.investmentStyle,
    required this.postRetirementStyle,
    required this.requestID,
  });

  @override
  State<PlanYourFutureScreen> createState() => _PlanYourFutureScreenState();
}

class _PlanYourFutureScreenState extends State<PlanYourFutureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plan your future',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final stateCorpus = context.watch<RetirementCorpusCubit>().state;

            final statepassBook =
                context.watch<RetirementPassbookCubit>().state;

            if (stateCorpus is RetirementCorpusLoading) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.waveDots(
                      color: Colors.blue,
                      size: 100,
                    ),
                    Text(
                      'Hang on. We are estimating your Retirement Corpus',
                      textAlign: TextAlign.center,
                      style: baseTextStyle16500.copyWith(
                          color: AppColors.textGrey),
                    )
                  ],
                ),
              );
            }
            if (stateCorpus is RetirementCorpusFailure) {
              return AppErrorWidget(
                errorType: stateCorpus.errorType,
                error: stateCorpus.errorMessage,
                onRetry: () => context.read<RetirementCorpusCubit>()
                  ..fetchRetirementCorpus(
                    RetirementCorpusParams(
                        monthlyIncome: widget.monthlyIncome,
                        retirementAge: widget.retirementAge,
                        existingSavings: widget.existingSavings,
                        investmentStyle: widget.investmentStyle,
                        monthlyExpense: widget.monthlyExpense,
                        postRetirementStyle: widget.postRetirementStyle),
                  ),
              );
            }
            if (stateCorpus is RetirementCorpusSuccess &&
                statepassBook is RetirementPassbookLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(5),
                      RetirementCorpusCard(
                        retirementCorpus:
                            stateCorpus.retirementCorpusModel.requiredCorpus ??
                                0,
                        monthlySavings:
                            stateCorpus.retirementCorpusModel.monthlySavings ??
                                0,
                        existingSavings: widget.existingSavings,
                        investmentStyle: widget.investmentStyle,
                        monthlyExpense: widget.monthlyExpense,
                        postRetirementStyle: widget.postRetirementStyle,
                        monthlyIncome: widget.monthlyIncome,
                        retirementAge: widget.retirementAge,
                        goalForTheYear:
                            stateCorpus.retirementCorpusModel.goalForTheYear ??
                                0,
                        requestID: widget.requestID,
                        epfTotalCorpus:
                            statepassBook.retirementPassbookModel.totalValue ??
                                0.0,
                        onClick: () {
                          context
                              .read<RetirementPassbookCubit>()
                              .fetchEPFReport(RetirementPassbookParams(
                                  requestId: widget.requestID,
                                  refreshNeeded: 'false'));
                        },
                      ),
                      const Gap(12),
                      _ExpensesGrowWidget(
                        monthlyExpense: widget.monthlyExpense,
                        retirementAge: widget.retirementAge,
                      ),
                      const Gap(16),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Investment options',
                          style: baseTextStyle16500,
                        ),
                      ),
                      const Gap(16),
                      const InvestmentOptionsCard(),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ExpensesGrowWidget extends StatefulWidget {
  const _ExpensesGrowWidget({
    required this.retirementAge,
    required this.monthlyExpense,
  });

  final int retirementAge;
  final int monthlyExpense;

  @override
  State<_ExpensesGrowWidget> createState() => _ExpensesGrowWidgetState();
}

class _ExpensesGrowWidgetState extends State<_ExpensesGrowWidget> {
  double _value = 6.0;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      radius: 30,
      child: Column(
        children: [
          Text(
            'See how your monthly expenses will grow',
            style: baseTextStyle12600,
          ),
          const Gap(20),
          LinearPercentIndicator(
            barRadius: const Radius.circular(10),
            width: 230,
            animation: true,
            lineHeight: 33.0,
            animationDuration: 1000,
            percent: 1,
            center: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today’s expense",
                    style: baseTextStyle14500.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  AmountWidget(
                    amount: widget.monthlyExpense.toDouble(),
                    style: baseTextStyle14500.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            progressColor: AppColors.green,
          ),
          const Gap(12),
          LinearPercentIndicator(
            barRadius: const Radius.circular(10),
            width: MediaQuery.of(context).size.width * 0.75,
            animation: true,
            lineHeight: 33.0,
            animationDuration: 1000,
            percent: 1,
            center: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expenses at ${widget.retirementAge}",
                    style: baseTextStyle14500.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  BlocBuilder<RetirementInflationCalculatorCubit,
                      RetirementInflationCalculatorState>(
                    builder: (context, state) {
                      if (state is RetirementInflationCalculatorSuccess) {
                        return AmountWidget(
                          amount: state.retirementInflationCalculatorModel
                                  .monthlyExpenseInNYears ??
                              0,
                          isCompact: false,
                          style: baseTextStyle14500.copyWith(
                            color: Colors.white,
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            progressColor: Colors.indigo.shade300,
          ),
          Row(
            children: [
              Text(
                'Inflation rate: ',
                style: baseTextStyle12400.copyWith(color: AppColors.textGrey),
              ),
              Expanded(
                child: SfSlider(
                  min: 4,
                  max: 8,
                  stepSize: 0.1,
                  showLabels: true,
                  thumbIcon: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Text(
                      '${_value.toInt()}%',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: AppColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  activeColor: AppColors.primaryColor.withOpacity(0.2),
                  inactiveColor: AppColors.primaryColor.withOpacity(0.2),
                  value: _value,
                  onChanged: (dynamic values) {
                    setState(() {
                      _value = values as double;
                    });
                  },
                  onChangeEnd: (dynamic values) {
                    context
                        .read<RetirementInflationCalculatorCubit>()
                        .fetchInflationCalculator(
                          RetirementInflationCalculatorParams(
                            currentExpense: widget.monthlyExpense,
                            retirementAge: widget.retirementAge,
                            inflation: _value.toInt(),
                          ),
                        );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
