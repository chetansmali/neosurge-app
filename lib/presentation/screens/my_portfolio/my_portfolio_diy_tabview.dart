import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../di/get_it.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mutual_funds/mf_orders/mf_orders_cubit.dart';
import '../../cubits/mutual_funds/mf_sort_by_switch/mf_sort_by_switch_cubit.dart';
import '../../cubits/mutual_funds/mf_user_holdings/mf_user_holdings_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import 'widgets/mf_portfolio_info_card.dart';
import 'widgets/my_mutual_funds_list.dart';
import 'widgets/pending_orders_list.dart';

class MyPortfolioDiyTabView extends HookWidget {
  const MyPortfolioDiyTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait<void>([
          context.read<MfUserHoldingsCubit>().refreshUserHoldings(
              userId: context.read<AuthCubit>().state.user!.id),
          context.read<MfOrdersCubit>().refreshPendingOrders(
                userId: context.read<AuthCubit>().state.user!.id,
              ),
        ]);
        return;
      },
      child: CustomScrollView(
        primary: true,
        slivers: [
          const MFPortfolioInfoCard(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.finacialYearReportScreen);
                      },
                      child: Text(
                        'Capital Gains Report',
                        style: baseTextStyle10400.copyWith(
                            color: AppColors.primaryColor),
                      )),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  enableFeedback: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textColor: AppColors.mainBlack,
                  iconColor: AppColors.mainBlack,
                  dense: true,
                  leading: const Icon(Icons.calendar_month_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                  title: const Text('My Systematic Plans'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.mySystematicPlans),
                ),
              ),
            ),
          ),
          const PendingOrdersList(),
          const SliverToBoxAdapter(child: Gap(20)),
          BlocProvider(
            create: (context) => getIt<MfSortBySwitchCubit>(),
            child: const MyMutualFundsList(),
          ),
        ],
      ),
    );
  }
}
