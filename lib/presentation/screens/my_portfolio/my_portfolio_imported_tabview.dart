import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/widgets.dart';
import 'widgets/importing_mutual_fund_screen.dart';
import 'widgets/fund_not_available.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/import_external_fund/account_details/account_details_cubit.dart';
import '../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import 'widgets/fund_not_imported_view.dart';
import 'widgets/investment_card.dart';

class MyPortfolioImportedTabView extends StatefulWidget {
  const MyPortfolioImportedTabView({super.key});

  @override
  State<MyPortfolioImportedTabView> createState() =>
      _MyPortfolioImportedTabViewState();
}

class _MyPortfolioImportedTabViewState
    extends State<MyPortfolioImportedTabView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
        builder: (context, accountState) {
          if (accountState is AccountDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (accountState is AccountDetailsLoadError) {
            return AppErrorWidget(
              errorType: accountState.appErrorType,
              error: accountState.errorMessage,
            );
          }

          if (accountState is! AccountDetailsLoaded) {
            return const SizedBox();
          }

          return BlocBuilder<ImportHoldingDataCubit, ImportHoldingDataState>(
            builder: (context, state) {
              if (state is ImportHoldingDataLoading) {
                return const Center(
                  child: SliverToBoxAdapter(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (state is ImportHoldingDataLoadError) {
                return const FundNotImportedView();
              }

              if (state is ImportHoldingDataLoaded &&
                  state.importedHoldingResponse.user.lastRefresh == null) {
                return const ImportingMutualFund();
              }

              if (state is ImportHoldingDataLoaded &&
                  state.neoSurgeInvestment == null &&
                  state.importedHoldingResponse.holdingDistribution.isEmpty) {
                return FundNotAvailable(
                  panNumber: state.importedHoldingResponse.user.panNumber ?? '',
                );
              }

              if (state is ImportHoldingDataLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: InvestmentCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Routes.brokerHoldingFundScreen,
                            arguments: BrokerFundInvestmentArgs(
                              userId: context.read<AuthCubit>().state.user!.id,
                              brokerName: '',
                              currentAssetValue: state.importedHoldingResponse
                                  .user.currentAssetValue,
                              investedValue: state
                                  .importedHoldingResponse.user.investedValue,
                              returnValue: state
                                  .importedHoldingResponse.user.returnValue,
                            ),
                          );
                        },
                        user: ImportedHoldingUser(
                          currentAssetValue: state
                              .importedHoldingResponse.user.currentAssetValue,
                          investedValue:
                              state.importedHoldingResponse.user.investedValue,
                          returnValue:
                              state.importedHoldingResponse.user.returnValue,
                          returnPercentage: state.importedHoldingResponse.user
                                          .investedValue ==
                                      null ||
                                  state.importedHoldingResponse.user
                                          .returnValue ==
                                      null
                              ? 0
                              : (state.importedHoldingResponse.user
                                          .returnValue! /
                                      state.importedHoldingResponse.user
                                          .investedValue!) *
                                  100,
                          xirr: state.importedHoldingResponse.user.xirr,
                          oneDayChange:
                              state.importedHoldingResponse.user.oneDayChange,
                          oneDayChangePercentage: state.importedHoldingResponse
                              .user.oneDayChangePercentage,
                          panNumber:
                              state.importedHoldingResponse.user.panNumber ??
                                  '',
                          mobileNumber:
                              state.importedHoldingResponse.user.mobileNumber ??
                                  '',
                        ),
                        isRefreshButtonVisible: accountState
                            .accountDetailsResponse.refreshAvailable,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Routes.portfolioAnalysis,
                            arguments: PortfolioAnalysisArgs(
                              equityPercentage: state.importedHoldingResponse
                                      .user.equityPercentage ??
                                  0,
                              debtPercentage: state.importedHoldingResponse.user
                                      .debtPercentage ??
                                  0,
                              hybridPercentage: state.importedHoldingResponse
                                      .user.hybridPercentage ??
                                  0,
                              xirr:
                                  state.importedHoldingResponse.user.xirr ?? 0,
                              holdingsCount: state.importedHoldingResponse.user
                                      .holdingsCount ??
                                  0,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Check your Investment Insights',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: AppColors.mainBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Holding Distribution',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainBlack,
                          ),
                        ),
                      ),
                    ),
                    SliverStack(
                      insetOnOverlap: false,
                      children: [
                        const SliverPositioned.fill(child: Card()),
                        if (state.neoSurgeInvestment != null)
                          SliverToBoxAdapter(
                            child: _buildBrokerTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.brokerHoldingFundScreen,
                                  arguments: BrokerFundInvestmentArgs(
                                    userId: context
                                        .read<AuthCubit>()
                                        .state
                                        .user!
                                        .id,
                                    brokerName:
                                        state.neoSurgeInvestment!.brokerName,
                                    currentAssetValue: state
                                        .neoSurgeInvestment!.currentAssetValue,
                                    investedValue: state
                                        .neoSurgeInvestment!.currentInvestment,
                                    returnValue: state
                                        .neoSurgeInvestment!.currentReturns,
                                  ),
                                );
                              },
                              investedValue:
                                  state.neoSurgeInvestment!.currentAssetValue ??
                                      0,
                              showRandomLogo: false,
                              title: Image.asset(
                                'assets/app_icons/splash_logo.png',
                                height: 25,
                              ),
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                                bottom: 20,
                              ),
                            ),
                          ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            top: state.neoSurgeInvestment != null ? 180 : 20,
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          sliver: SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: state.importedHoldingResponse
                                .holdingDistribution.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildBrokerTile(
                                showRandomLogo: true,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.brokerHoldingFundScreen,
                                    arguments: BrokerFundInvestmentArgs(
                                      userId: context
                                          .read<AuthCubit>()
                                          .state
                                          .user!
                                          .id,
                                      brokerName: state
                                          .importedHoldingResponse
                                          .holdingDistribution[index]
                                          .brokerName,
                                      currentAssetValue: state
                                          .importedHoldingResponse
                                          .holdingDistribution[index]
                                          .currentAssetValue,
                                      investedValue: state
                                          .importedHoldingResponse
                                          .holdingDistribution[index]
                                          .currentInvestment,
                                      returnValue: state
                                          .importedHoldingResponse
                                          .holdingDistribution[index]
                                          .currentReturns,
                                    ),
                                  );
                                },
                                investedValue: state
                                        .importedHoldingResponse
                                        .holdingDistribution[index]
                                        .currentAssetValue ??
                                    0,
                                title: Expanded(
                                  child: Text(
                                    state.importedHoldingResponse
                                        .holdingDistribution[index].brokerName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mainBlack,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }

              return const SliverToBoxAdapter();
            },
          );
        },
      ),
    );
  }

  Widget _buildBrokerTile({
    required VoidCallback onTap,
    required Widget title,
    required double investedValue,
    EdgeInsets? margin,
    required bool showRandomLogo,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Center(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          margin: margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showRandomLogo) ...[
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.primaries[
                                    DateTime.now().microsecondsSinceEpoch %
                                        Colors.primaries.length],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/svgs/currency.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            const Gap(4),
                          ],
                          title,
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/round_arrow_right_up.svg',
                    ),
                  ],
                ),
              ),
              const Text(
                'Current Value',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AmountWidget(
                amount: investedValue,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
