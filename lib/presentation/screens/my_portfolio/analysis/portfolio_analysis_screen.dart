import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/risk_meter.dart';

import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/import_external_fund/portfolio_analysis/portfolio_analysis_cubit.dart';
import '../../../widgets/widgets.dart';
import 'widgets/amc_allocation.dart';
import 'widgets/category_and_sector_tabview.dart';
import 'widgets/folio_analysis.dart';
import 'widgets/portfolio_performance.dart';
import 'widgets/top_10_holdings.dart';

class PortfolioAnalysisScreen extends StatefulWidget {
  const PortfolioAnalysisScreen({
    super.key,
    required this.equityPercentage,
    required this.debtPercentage,
    required this.hybridPercentage,
    required this.xirr,
    required this.holdingsCount,
  });

  final double equityPercentage;
  final double debtPercentage;
  final double hybridPercentage;
  final double xirr;
  final int holdingsCount;

  @override
  State<PortfolioAnalysisScreen> createState() =>
      _PortfolioAnalysisScreenState();
}

class _PortfolioAnalysisScreenState extends State<PortfolioAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Insights'),
        centerTitle: true,
      ),
      body: BlocBuilder<PortfolioAnalysisCubit, PortfolioAnalysisState>(
        bloc: context.read<PortfolioAnalysisCubit>(),
        builder: (context, state) {
          if (state is PortfolioAnalysisLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is PortfolioAnalysisError) {
            return AppErrorWidget(
              errorType: state.appError.errorType,
              error: state.appError.error,
              onRetry: () {
                context.read<PortfolioAnalysisCubit>().getPortfolioAnalysis(
                      userId: context.read<AuthCubit>().state.user!.id,
                    );
              },
            );
          }

          if (state is! PortfolioAnalysisLoaded) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FolioAnalysis(
                    debtPercentage: widget.debtPercentage,
                    equityPercentage: widget.equityPercentage,
                    hybridPercentage: widget.hybridPercentage,
                    holdingsCount: widget.holdingsCount,
                  ),
                  const Gap(24),
                  PortfolioPerformance(
                    xirr: widget.xirr,
                    benchmark:
                        state.portfolioAnalysisResponse.benchmarkValue ?? 0.0,
                  ),
                  const Gap(24),
                  CategoryAndSectorTabView(
                    category: (state.portfolioAnalysisResponse
                            .subcategoriesPercentage ??
                        [])
                      ..sort(
                        (a, b) =>
                            b.percentage?.compareTo(a.percentage ?? 0) ?? 0,
                      ),
                    sector:
                        (state.portfolioAnalysisResponse.sectorsPercentage ??
                            [])
                          ..sort(
                            (a, b) =>
                                b.percentage?.compareTo(a.percentage ?? 0) ?? 0,
                          ),
                  ),
                  const Gap(24),
                  TopTenHolding(
                    topHoldings:
                        (state.portfolioAnalysisResponse.topHoldings ?? [])
                          ..sort(
                            (a, b) =>
                                b.holdingsPercentage
                                    ?.compareTo(a.holdingsPercentage ?? 0) ??
                                0,
                          ),
                  ),
                  const Gap(24),
                  AmcAllocation(
                      amcAllocations:
                          state.portfolioAnalysisResponse.amcBasedHoldings!
                            ..sort(
                              (a, b) => b.holdingsPercentage!
                                  .compareTo(a.holdingsPercentage!),
                            )),
                  const Gap(24),
                  RiskMeter(
                    equityPercentage: widget.equityPercentage,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
