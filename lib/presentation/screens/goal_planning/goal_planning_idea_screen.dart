import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../common/custom_styles.dart';
import '../../../domain/entities/nav_tab_entity.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_container.dart';

class GoalPlanningIdeaScreean extends StatelessWidget {
  const GoalPlanningIdeaScreean({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> iconList = [
      _GoalIdeaCard(
        icon: Assets.pngs.goalEmptyBasket.image(height: 58, width: 58),
        title: 'Invest and reach your goal with our mutual fund baskets',
        onTap: () {
          context.read<NavCubit>().changeTab(
                const NavTabEntity(
                  mainTabIndex: 3,
                  mutualFundTabIndex: 0,
                ),
              );

          Navigator.pushNamed(
            context,
            Routes.mutualFunds,
          );
        },
      ),
      _GoalIdeaCard(
        icon: Assets.pngs.goalBars.image(height: 58, width: 40),
        title: 'Invest in top growing stocks and grow your wealth',
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.equity,
          );
        },
      ),
    ];
    return Column(
      children: [
        const Gap(32),
        Text(
          'Goal Planning ideas',
          style: baseTextStyle14500,
        ),
        const Gap(16),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 0.82,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            return iconList[index];
          },
        ),
        const Gap(30),
      ],
    );
  }
}

class _GoalIdeaCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const _GoalIdeaCard(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomContainer(
        radius: 16,
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            icon,
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: baseTextStyle10400.copyWith(color: AppColors.textGrey),
              ),
            ),
            const Gap(4),
            Divider(
              thickness: 1,
              color: AppColors.errorRed.withOpacity(0.1),
            ),
            const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View solution',
                  style: baseTextStyle12500.copyWith(
                      color: AppColors.secondaryVioletHover),
                ),
                const Gap(5),
                Assets.svgs.roundArrowRightUp.svg(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
