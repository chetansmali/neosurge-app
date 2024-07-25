import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import '../../../common/debouncer.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../../cubits/mutual_funds/search_funds/search_fund_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';

import '../../../di/get_it.dart';
import '../../cubits/mutual_funds/all_funds/all_funds_cubit.dart';
import '../../cubits/mutual_funds/returns_switch/mf_returns_switch_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../widgets/custom_search_delegate.dart';
import 'assisted_service_tabview.dart';
import 'do_it_yourself_tabview.dart';
import 'neo_baskets_tab.dart';

class MFDashboardScreen extends HookWidget {
  const MFDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(
      initialLength: 3,
      initialIndex:
          context.read<NavCubit>().state.navTabEntity.mutualFundTabIndex,
    );
    useEffect(() {
      tabController.addListener(() {
        FocusScope.of(context).unfocus();

        context.read<NavCubit>().changeTab(
              context
                  .read<NavCubit>()
                  .state
                  .navTabEntity
                  .copyWith(mutualFundTabIndex: tabController.index),
            );
      });
      return () {
        tabController.removeListener(() {});
      };
    }, const []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Funds'),
        actions: [
          GestureDetector(
            child: Assets.icons.magniferHome.svg(),
            onTap: () async {
              final searchFundCubit = getIt<SearchFundCubit>();
              final debouncer = Debouncer(milliseconds: 300);
              await showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    debouncer: debouncer, searchFundCubit: searchFundCubit),
              );
              searchFundCubit.close();
              debouncer.close();
            },
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.mutualFundsCart,
              );
            },
            child: const Icon(
              CupertinoIcons.cart,
            ),
          ),
          const Gap(20),
        ],
      ),
      body: BlocListener<NavCubit, NavState>(
        listenWhen: (previous, current) =>
            previous.navTabEntity.mutualFundTabIndex !=
            current.navTabEntity.mutualFundTabIndex,
        listener: (context, state) {
          tabController.animateTo(
            state.navTabEntity.mutualFundTabIndex,
          );
        },
        child: Column(
          children: [
            BlocConsumer<ImportHoldingDataCubit, ImportHoldingDataState>(
              listener: (BuildContext context, state) {
                log('AccountDetailsCubit state: $state');
              },
              builder: (context, state) {
                final user = context.watch<AuthCubit>().state.user!;
                return Visibility(
                  visible: state is ImportHoldingDataLoadError &&
                      user.isOnBoardingCompleted &&
                      user.eSignSubmitDone,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: OutlinedButton(
                      onPressed: () async {
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
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: const Text('Import External Mutual Funds'),
                    ),
                  ),
                );
              },
            ),
            TabBar(
              controller: tabController,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.secondaryViolet,
                  width: 4.0,
                ),
              ),
              tabs: const [
                Tab(
                  child: Text(
                    'NeoBaskets',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'DIY',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Assisted',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  const NeoBasketsTabView(),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt<MfReturnsSwitchCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<AllFundsCubit>()..getFunds(),
                      ),
                    ],
                    child: const DoItYourSelfTabView(),
                  ),
                  const AssistedServiceTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
