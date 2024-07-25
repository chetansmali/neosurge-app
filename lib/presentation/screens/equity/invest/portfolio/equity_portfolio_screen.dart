import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import '../../../../../common/utils.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/params/equity/equity_portfolio/get_smallcase_funds.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_holdings_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_holdings_token_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_positions_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/smallcase_funds_cubit.dart';
import '../../../../widgets/empty_investment_card.dart';
import '../explore/explore_dialog_box.dart';
import 'etf/widgets/etf_folio_details_container.dart';
import 'portfolio_holdings_screen.dart';
import 'portfolio_positions_screen.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../theme/app_colors.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int listLength = 5;
  String funds = '-- --';

  bool isEquitySelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  Future<void> _fetchFunds(String id) async {
    String amount = await _getSmallcaseFunds(id);
    setState(() {
      funds = amount;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioHoldingsCubit, PortfolioHoldingsState>(
      builder: (context, state) {
        if (state is PortfolioHoldingsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is PortfolioHoldingsFailure) {
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: .0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const EmptyInvestmentCart(),
                const Gap(8),
                Row(
                  children: [
                    const Text(
                      'Available funds',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Gap(8),
                    BlocBuilder<SmallcaseFundsCubit, SmallcaseFundsState>(
                      builder: (context, state) {
                        if (state is SmallcaseFundsSuccess) {
                          return Row(
                            children: [
                              Text(
                                funds,
                                style: baseTextStyle2,
                              ),
                              const Gap(4),
                              InkWell(
                                onTap: () async {
                                  if (context
                                          .read<AuthCubit>()
                                          .state
                                          .user
                                          ?.smallcaseAuthToken !=
                                      null) {
                                    context
                                        .read<SmallcaseFundsCubit>()
                                        .fetchSmallcasefunds(
                                          GetFundasParams(
                                            email: context
                                                .read<AuthCubit>()
                                                .state
                                                .user!
                                                .emailId,
                                          ),
                                        );
                                    _fetchFunds(
                                      state.getFundsModel.transactionId,
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const ShowDialog();
                                      },
                                    );
                                  }
                                },
                                child: Assets.svgs.equityPortfolioRefresh
                                    .svg(height: 24),
                              ),
                            ],
                          );
                        }
                        return const Text(' -- --');
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Assets.pngs.equityHoldings.image(height: 200, width: 200),
                const Gap(5),
                Text(
                  'No Stocks, Start trading',
                  style: baseTextStyle16500,
                ),
                const Spacer(),
              ],
            ),
          );
        }
        if (state is PortfolioHoldingsLoaded) {
          return BlocBuilder<PortfolioPositionsCubit, PortfolioPositionsState>(
            builder: (context, positionState) {
              if (positionState is PortfolioPositionsLoaded) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ETFFolioContainer(
                              current:
                                  state.portfolioHoldingsModel.currentValue,
                              invested:
                                  state.portfolioHoldingsModel.investedValue,
                              returns: state.portfolioHoldingsModel.returns,
                              returnsPercentage: state
                                  .portfolioHoldingsModel.percentageReturns,
                              date: DateTime.now(),
                            ),
                          ),
                          const Gap(8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Available funds',
                                  style: baseTextStyle14400.copyWith(
                                      color: AppColors.neutral[300]),
                                ),
                                const Gap(8),
                                BlocBuilder<SmallcaseFundsCubit,
                                    SmallcaseFundsState>(
                                  builder: (context, state) {
                                    if (state is SmallcaseFundsSuccess) {
                                      return Row(
                                        children: [
                                          Text(
                                            funds.isNotEmpty ? funds : '-- --',
                                            style: baseTextStyle16500.copyWith(
                                                color: Colors.black),
                                          ),
                                          const Gap(8),
                                          InkWell(
                                            onTap: () async {
                                              if (context
                                                      .read<AuthCubit>()
                                                      .state
                                                      .user
                                                      ?.smallcaseAuthToken !=
                                                  null) {
                                                context
                                                    .read<SmallcaseFundsCubit>()
                                                    .fetchSmallcasefunds(
                                                        GetFundasParams(
                                                            email: context
                                                                .read<
                                                                    AuthCubit>()
                                                                .state
                                                                .user!
                                                                .emailId));
                                                _fetchFunds(state.getFundsModel
                                                    .transactionId);
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const ShowDialog();
                                                  },
                                                );
                                              }
                                            },
                                            child: Assets
                                                .svgs.equityPortfolioRefresh
                                                .svg(height: 24),
                                          ),
                                        ],
                                      );
                                    }
                                    return const Text(' -- --');
                                  },
                                ),
                                const Gap(8),
                              ],
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  ],
                  body: Column(
                    children: [
                      TabBar(
                        labelStyle: baseTextStyle14500,
                        labelColor: AppColors.primaryColor,
                        unselectedLabelStyle: baseTextStyle14400.copyWith(
                            color: AppColors.neutral[300]),
                        unselectedLabelColor: AppColors.neutral[300],
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Holdings'),
                                const Gap(6),
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary[50],
                                  ),
                                  child: Text(
                                    '${state.portfolioHoldingsModel.holdings?.length}',
                                    style: baseTextStyle12600.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Positions'),
                                const Gap(6),
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary[50],
                                  ),
                                  child: Text(
                                    '${positionState.portfolioPositionModel.positions.length}',
                                    style: baseTextStyle12600.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      getIt<PortfolioHoldingsCubit>()
                                        ..fetchHoldings(),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      getIt<PortfolioHoldingsTokenCubit>(),
                                ),
                              ],
                              child: HoldingsScreen(
                                portfolioHoldingsModel:
                                    state.portfolioHoldingsModel,
                              ),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<PortfolioPositionsCubit>()
                                    ..fetchPositions(),
                              child: PositionScreen(
                                portfolioPositionModel:
                                    positionState.portfolioPositionModel,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<String> _getSmallcaseFunds(String transactionId) async {
    log('transactionId: $transactionId');

    String? result = await ScgatewayFlutterPlugin.triggerGatewayTransaction(
      transactionId,
    );

    Map<String, dynamic> outerMap = jsonDecode(result!);
    if (outerMap.containsKey('errorMessage')) {
      if (context.mounted) {
        Utils.showErrorAlert(context, 'Login with your broker');
      }
    } else {
      var innerMap = outerMap['data'];

      if (innerMap.runtimeType == String) {
        var tempMap = jsonDecode(innerMap);
        innerMap = tempMap['data'];
      }

      String fundData = jsonEncode(innerMap['funds']);
      double funds = double.parse(fundData);
      return funds.toStringAsFixed(2);
    }
    return '';
  }
}
