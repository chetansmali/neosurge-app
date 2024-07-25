import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'my_portfolio_imported_tabview.dart';

import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../theme/app_colors.dart';
import 'my_portfolio_assisted_tabview.dart';
import 'my_portfolio_diy_tabview.dart';

class MyPortfolioMFTabView extends HookWidget {
  const MyPortfolioMFTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final tabController = useTabController(
        initialLength:
            context.read<AuthCubit>().state.user!.assistedServiceUserDetails !=
                    null
                ? 3
                : 2,
        initialIndex:
            context.read<NavCubit>().state.navTabEntity.portfolioMFTabIndex);
    useEffect(
      () {
        tabController.addListener(() {
          context.read<NavCubit>().changeTab(context
              .read<NavCubit>()
              .state
              .navTabEntity
              .copyWith(portfolioMFTabIndex: tabController.index));
        });
        return () {
          tabController.removeListener(() {});
        };
      },
      const [],
    );
    final user = context.watch<AuthCubit>().state.user!;
    if (!user.isOnBoardingCompleted) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.svgs.kycUnderProcess.svg(height: 200),
            const Gap(20),
            const Text(
              'Your KYC is under review. Once it is approved, you will be able to see your portfolio.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.mainBlack,
              ),
            ),
          ],
        ),
      );
    }
    //If user has never opted for assisted service then the assistedServiceDetails will be null and we will
    //only show the DIY tab.
    return
        // user.assistedServiceUserDetails != null
        //     ?
        BlocListener<NavCubit, NavState>(
      listenWhen: (previous, current) =>
          previous.navTabEntity.portfolioMFTabIndex !=
          current.navTabEntity.portfolioMFTabIndex,
      listener: (context, state) {
        tabController.animateTo(state.navTabEntity.portfolioMFTabIndex);
      },
      child: Column(
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xFFEAEAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TabBar(
              controller: tabController,
              indicator: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelColor: Colors.white,
              tabs: [
                const Tab(
                  child: Text(
                    'Do It Yourself',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (user.assistedServiceUserDetails != null)
                  const Tab(
                    iconMargin: EdgeInsets.zero,
                    child: Text(
                      'Assisted Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const Tab(
                  child: FittedBox(
                    child: Text(
                      'Consolidated',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                const MyPortfolioDiyTabView(),
                if (user.assistedServiceUserDetails != null)
                  const MyPortfolioAssistedTabView(),
                const MyPortfolioImportedTabView(),
              ],
            ),
          ),
        ],
      ),
    );
    // : const MyPortfolioDiyTabView();
  }
}
