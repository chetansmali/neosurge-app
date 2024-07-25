import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/params/equity/equity_explore/stock_details_params.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/buy_sell_transaction_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/add_stock_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../../widgets/amount_widget.dart';
import 'add_watchlist_bottom_sheet.dart';
import 'buy_sell_bottom_sheet.dart';
import 'stock_chart.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../cubits/equity/equity_explore/stock_details_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../component/detail_widget.dart';
import '../../../../../common/common.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/app_error_widget.dart';

class StockDetailsScreen extends StatefulWidget {
  final String sybNmae;
  final double close;
  final double change;
  final double percentage;
  final String industry;
  final String name;
  final String icon;

  const StockDetailsScreen({
    Key? key,
    required this.sybNmae,
    required this.close,
    required this.change,
    required this.percentage,
    required this.industry,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  EquityFundamentalTimePeriod currentTime =
      EquityFundamentalTimePeriod.oneMonth;
  late double month, year, fiveY;
  bool isExpanded = false;
  final String name = '';
  bool isExpandedText = false;

  @override
  Widget build(BuildContext context) {
    final smallcaseAuthToken =
        context.read<AuthCubit>().state.user?.smallcaseAuthToken;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: smallcaseAuthToken != null
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height *
                                  0.85, // 85% of screen height
                            ),
                            builder: (BuildContext context) {
                              return MultiBlocProvider(
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
                                child: BuySellBottomSheet(
                                  authToken: smallcaseAuthToken,
                                  type: 'Buy',
                                  price: widget.close,
                                  symbol: widget.sybNmae,
                                  name: widget.name,
                                ),
                              );
                            },
                          );
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      smallcaseAuthToken != null ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: const Text('Buy'),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ElevatedButton(
                  onPressed: smallcaseAuthToken != null
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height *
                                  0.85, // 85% of screen height
                            ),
                            builder: (BuildContext context) {
                              return MultiBlocProvider(
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
                                child: BuySellBottomSheet(
                                  authToken: smallcaseAuthToken,
                                  type: 'Sell',
                                  price: widget.close,
                                  symbol: widget.sybNmae,
                                  name: widget.name,
                                ),
                              );
                            },
                          );
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      smallcaseAuthToken != null ? Colors.red : Colors.grey,
                    ),
                  ),
                  child: const Text('Sell'),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.sybNmae,
                    style: TextStyle(
                      color: AppColors.neutral[400],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      getIt<GetAllUserWatchlisCubit>()
                                        ..fetchAllWatchlist(),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      getIt<AddStockWatchlistCubit>(),
                                ),
                              ],
                              child: AddStockToWatchList(
                                synbolName: widget.sybNmae,
                                icon: widget.icon,
                                close: widget.close,
                                change: widget.change,
                                percentageChange: widget.percentage,
                                qty: 0,
                                companyName: widget.name,
                              ),
                            );
                          },
                        );
                      },
                      child: Assets.svgs.equityBookmark
                          .svg(height: 20, width: 20)),
                )
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 35.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Gap(35),
                    Expanded(
                      child: Text(
                        widget.name,
                        style: baseTextStyle14400,
                      ),
                    ),
                    AmountWidget(
                        amount: widget.close,
                        isCompact: false,
                        style: baseTextStyle14500),
                  ],
                ),
                const Gap(2),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary[50],
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                            top: 3,
                            bottom: 3,
                          ),
                          child: Text(
                            widget.industry,
                            style: TextStyle(
                              color: AppColors.primary[500],
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${widget.change.toStringAsFixed(2)}  (${widget.percentage.toStringAsFixed(2)}%)',
                        style: baseTextStyle12400.copyWith(
                          color: widget.change > 0
                              ? AppColors.green
                              : AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              StockChart(sybName: widget.sybNmae),
              const Gap(40),
              BlocBuilder<StockDetailsCubit, StockDetailsState>(
                builder: (context, state) {
                  if (state is StockDetailsLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is StockDetailsFailure) {
                    return AppErrorWidget(
                      errorType: state.errorType,
                      error: state.errorMessage,
                      onRetry: () => context.read<StockDetailsCubit>()
                        ..fetchStockDetails(
                            StockDetailsParams(symbol: widget.sybNmae)),
                    );
                  }
                  if (state is StockDetailsSuccess) {
                    final SD = state.stockDetailsModel;
                    month = SD.fundamentals?.oneMonthReturn ?? 0;
                    year = SD.fundamentals?.oneYearReturn ?? 0;
                    fiveY = SD.fundamentals?.fiveYearReturn ?? 0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailWidget(
                                  value: SD.quote?.open?.toStringAsFixed(2) ??
                                      'NA',
                                  title: 'Open',
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                const Gap(20),
                                DetailWidget(
                                  value: SD.quote?.fiftyTwoWeek.high
                                          ?.toStringAsFixed(2) ??
                                      'NA',
                                  title: '52W High',
                                  color: AppColors.green,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailWidget(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  value: SD.quote?.high?.toStringAsFixed(2) ??
                                      'NA',
                                  title: 'High',
                                  color: AppColors.green,
                                ),
                                const Gap(20),
                                DetailWidget(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  value: SD.quote?.fiftyTwoWeek.low
                                          ?.toStringAsFixed(2) ??
                                      'NA',
                                  title: '52W Low',
                                  color: AppColors.errorRed,
                                ),
                              ],
                            ),
                            DetailWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              value: SD.quote?.low?.toStringAsFixed(2) ?? 'NA',
                              title: 'Low',
                              color: AppColors.errorRed,
                            ),
                            DetailWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              value:
                                  SD.quote?.previousClose?.toStringAsFixed(2) ??
                                      'NA',
                              title: 'Prev. close',
                            ),
                          ],
                        ),
                        const Gap(40),
                        Text(
                          'Fundamentals',
                          style: TextStyle(
                            color: AppColors.neutral[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(25),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (currentTime ==
                                          EquityFundamentalTimePeriod
                                              .oneMonth) {
                                        setState(() {
                                          currentTime =
                                              EquityFundamentalTimePeriod
                                                  .oneYear;
                                        });
                                      } else if (currentTime ==
                                          EquityFundamentalTimePeriod.oneYear) {
                                        setState(() {
                                          currentTime =
                                              EquityFundamentalTimePeriod
                                                  .fiveYear;
                                        });
                                      } else if (currentTime ==
                                          EquityFundamentalTimePeriod
                                              .fiveYear) {
                                        setState(() {
                                          currentTime =
                                              EquityFundamentalTimePeriod
                                                  .oneMonth;
                                        });
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              _getIndexFramename(),
                                              style:
                                                  baseTextStyle10400.copyWith(
                                                color: AppColors.textLightGrey,
                                              ),
                                            ),
                                            const Gap(5),
                                            Image.asset(
                                              Assets.icons.dayChangeIcon.path
                                                  .toString(),
                                              height: 7,
                                              width: 11,
                                            )
                                          ],
                                        ),
                                        const Gap(4),
                                        Text(
                                          '${_getIndexReturn().toStringAsFixed(2)}%',
                                          style: baseTextStyle.copyWith(
                                            color: _getIndexReturn() > 0
                                                ? AppColors.green
                                                : AppColors.errorRed,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DetailWidget(
                                    value: Utils.compactCurrency(
                                      SD.fundamentals?.valuationsMetrics
                                              ?.marketCapitalization
                                              ?.toDouble() ??
                                          0,
                                    ),
                                    title: 'Mkt Cap',
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.valuationsMetrics
                                            ?.priceToBookRatio
                                            ?.toStringAsFixed(2) ??
                                        'NA',
                                    title: 'P/B ratio',
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.valuationsMetrics
                                            ?.priceToEarningsRatio
                                            ?.toStringAsFixed(2) ??
                                        'NA',
                                    title: 'P/E ratio (TTM)',
                                  ),
                                ],
                              ),
                              const Divider(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'ROE',
                                        style: baseTextStyle10400.copyWith(),
                                      ),
                                      const Gap(4),
                                      Text(
                                        SD.fundamentals?.financials
                                                ?.returnOnEquity
                                                ?.toStringAsFixed(2) ??
                                            'NA',
                                        style: baseTextStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.financials
                                            ?.returnOnAssets
                                            ?.toStringAsFixed(2) ??
                                        'NA',
                                    title: 'ROA',
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.dividendsAndSplits
                                            ?.dividendYield
                                            ?.toStringAsFixed(4) ??
                                        'NA',
                                    title: 'Div Yield',
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.financials
                                            ?.balanceSheet?.debtToEquity
                                            ?.toStringAsFixed(2) ??
                                        'NA',
                                    title: 'Debt to Equity',
                                  ),
                                ],
                              ), //
                              const Divider(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Profit Margin',
                                        style: baseTextStyle10400.copyWith(
                                            color: AppColors.textLightGrey),
                                      ),
                                      const Gap(4),
                                      Text(
                                        SD.fundamentals?.financials
                                                ?.profitMargin
                                                ?.toStringAsFixed(2) ??
                                            'NA',
                                        style: baseTextStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  DetailWidget(
                                    value: SD.fundamentals?.financials
                                            ?.operatingMargin
                                            ?.toStringAsFixed(2) ??
                                        'NA',
                                    title: 'Operating Margin',
                                  ),
                                  DetailWidget(
                                    value: Utils.compactCurrency(
                                      (SD.fundamentals?.financials?.cashFlow
                                                  ?.operatingCashFlow ??
                                              0)
                                          .toDouble(),
                                    ),
                                    title: 'Operating Cash Flow',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(40),
                        Text(
                          'About the company',
                          style: TextStyle(
                            color: AppColors.neutral[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (SD.profile?.description?.length ?? 0) > 160
                                  ? isExpandedText
                                      ? SD.profile?.description ?? ''
                                      : '${SD.profile?.description?.substring(0, 160)}...'
                                  : SD.profile?.description ?? '',
                              style: TextStyle(
                                color: AppColors.neutral[300],
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpandedText = !isExpandedText;
                                });
                              },
                              child: Text(
                                isExpandedText ? 'Read less' : 'Read more',
                                style: TextStyle(
                                  color: AppColors.primary[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20)
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getIndexFramename() {
    switch (currentTime) {
      case EquityFundamentalTimePeriod.oneMonth:
        return ('1M Return');
      case EquityFundamentalTimePeriod.oneYear:
        return ('1Y Return');
      case EquityFundamentalTimePeriod.fiveYear:
        return ('5Y Return');
    }
  }

  double _getIndexReturn() {
    switch (currentTime) {
      case EquityFundamentalTimePeriod.oneMonth:
        return (month);
      case EquityFundamentalTimePeriod.oneYear:
        return (year);
      case EquityFundamentalTimePeriod.fiveYear:
        return (fiveY);
    }
  }
}
