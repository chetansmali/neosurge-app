import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../di/get_it.dart';
import '../../../domain/entities/params/mutual_funds/get_explore_diy_data_params.dart';
import '../../cubits/mutual_funds/explore_fund/explore_diy_data_cubit.dart';
import '../dashboard/kyc_status_banner.dart';
import 'explore_mutual_funds.dart';

class DoItYourSelfTabView extends HookWidget {
  const DoItYourSelfTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final scrollController = useScrollController();
    return Scrollbar(
      interactive: true,
      controller: scrollController,
      child: CustomScrollView(
        primary: false,
        controller: scrollController,
        slivers: [
          const SliverToBoxAdapter(child: KycStatusBanner()),
          // BlocProvider(
          //   create: (context) => getIt<FilterSortCubit>(),
          //   child: AllFundsListView(scrollController: scrollController),
          // ),

          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ExploreDIYDataCubit>()
                  ..getExploreDIYData(
                    params: GetExploreDIYDataParams(
                      assetcategory: 'Equity',
                    ),
                  ),
              ),
            ],
            child: const ExploreMutualFunds(),
          ),
        ],
      ),
    );
  }
}
