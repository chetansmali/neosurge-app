import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../data/models/user/user.dart';
import '../../../di/get_it.dart';
import '../../cubits/assisted_service/assisted_orders/assisted_orders_cubit.dart';
import '../../cubits/assisted_service/assited_holdings_cubit/assisted_holdings_cubit.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mutual_funds/mf_sort_by_switch/mf_sort_by_switch_cubit.dart';
import 'widgets/assisted_holdings_list.dart';
import 'widgets/assisted_pending_orders_list.dart';
import 'widgets/mf_portfolio_info_card.dart';

class MyPortfolioAssistedTabView extends HookWidget {
  const MyPortfolioAssistedTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthCubit>().state.user!;
    // useEffect(() {
    //   context
    //       .read<AssistedHoldingsCubit>()
    //       .getAssistedHoldings(userId: user.id);
    //   return () {};
    // }, const []);
    useAutomaticKeepAlive();
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait<void>([
          context
              .read<AssistedHoldingsCubit>()
              .refreshAssistedHoldings(userId: user.id),
          context.read<AssistedOrdersCubit>().refreshPendingOrders(
                userId: user.id,
              ),
        ]);
        return;
      },
      child: CustomScrollView(
        primary: true,
        slivers: [
          const MFPortfolioInfoCard(isAssisted: true),
          const AssistedPendingOrdersList(),
          const SliverToBoxAdapter(child: Gap(20)),
          BlocProvider(
            create: (context) => getIt<MfSortBySwitchCubit>(),
            child: const AssistedHoldingsList(),
          ),
        ],
      ),
    );
  }
}
