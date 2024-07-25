import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/market_news/news_banner.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/news_carousel.dart';

import '../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../../widgets/empty_investment_card.dart';
import '../my_portfolio/widgets/investment_card.dart';
import 'widgets/actionables.dart';
import 'widgets/products.dart';

class LoggedInHome extends StatelessWidget {
  const LoggedInHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          const NewsBanner(),
          const Gap(24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Your Portfolio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocBuilder<ImportHoldingDataCubit, ImportHoldingDataState>(
              bloc: context.read<ImportHoldingDataCubit>(),
              builder: (context, state) {
                if (state is ImportHoldingDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is ImportHoldingDataLoadError) {
                  return const EmptyInvestmentCart();
                }

                if (state is ImportHoldingDataLoaded &&
                    state.importedHoldingResponse.user.lastRefresh == null) {
                  return const EmptyInvestmentCart();
                }

                if (state is ImportHoldingDataLoaded &&
                    state.neoSurgeInvestment == null &&
                    state.importedHoldingResponse.holdingDistribution.isEmpty) {
                  return const EmptyInvestmentCart();
                }
                if (state is ImportHoldingDataLoaded) {
                  return InvestmentCard(
                    user: ImportedHoldingUser(
                      currentAssetValue:
                          state.importedHoldingResponse.user.currentAssetValue,
                      investedValue:
                          state.importedHoldingResponse.user.investedValue,
                      returnValue:
                          state.importedHoldingResponse.user.returnValue,
                      returnPercentage: state.importedHoldingResponse.user
                                      .investedValue ==
                                  null ||
                              state.importedHoldingResponse.user.returnValue ==
                                  null
                          ? 0
                          : (state.importedHoldingResponse.user.returnValue! /
                                  state.importedHoldingResponse.user
                                      .investedValue!) *
                              100,
                      xirr: state.importedHoldingResponse.user.xirr,
                      oneDayChange:
                          state.importedHoldingResponse.user.oneDayChange,
                      oneDayChangePercentage: state
                          .importedHoldingResponse.user.oneDayChangePercentage,
                      panNumber:
                          state.importedHoldingResponse.user.panNumber ?? '',
                      mobileNumber:
                          state.importedHoldingResponse.user.mobileNumber ?? '',
                    ),
                    isRefreshButtonVisible: false,
                    animatedCard: false,
                  );
                }
                return const EmptyInvestmentCart();
              },
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Text(
                  'What\'s New',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Assets.animations.newBanner.lottie(width: 40, height: 40)
              ],
            ),
          ),
          const Gap(24),
          const NewsCarousel(),
          const Actionables(),
          const Gap(20),
          const Products(),
          const Gap(40),
        ],
      ),
    );
  }
}
