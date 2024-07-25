import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/common.dart';
import '../../../../domain/entities/params/equity/equity_explore/index_price_params.dart';
import '../../../../domain/entities/params/equity/equity_nav_entity.dart';
import '../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../../domain/entities/params/equity/equity_portfolio/get_smallcase_funds.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/equity/equity_nav_cubit.dart';
import '../../../cubits/equity/equity_orders/equity_orders_cubit.dart';
import '../../../cubits/equity/equity_portfolio/portfolio_holdings_cubit.dart';
import '../../../cubits/equity/equity_portfolio/portfolio_positions_cubit.dart';
import '../../../cubits/equity/equity_portfolio/smallcase_funds_cubit.dart';
import '../../../cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart';
import '../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../cubits/equity/equity_watchlist/remove_symbol_watchlist_cubit.dart';
import '../../../cubits/equity/equity_watchlist/watchlist_symbol_cubit.dart';
import '../invest/explore/explore_screen.dart';
import '../invest/order/equity_order_tab_screen.dart';
import '../invest/portfolio/equity_portfolio_tab.dart';
import '../invest/watchlist/equity_watchlist_screen.dart';

import '../../../../di/get_it.dart';
import '../../../cubits/equity/equity_explore/all_stocks_cubit.dart';
import '../../../cubits/equity/equity_explore/index_price_banner_cubit.dart';

class EquityInvestScreens extends StatefulWidget {
  const EquityInvestScreens({super.key});

  @override
  State<EquityInvestScreens> createState() => _EquityInvestScreensState();
}

class _EquityInvestScreensState extends State<EquityInvestScreens>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Tab> tabs = [
    const Tab(text: 'Explore'),
    const Tab(text: 'Portfolio'),
    const Tab(text: 'Orders'),
    const Tab(text: 'Watchlist'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Equity',
            style: baseTextStyle16500,
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs,
            onTap: (index) {
              context.read<EquityNavCubit>().equityChangeTab(
                    EquityNavEntity(
                      mainTabIndex: index,
                    ),
                  );
            },
          ),
        ),
        body: BlocConsumer<EquityNavCubit, EquityNavState>(
          buildWhen: (previous, current) =>
              previous.equityNavEntity.mainTabIndex !=
              current.equityNavEntity.mainTabIndex,
          listenWhen: (previous, current) =>
              previous.equityNavEntity.mainTabIndex !=
              current.equityNavEntity.mainTabIndex,
          listener: (context, state) {
            _tabController.animateTo(
              state.equityNavEntity.mainTabIndex,
            );
          },
          builder: (context, state) => TabBarView(
            controller: _tabController,
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<AllStocksCubit>()
                      ..fetchStocks(
                        sortBy: 'market_capitalization',
                        direction: 'DESC',
                      ),
                  ),
                  BlocProvider(
                    create: (context) => getIt<IndexPriceBannerCubit>()
                      ..fetchIndexPrice(
                        IndexPriceParams(
                          [
                            "NSEI",
                            "CNX100",
                            "NSEBANK",
                            "CNXIT",
                            "CNXFMCG",
                            "CNXAUTO",
                            "CNX200"
                          ],
                        ),
                      ),
                  ),
                ],
                child: const ExploreScreen(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        getIt<PortfolioHoldingsCubit>()..fetchHoldings(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        getIt<PortfolioPositionsCubit>()..fetchPositions(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<SmallcaseFundsCubit>()
                      ..fetchSmallcasefunds(
                        GetFundasParams(
                          email: context.read<AuthCubit>().state.user!.emailId,
                        ),
                      ),
                  ),
                ],
                child: const EquityPortfolioTabScreen(),
              ),
              BlocProvider(
                create: (context) => getIt<EquityOrdersCubit>()
                  ..fetchOrders(
                    EquityOrdersParams(
                      email: context.read<AuthCubit>().state.user!.emailId,
                      timePeriod: 'ONE_MONTH',
                      status: '',
                    ),
                  ),
                child: const EquityOrderTabScreen(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        getIt<GetAllUserWatchlisCubit>()..fetchAllWatchlist(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<WatchlistSymbolCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<GetUserAlertsCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<RemoveSymbolWatchlistCubit>(),
                  )
                ],
                child: const WatchlistScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
