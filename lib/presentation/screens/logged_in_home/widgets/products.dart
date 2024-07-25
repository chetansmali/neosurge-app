import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:neosurge/presentation/screens/goal_planning/goal_success_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../../gen/assets.gen.dart';
import '../../goal_planning/goal_planning_onboard_screen.dart';
import 'actionable_item.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageList = [
      ActionableBanner(
        leading: Assets.pngs.equityProduct.image(width: 40, height: 40),
        title: 'Equity',
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.equity,
          );
        },
      ),
      ActionableBanner(
        leading: Assets.pngs.mutualFundsProduct.image(width: 40, height: 40),
        title: 'Mutual Funds',
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.mutualFunds,
          );
        },
      ),
      ActionableBanner(
        leading: Assets.pngs.digitalGoldProduct.image(width: 40, height: 40),
        title: 'Digital Gold',
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.digitalGold,
          );
        },
      ),
      ActionableBanner(
        leading:
            Assets.pngs.goalTargetDataAnalysis.image(width: 40, height: 40),
        title: 'Goal Planning',
        onTap: () {
          if (context.read<AuthCubit>().state.user!.userGoalsPresent!) {
            Navigator.pushNamed(context, Routes.goalPlanningReturnUser);
          } else {
            Navigator.pushNamed(context, Routes.goalPlanningOnboardScreen);
          }
        },
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1.1,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return imageList[index];
            },
          )
        ],
      ),
    );
  }
}
