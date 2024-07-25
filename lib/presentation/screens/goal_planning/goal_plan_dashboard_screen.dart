import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../common/common.dart';
import '../../../domain/entities/nav_tab_entity.dart';
import '../../../domain/entities/params/goal_planning/get_goals_details_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/goal_planning/get_goal_details_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_container.dart';
import 'calculating_investment_screen.dart';
import 'goal_planning_idea_screen.dart';
import 'mutual_fund_goal_invested.dart';

class GoalPlanDashboardScreen extends StatefulWidget {
  final String goalName;
  final String id;
  const GoalPlanDashboardScreen(
      {super.key, required this.goalName, required this.id});

  @override
  State<GoalPlanDashboardScreen> createState() =>
      _GoalPlanDashboardScreenState();
}

class _GoalPlanDashboardScreenState extends State<GoalPlanDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const _AlertWidget();
            });
        return res ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.goalName,
            style: baseTextStyle14400,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<GetGoalDetailsCubit, GetGoalDetailsState>(
            builder: (context, state) {
              if (state is GetGoalDetailsLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is GetGoalDetailsFailure) {
                return AppErrorWidget(
                  errorType: state.errorType,
                  error: state.errorMessage,
                  onRetry: () =>
                      context.read<GetGoalDetailsCubit>().fetchGoalDetails(
                            GetGoalsDetailsParams(id: widget.id),
                          ),
                );
              }
              if (state is GetGoalDetailsLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      radius: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    AmountWidget(
                                        amount: state.getGoalDetailsModel
                                                .currentGoalValue ??
                                            0,
                                        style: baseTextStyle21500.copyWith(
                                            color: state.getGoalDetailsModel
                                                        .currentGoalValue ==
                                                    null
                                                ? AppColors.errorRed
                                                : AppColors.mainBlack)),
                                    Text(
                                      'Current Value',
                                      style: baseTextStyle12400.copyWith(
                                          color: AppColors.textGrey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    AmountWidget(
                                      amount: state.getGoalDetailsModel
                                              .targetGoalValue ??
                                          0,
                                      style: baseTextStyle21500,
                                    ),
                                    Text(
                                      'Goal Amount',
                                      style: baseTextStyle12400.copyWith(
                                          color: AppColors.textGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(26),
                            LinearPercentIndicator(
                              barRadius: const Radius.circular(10),
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              animation: true,
                              lineHeight: 33.0,
                              animationDuration: 1000,
                              percent: 1,
                              center: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Invested",
                                      style: baseTextStyle12400.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    AmountWidget(
                                      amount: state.getGoalDetailsModel
                                              .goalInvestedValue ??
                                          0,
                                      isCompact: false,
                                      isDecimal: false,
                                      style: baseTextStyle14500.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              progressColor: AppColors.green,
                            ),
                            const Gap(16),
                            state.getGoalDetailsModel.goalInvestedValue == null
                                ? Text(
                                    'Start your investment today to reach your goal sooner with less to invest.',
                                    textAlign: TextAlign.center,
                                    style: baseTextStyle12500.copyWith(
                                        color: AppColors.darkOrange),
                                  )
                                : state.getGoalDetailsModel.goalCompleted ??
                                        false
                                    ? Row(
                                        children: [
                                          Assets.gifs.goalAchievement
                                              .image(height: 52, width: 52),
                                          const Gap(10),
                                          Expanded(
                                            child: Text(
                                              'Wohoo! You have succesfully reached your goal',
                                              style:
                                                  baseTextStyle12500.copyWith(
                                                      color: AppColors
                                                          .textLightGrey),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Gap(4),
                          ],
                        ),
                      ),
                    ),
                    const Gap(24),
                    CalculatingInvestmentScreen(
                      goalAmount:
                          state.getGoalDetailsModel.targetGoalValue ?? 0,
                    ),
                    const GoalPlanningIdeaScreean(),
                    Text(
                      'Linked  Investments',
                      style: baseTextStyle14400,
                    ),
                    const Gap(16),
                    state.getGoalDetailsModel.linkedInvestments?.length == 0
                        ? Center(
                            child: Column(
                              children: [
                                Assets.svgs.noTransaction
                                    .svg(height: 150, width: 150),
                                const Gap(16),
                                Text(
                                  'Looks like you have no investments linked',
                                  style: baseTextStyle14400.copyWith(
                                      color: AppColors.textGrey),
                                ),
                                const Gap(40),
                              ],
                            ),
                          )
                        : MutaalFundGoalInvested(
                            linkedInvestments:
                                state.getGoalDetailsModel.linkedInvestments,
                          )
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _AlertWidget extends StatelessWidget {
  const _AlertWidget();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      icon: Assets.pngs.alertWarning.image(width: 75, height: 75),
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      title: Text(
        'Sure you want to cancel?',
        style: baseTextStyle14500.copyWith(color: AppColors.textLightGrey),
      ), //this right here
      actions: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<NavCubit>().changeTab(
                        const NavTabEntity(
                          mainTabIndex: 3,
                          mutualFundTabIndex: 1,
                        ),
                      );

                  Navigator.pushNamed(
                    context,
                    Routes.mutualFunds,
                  );
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(100, 40),
                  minimumSize: const Size(100, 40),
                ),
                child: Text(
                  'Invest',
                  style: baseTextStyle14400.copyWith(
                      color: AppColors.primaryWhite),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Cancel',
                    style: baseTextStyle12500.copyWith(
                        color: AppColors.primaryColor),
                  ))
            ],
          ),
        )
      ],
      actionsPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
    );
  }
}
