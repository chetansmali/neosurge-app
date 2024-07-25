import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/common.dart';
import '../../../data/models/user/user.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'gold_tabview.dart';
import 'silver_tabview.dart';
import 'widgets/dg_disclaimer_sheet.dart';

class DigitalGoldDashboardScreen extends StatefulWidget {
  const DigitalGoldDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DigitalGoldDashboardScreen> createState() =>
      _DigitalGoldDashboardScreenState();
}

class _DigitalGoldDashboardScreenState
    extends State<DigitalGoldDashboardScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<GoldUserCubit>().state is GoldUserInitial) {
      context.read<GoldUserCubit>().loadGoldUser();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User user = context.read<AuthCubit>().state.user!;
      if (user.showGoldDisclaimer) {
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          enableDrag: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (context) => const DgDisclaimerSheet(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthCubit>().state.user!;
    bool onBoardingCompleted = user.isOnBoardingCompleted;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Precious Metals'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: onBoardingCompleted
            ? BlocBuilder<GoldUserCubit, GoldUserState>(
                builder: (context, state) {
                  if (state is GoldUserLoading) {
                    return const Center(child: CustomLoader());
                  }
                  if (state is GoldUserLoaded) {
                    return const _DigitalGoldDashboard();
                  }
                  if (state is GoldUserLoadError) {
                    return Center(
                        child: AppErrorWidget(
                      errorType: state.errorType,
                      error: state.errorMessage,
                      onRetry: () =>
                          context.read<GoldUserCubit>().loadGoldUser(),
                    ));
                  }
                  return const SizedBox.shrink();
                },
              )
            : const _DigitalGoldDashboard(),
      ),
    );
  }
}

class _DigitalGoldDashboard extends HookWidget {
  const _DigitalGoldDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int digitalGoldIndex = context.select<NavCubit, int>(
        (NavCubit navCubit) => navCubit.state.navTabEntity.digitalGoldTabIndex);
    final tabController =
        useTabController(initialLength: 2, initialIndex: digitalGoldIndex);
    useEffect(() {
      tabController.addListener(() {
        context.read<NavCubit>().changeTab(context
            .read<NavCubit>()
            .state
            .navTabEntity
            .copyWith(digitalGoldTabIndex: tabController.index));
      });
      return () {
        tabController.removeListener(() {});
      };
    }, const []);
    return BlocListener<NavCubit, NavState>(
      listenWhen: (previous, current) =>
          previous.navTabEntity.digitalGoldTabIndex !=
          current.navTabEntity.digitalGoldTabIndex,
      listener: (context, state) {
        tabController.animateTo(state.navTabEntity.digitalGoldTabIndex);
      },
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.neutral[900],
            labelStyle: baseTextStyle14500,
            unselectedLabelColor: AppColors.neutral[400],
            unselectedLabelStyle: baseTextStyle14400,
            controller: tabController,
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 4.0,
            dividerHeight: 0.0,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Gold'),
              Tab(text: 'Silver'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                GoldTabview(),
                SilverTabview(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
