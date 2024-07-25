import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../dashboard/kyc_status_banner.dart';
import '../retirement_calculator/financial_details_screen.dart';

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const KycStatusBanner(),
            const Text(
              'Invest across',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Gap(20),
            _InvestTile(
              title: 'Equity',
              subtitle:
                  'Diversify your portfolio by investing in Equity stocks.',
              icon: Assets.pngs.investEquity.image(
                height: 56,
                width: 56,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.equity);
              },
            ),
            _InvestTile(
              title: 'Mutual Funds',
              subtitle:
                  'Diversify your portfolio by investing in mutual funds.',
              icon: Assets.pngs.investMutualFund.image(
                height: 56,
                width: 56,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.mutualFunds);
              },
            ),
            _InvestTile(
              title: 'Digital Gold',
              subtitle:
                  'Diversify your portfolio by investing in Digital Gold.',
              icon: Assets.pngs.investDigitalGold.image(
                height: 56,
                width: 56,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.digitalGold);
              },
            ),
            _InvestTile(
              title: 'Goal Planning',
              subtitle: 'Plan your future and grow your wealth ',
              icon: Assets.pngs.goalTargetDataAnalysis.image(
                height: 56,
                width: 56,
              ),
              onTap: () {
                if (context.read<AuthCubit>().state.user!.userGoalsPresent!) {
                  Navigator.pushNamed(context, Routes.goalPlanningReturnUser);
                } else {
                  Navigator.pushNamed(
                      context, Routes.goalPlanningOnboardScreen);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InvestTile extends StatelessWidget {
  const _InvestTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Image icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.08),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral[900],
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.neutral[200],
                    ),
                  )
                ],
              ),
            ),
            const Gap(8),
            CircleAvatar(
              radius: 12,
              foregroundColor: AppColors.primary[500],
              backgroundColor: AppColors.primary[100],
              child: const Icon(
                Icons.arrow_outward_rounded,
                size: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
