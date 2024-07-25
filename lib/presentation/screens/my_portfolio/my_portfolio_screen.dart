import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../data/models/user/user.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import 'my_portfolio_digital_gold_tabview.dart';
import 'my_portfolio_mf_tabview.dart';
import 'my_portfolio_neobasket.dart';

class MyPortfolioScreen extends HookWidget {
  const MyPortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    if (!(user.isOnBoardingCompleted || user.eSignSubmitDone)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.kycPending.svg(height: 180),
          const Gap(30),
          const Text('Please complete your KYC to access your portfolio'),
        ],
      );
    }
    final tabController = useTabController(
        initialLength: 3,
        initialIndex:
            context.read<NavCubit>().state.navTabEntity.portfolioTabIndex);

    useEffect(() {
      tabController.addListener(() {
        context.read<NavCubit>().changeTab(context
            .read<NavCubit>()
            .state
            .navTabEntity
            .copyWith(portfolioTabIndex: tabController.index));
      });
      return () {
        tabController.removeListener(() {});
      };
    }, const []);

    return BlocListener<NavCubit, NavState>(
        listenWhen: (previous, current) =>
            previous.navTabEntity.portfolioTabIndex !=
            current.navTabEntity.portfolioTabIndex,
        listener: (context, state) {
          tabController.animateTo(state.navTabEntity.portfolioTabIndex);
        },
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'Mutual Fund',
                ),
                Tab(
                  text: 'Metals',
                ),
                Tab(
                  text: 'Neo Baskets',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  MyPortfolioMFTabView(),
                  MyPortfolioDigitalGoldTabView(),
                  MyPortFolioNeoBasket()
                ],
              ),
            ),
          ],
        ));
  }
}
