import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_container.dart';
import 'custom_goal_bottom_sheet.dart';

class GoalChoiceCard extends StatelessWidget {
  const GoalChoiceCard({
    super.key,
    required this.title,
    required this.goalType,
    required this.icon,
    this.customIcon,
  });
  final String title;
  final String goalType;
  final String? icon;
  final bool? customIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          if (title == GoalType.Custom.name) {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext _) {
                return CustomGoalBottomSheet(
                  goalType: goalType,
                );
              },
            );
          } else {
            if (title == GoalType.Retirement.name) {
              Navigator.pushNamed(context, Routes.financialDetailsScreens);
            } else {
              Navigator.pushNamed(
                context,
                Routes.goalSettingScreen,
                arguments: GoalSettingArgs(goalName: title, goalType: goalType),
              );
            }
          }
        },
        splashColor: Colors.transparent,
        child: CustomContainer(
            radius: 10,
            child: Row(
              children: [
                Center(
                  child: icon != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: icon!,
                            fit: BoxFit.cover,
                            height: 48,
                            width: 48,
                            errorWidget: (context, url, error) => Text(
                              title.substring(0, 1),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Text(title.substring(0, 2)),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    title,
                    style:
                        baseTextStyle14400.copyWith(color: AppColors.textGrey),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
