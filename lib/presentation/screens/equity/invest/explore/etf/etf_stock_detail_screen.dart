import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../data/models/equity/equity_explore/stock_details.dart';
import '../../../../../../di/get_it.dart';
import '../../../../../../domain/entities/enums.dart';
import '../../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../../cubits/equity/buy_sell_transaction_cubit.dart';
import '../../../../../cubits/equity/equity_explore/stock_chart_cubit.dart';
import '../../../../../cubits/equity/equity_explore/stock_details_cubit.dart';
import '../../../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/amount_widget.dart';
import '../../../../../widgets/widgets.dart';
import 'widgets/etf_buysell_button.dart';
import 'widgets/etf_order_sheet.dart';
import 'widgets/etf_quote_widget.dart';
import 'widgets/etf_stock_chart.dart';

class ETFStockDetailScreen extends StatelessWidget {
  const ETFStockDetailScreen({
    super.key,
    required this.symbol,
    this.imageUrl,
    required this.name,
    required this.close,
    required this.change,
    required this.percentage,
  });
  final String symbol;
  final String? imageUrl;
  final String name;
  final double close, change, percentage;

  @override
  Widget build(BuildContext context) {
    final smallcaseAuthToken =
        context.read<AuthCubit>().state.user?.smallcaseAuthToken;

    return BlocBuilder<StockDetailsCubit, StockDetailsState>(
      builder: (context, state) {
        switch (state) {
          case StockDetailsLoading():
            return Scaffold(
                appBar: AppBar(),
                body: const Center(child: CircularProgressIndicator()));
          case StockDetailsFailure():
            return Scaffold(
              appBar: AppBar(),
              body: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () => context.read<StockChartCubit>()
                  ..fetchChartData(EquityChartTimePeriod.oneDay, symbol),
              ),
            );
          case StockDetailsSuccess():
            final StockDetailsModel stockDetails = state.stockDetailsModel;

            return Scaffold(
              appBar: AppBar(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name.isNotEmpty ? name : symbol,
                            style: baseTextStyle18500.copyWith(
                                color: AppColors.neutral[400]),
                            maxLines: 1,
                          ),
                        ),
                        AmountWidget(
                          amount: close,
                          style: baseTextStyle14600.copyWith(
                              color: AppColors.neutral[400]),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${change.isNegative ? '' : '+'}${change.toStringAsFixed(3)} (${percentage.toStringAsFixed(3)}%)',
                        style: baseTextStyle12400.copyWith(
                          color: change.isNegative
                              ? AppColors.error[500]
                              : AppColors.success[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  const Gap(20),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          BlocProvider(
                            create: (context) => getIt<StockChartCubit>()
                              ..fetchChartData(
                                  EquityChartTimePeriod.oneDay, symbol),
                            child: ETFStockChart(sybName: symbol),
                          ),
                          const Gap(32),
                          if (state.stockDetailsModel.quote != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ETFQuoteWidget(
                                      title: 'Open',
                                      value:
                                          state.stockDetailsModel.quote!.open,
                                    ),
                                    const Gap(22),
                                    ETFQuoteWidget(
                                      title: 'Prev. close',
                                      value: state.stockDetailsModel.quote!
                                          .previousClose,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ETFQuoteWidget(
                                      title: 'High',
                                      value:
                                          state.stockDetailsModel.quote!.high,
                                      isHigh: true,
                                    ),
                                    const Gap(22),
                                    ETFQuoteWidget(
                                      title: '52W High',
                                      value: state.stockDetailsModel.quote!
                                          .fiftyTwoWeek.high,
                                      isHigh: true,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ETFQuoteWidget(
                                      title: 'Low',
                                      value: state.stockDetailsModel.quote!.low,
                                      isHigh: false,
                                    ),
                                    const Gap(22),
                                    ETFQuoteWidget(
                                      title: '52W Low',
                                      value: state.stockDetailsModel.quote!
                                          .fiftyTwoWeek.low,
                                      isHigh: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      const Gap(20),
                      Expanded(
                        child: ETFBuySellButton(
                          onTap: () {
                            smallcaseAuthToken != null
                                ? showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<BuySellTransactionCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<SmallcaseLoginCubit>(),
                                        ),
                                      ],
                                      child: ETFOrderBottomSheet(
                                        authToken: smallcaseAuthToken,
                                        name: stockDetails.profile!.name!,
                                        imageUrl: imageUrl,
                                        amount: close,
                                        symbol: symbol,
                                        isBuying: true,
                                      ),
                                    ),
                                  )
                                : null;
                          },
                          title: 'Buy',
                          color: AppColors.primary[500]!,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: ETFBuySellButton(
                          onTap: () {
                            smallcaseAuthToken != null
                                ? showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<BuySellTransactionCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<SmallcaseLoginCubit>(),
                                        ),
                                      ],
                                      child: ETFOrderBottomSheet(
                                        authToken: smallcaseAuthToken,
                                        name: stockDetails.profile!.name!,
                                        imageUrl: imageUrl,
                                        amount: close,
                                        symbol: symbol,
                                        available: 20,
                                        isBuying: false,
                                      ),
                                    ),
                                  )
                                : null;
                          },
                          title: 'Sell',
                          color: AppColors.error[500]!,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
