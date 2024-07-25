import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../../../cubits/util_cubits/nav_cubit.dart';
import '../../../routes/routes.dart';
import 'actionable_item.dart';

class Actionables extends StatelessWidget {
  const Actionables({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AuthCubit bloc) => bloc.state.user!,
    );

    final isImportFundVisible = context.read<ImportHoldingDataCubit>().state
            is ImportHoldingDataLoadError &&
        user.isOnBoardingCompleted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!user.isOnBoardingCompleted || isImportFundVisible) ...[
          const Gap(32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Actionables',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(24),
        ],
        if (!user.isOnBoardingCompleted) ...[
          ActionableItem(
            leading: Assets.pngs.homeInvestmentReady.image(),
            title: 'Get Investment Ready!',
            description:
                'Start investing by completing your onboarding in just a few steps.',
            onTap: () {
              context.read<NavCubit>().changeTab(
                    context.read<NavCubit>().state.navTabEntity.copyWith(
                          mainTabIndex: 3,
                          mutualFundTabIndex: 1,
                        ),
                  );

              Navigator.pushNamed(
                context,
                Routes.mutualFunds,
              );
            },
            isOutlined: true,
          ),
          const Gap(20),
        ],
        if (isImportFundVisible) ...[
          ActionableItem(
            leading: Assets.pngs.homeImportFund.image(),
            title: 'Import External Investments',
            description:
                'Import all your external mutual fund investments and track them here.',
            onTap: () async {
              await Navigator.of(context).pushNamed(
                Routes.importExternalFundsPan,
              );

              if (!context.mounted) {
                return;
              }
              await context
                  .read<ImportHoldingDataCubit>()
                  .getImportedHoldingData(
                    userId: context.read<AuthCubit>().state.user!.id,
                  );
            },
            isOutlined: true,
          ),
        ],
      ],
    );
  }
}
