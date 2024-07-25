import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/smart_watchlist_holdings_cubit.dart';
import '../../../../../widgets/app_error_widget.dart';
import 'widget/smart_watchlist_search_delegate.dart';
import '../../../../../../di/get_it.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/smart_watchlist_search_cubit.dart';
import 'smart_search_card.dart';

import '../../../../../../common/common.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_colors.dart';

class SmartWatchlistHoldings extends StatefulWidget {
  const SmartWatchlistHoldings({super.key});

  @override
  State<SmartWatchlistHoldings> createState() => _SmartWatchlistHoldingsState();
}

class _SmartWatchlistHoldingsState extends State<SmartWatchlistHoldings> {
  bool inputtext = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'true');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _searchbar(context, toppadding: 0.0),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    const Text('Add from holdings'),
                    const Gap(16),
                    BlocBuilder<SmartWatchlistHoldingsCubit,
                        SmartWatchlistHoldingsState>(
                      builder: (context, state) {
                        if (state is SmartWatchlistHoldingsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SmartWatchlistHoldingsFailure) {
                          return AppErrorWidget(
                            errorType: state.errorType,
                            error: state.errorMessage,
                            onRetry: () => context
                                .read<SmartWatchlistHoldingsCubit>()
                                .fetchHoldings(),
                          );
                        }
                        if (state is SmartWatchlistHoldingsLoaded) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: ListView.builder(
                                itemCount: state.smartWatchlistHoldings.length,
                                itemBuilder: (context, index) {
                                  if (state.smartWatchlistHoldings.isEmpty) {
                                    return Column(
                                      children: [
                                        const Gap(80),
                                        Assets.svgs.equityNoWatchlist.svg(),
                                        const Gap(30),
                                        Text(
                                          'The stock you are looking for could not be found',
                                          style: baseTextStyle14400,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SmartSearchCard(
                                      icon: state.smartWatchlistHoldings[index]
                                              .icon ??
                                          '',
                                      symbole: state
                                              .smartWatchlistHoldings[index]
                                              .holdingKey ??
                                          '',
                                      companyName: state
                                              .smartWatchlistHoldings[index]
                                              .companyName ??
                                          '',
                                      close: state.smartWatchlistHoldings[index]
                                              .lastTradedPrice ??
                                          0,
                                      change: state
                                              .smartWatchlistHoldings[index]
                                              .lastTradedPriceChange ??
                                          0,
                                      percentChange: state
                                              .smartWatchlistHoldings[index]
                                              .lastTradedPricePercentageChange ??
                                          0,
                                      qty: state.smartWatchlistHoldings[index]
                                              .quantity ??
                                          0,
                                    );
                                  }
                                }),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchbar(BuildContext context, {double toppadding = 10.0}) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: toppadding),
      child: InkWell(
        onTap: () async {
          final searchFundCubit = getIt<SmartWatchlistSearchCubit>();
          final debouncer = Debouncer(milliseconds: 300);
          await showSearch(
            context: context,
            delegate: SmartWatchlistSearchDelegate(
                debouncer: debouncer, searchFundCubit: searchFundCubit),
          );
          searchFundCubit.close();
          debouncer.close();
        },
        splashColor: Colors.transparent,
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(
              color: AppColors.primary[200]!,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 'true');
                  },
                  radius: 20,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColors.mainBlack,
                  ),
                ),
                const Gap(30),
                Expanded(
                  child: Text(
                    'Search stocks eg: INFY',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.textGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
