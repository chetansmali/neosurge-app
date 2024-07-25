import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../common/common.dart';
import '../../../common/custom_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/goal_planning/create_goal_investements_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';

class InvestGoalsCardsScreens extends StatelessWidget {
  const InvestGoalsCardsScreens({
    super.key,
    required this.icon,
    required this.id,
    required this.paymentid,
    required this.title,
    required this.subtitle,
    required this.goalCompleted,
    required this.persentageValue,
    required this.onClick,
  });
  final String? icon;
  final String title;
  final int id;
  final int paymentid;
  final double subtitle;
  final double persentageValue;
  final bool goalCompleted;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: BlocConsumer<CreateGoalInvestementsCubit,
            CreateGoalInvestementsState>(
          listener: (context, state) {
            if (state is CreateGoalInvestementsSuccess) {
              Utils.showSuccessSnackbar(
                  context: context,
                  message: state.createGoalInvestmentModel.message);
            }
          },
          builder: (BuildContext context, CreateGoalInvestementsState state) {
            return state is CreateGoalInvestementsLoading && state.goalID == id
                ? const Center(
                    child: CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.primaryColor,
                        strokeWidth: 2),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              goalCompleted
                                  ? Assets.gifs.goalAchievement
                                      .image(height: 52, width: 52)
                                  : Center(
                                      child: icon != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: icon!,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Text(
                                                  title.substring(0, 1),
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Text(title.substring(0, 2)),
                                    ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: baseTextStyle14500,
                                  ),
                                  goalCompleted
                                      ? Text(
                                          'Your goal amount has been reached',
                                          style: baseTextStyle12400,
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              'Saved  ',
                                              style:
                                                  baseTextStyle12400.copyWith(
                                                      color:
                                                          AppColors.mainBlack),
                                            ),
                                            AmountWidget(
                                                amount: subtitle,
                                                isCompact: false,
                                                isDecimal: false,
                                                style:
                                                    baseTextStyle12400.copyWith(
                                                        color: subtitle <= 0
                                                            ? AppColors.errorRed
                                                            : AppColors
                                                                .mainBlack)),
                                          ],
                                        ),
                                ],
                              )
                            ],
                          ),
                          goalCompleted
                              ? const Gap(0)
                              : CircularPercentIndicator(
                                  startAngle: 180,
                                  arcType: ArcType.HALF,
                                  arcBackgroundColor: persentageValue <= 0
                                      ? AppColors.errorRed.withOpacity(0.1)
                                      : AppColors.textGrey.withOpacity(0.1),
                                  radius: 32,
                                  percent: persentageValue / 100,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  animationDuration: 1000,
                                  lineWidth: 5,
                                  center: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(persentageValue.toString(),
                                        style: baseTextStyle12400.copyWith(
                                            color: persentageValue <= 0
                                                ? AppColors.errorRed
                                                : AppColors.mainBlack)),
                                  ),
                                  progressColor: AppColors.green,
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                        ],
                      ),
                      subtitle <= 0
                          ? const Gap(0)
                          : Text(
                              'Plan your first investment now ',
                              style: baseTextStyle12400.copyWith(
                                  color: AppColors.primaryColor),
                            )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
