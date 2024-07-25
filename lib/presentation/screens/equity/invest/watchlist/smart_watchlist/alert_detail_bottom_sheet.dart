import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widget/Invest_current_return_card.dart';
import 'widget/alert_details_price_card.dart';
import 'widget/smart_watchlist_chart.dart';
import 'widget/orders_screen.dart';
import '../../../../../../di/get_it.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/alert_details_params.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/get_users_alert_params.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/get_alert_details_cubit.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/set_alert_cubit.dart';
import '../../../../../widgets/app_error_widget.dart';
import 'set_alert_bottom_sheet.dart';
import 'smart_watchlist_news.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/amount_widget.dart';

class AlertDetailsBootmSheet extends StatefulWidget {
  final String symbol;
  const AlertDetailsBootmSheet({super.key, required this.symbol});

  @override
  State<AlertDetailsBootmSheet> createState() => _AlertDetailsBootmSheetState();
}

class _AlertDetailsBootmSheetState extends State<AlertDetailsBootmSheet> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  String _fetchRes = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        context.read<GetUserAlertsCubit>().fetchUserAlerts(
              GetUsersAlertParams(
                page: 0,
                size: 25,
                sort: '',
              ),
            );
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 8),
        child: Column(
          children: [
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alert details', style: baseTextStyle2),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      context.read<GetUserAlertsCubit>().fetchUserAlerts(
                            GetUsersAlertParams(
                              page: 0,
                              size: 25,
                              sort: '',
                            ),
                          );
                    },
                    child: Assets.icons.crossIcon.image(height: 24, width: 24)),
              ],
            ),
            const Gap(20),
            BlocBuilder<GetAlertDetailsCubit, GetAlertDetailsState>(
              builder: (context, state) {
                if (state is GetAlertDetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is GetAlertDetailsFailure) {
                  return AppErrorWidget(
                    errorType: state.errorType,
                    error: state.errorMessage,
                    onRetry: () => context
                        .read<GetAlertDetailsCubit>()
                        .fetchAlertDetails(
                            AlertDetailsParams(symbol: widget.symbol)),
                  );
                }
                if (state is GetAlertDetailsLoaded) {
                  final lineBarsData = [
                    LineChartBarData(
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                          radius: 5,
                          color: AppColors.primaryColor,
                          strokeWidth: 2,
                          strokeColor: AppColors.textGrey,
                        ),
                        checkToShowDot: (spot, barData) {
                          return state.spotIndexies.contains(spot.x.toInt());
                        },
                      ),
                      spots: state.stockChartData,
                      isCurved: true,
                      color: AppColors.primaryColor,
                      aboveBarData: BarAreaData(show: false),
                      preventCurveOverShooting: true,
                      isStrokeCapRound: true,
                      isStrokeJoinRound: true,
                      curveSmoothness: 0.8,
                    ),
                  ];

                  final tooltipsOnBar = lineBarsData[0];

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.alertDetailsModel.data.companyName ?? '',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: baseTextStyle21500,
                      ),
                      const Gap(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AmountWidget(
                                amount: state.alertDetailsModel.data.close ?? 0,
                                style: baseTextStyle21500,
                              ),
                              const Gap(10),
                              Text(
                                state.alertDetailsModel.data.change != null &&
                                        state.alertDetailsModel.data.change! > 0
                                    ? ('+${state.alertDetailsModel.data.change?.toStringAsFixed(2) ?? '0'}')
                                    : state.alertDetailsModel.data.change
                                            ?.toStringAsFixed(2) ??
                                        '0',
                                style: baseTextStyle10500.copyWith(
                                    color:
                                        state.alertDetailsModel.data.change !=
                                                    null &&
                                                state.alertDetailsModel.data
                                                        .change! >
                                                    0
                                            ? AppColors.green
                                            : AppColors.errorRed),
                              ),
                              const Gap(5),
                              Text(
                                ('(${state.alertDetailsModel.data.percentChange?.toStringAsFixed(2) ?? '0'}%)'),
                                style: baseTextStyle10500.copyWith(
                                    color: state.alertDetailsModel.data
                                                    .percentChange !=
                                                null &&
                                            state.alertDetailsModel.data
                                                    .percentChange! >
                                                0
                                        ? AppColors.green
                                        : AppColors.errorRed),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            width: 85,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                state.alertDetailsModel.data.sector ?? '',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: baseTextStyle10500.copyWith(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      SmartWatchlistChart(
                        lineBarsData: lineBarsData,
                        tooltipsOnBar: tooltipsOnBar,
                        spotIndexies: state.spotIndexies,
                        dateIndex: state.dates,
                        avgValue: state.alertDetailsModel.data.holdingValues
                                .avgValue ??
                            0,
                      ),
                      const Gap(12),
                      InvestCurrentReturnCard(
                        currentValue: state.alertDetailsModel.data.holdingValues
                                .currentValue ??
                            0,
                        investedValue: state.alertDetailsModel.data
                                .holdingValues.investedValue ??
                            0,
                        returnPercentage: state.alertDetailsModel.data
                                .holdingValues.returnsPercent ??
                            0,
                        returnValue: state
                                .alertDetailsModel.data.holdingValues.returns ??
                            0,
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrdersScreen(
                                        transactions: state.alertDetailsModel
                                            .data.transactions,
                                      )));
                        },
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              ' View transaction history',
                              style: baseTextStyle12500.copyWith(
                                  color: AppColors.primaryColor),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertDetailsPriceCard(
                            title: 'Alert price',
                            image: Assets.pngs.smartWatchlistAlert
                                .image(height: 20, width: 20),
                            price: state.alertDetailsModel.data.alertPrice ?? 0,
                          ),
                          const Gap(20),
                          AlertDetailsPriceCard(
                            title: 'Avg. price',
                            image: Assets.pngs.smartWatchlistAverage
                                .image(height: 20, width: 20),
                            price: state.alertDetailsModel.data.holdingValues
                                    .avgValue ??
                                0,
                          ),
                        ],
                      ),
                      const Gap(14),
                      state.alertDetailsModel.data.lastAlertIsTriggered !=
                                  null &&
                              state.alertDetailsModel.data.lastAlertIsTriggered!
                          ? Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Previously set alert has been triggered.',
                                    style: baseTextStyle12500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final reulst = await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30),
                                          ),
                                        ),
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        context: context,
                                        builder: (BuildContext _) {
                                          return BlocProvider(
                                            create: (context) =>
                                                getIt<SetAlertCubit>(),
                                            child: SetAlertBootmSheet(
                                              icon: state.alertDetailsModel.data
                                                      .icon ??
                                                  '',
                                              symbole: state.alertDetailsModel
                                                      .data.symbol ??
                                                  '',
                                              companyName: state
                                                      .alertDetailsModel
                                                      .data
                                                      .companyName ??
                                                  '',
                                              close: state.alertDetailsModel
                                                      .data.close ??
                                                  0,
                                              change: state.alertDetailsModel
                                                      .data.change ??
                                                  0,
                                              percentChange: state
                                                      .alertDetailsModel
                                                      .data
                                                      .percentChange ??
                                                  0,
                                              qty: 0,
                                            ),
                                          );
                                        });

                                    setState(() {
                                      _fetchRes = reulst as String;
                                    });

                                    if (_fetchRes == 'true') {
                                      context
                                          .read<GetAlertDetailsCubit>()
                                          .fetchAlertDetails(
                                            AlertDetailsParams(
                                                symbol: widget.symbol),
                                          );
                                    }
                                  },
                                  splashColor: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        ' Set New Alert',
                                        style: baseTextStyle12500.copyWith(
                                            color: AppColors.primaryColor),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 24,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'You will be notified when alert price is reached.',
                                    style: baseTextStyle12500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final result = await showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (BuildContext _) {
                                        return BlocProvider(
                                          create: (context) =>
                                              getIt<SetAlertCubit>(),
                                          child: SetAlertBootmSheet(
                                            icon: state.alertDetailsModel.data
                                                    .icon ??
                                                '',
                                            symbole: state.alertDetailsModel
                                                    .data.symbol ??
                                                '',
                                            companyName: state.alertDetailsModel
                                                    .data.companyName ??
                                                '',
                                            close: state.alertDetailsModel.data
                                                    .close ??
                                                0,
                                            change: state.alertDetailsModel.data
                                                    .change ??
                                                0,
                                            percentChange: state
                                                    .alertDetailsModel
                                                    .data
                                                    .percentChange ??
                                                0,
                                            qty: 500,
                                          ),
                                        );
                                      },
                                    );

                                    if (result == null) {
                                      return;
                                    }

                                    setState(() {
                                      _fetchRes = result.toString();
                                    });

                                    if (_fetchRes == 'true') {
                                      context
                                          .read<GetAlertDetailsCubit>()
                                          .fetchAlertDetails(
                                            AlertDetailsParams(
                                                symbol: widget.symbol),
                                          );
                                    }
                                  },
                                  splashColor: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        ' Edit price',
                                        style: baseTextStyle12500.copyWith(
                                            color: AppColors.primaryColor),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 24,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                      state.alertDetailsModel.data.news.isNotEmpty
                          ? Column(
                              children: [
                                const Gap(24),
                                SizedBox(
                                  height: 80,
                                  // width: 500,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: _pageController,
                                      itemCount: state
                                          .alertDetailsModel.data.news.length,
                                      itemBuilder: (context, index) {
                                        return SmartWatchlistNews(
                                          description: state
                                                  .alertDetailsModel
                                                  .data
                                                  .news[index]
                                                  .article
                                                  .description ??
                                              '',
                                          source: state.alertDetailsModel.data
                                                  .news[index].article.source ??
                                              '',
                                          date: state
                                                  .alertDetailsModel
                                                  .data
                                                  .news[index]
                                                  .article
                                                  .publishedAt ??
                                              0,
                                          sentiment: state
                                                  .alertDetailsModel
                                                  .data
                                                  .news[index]
                                                  .featuredHighlight
                                                  .entity
                                                  .sentimentScore ??
                                              0,
                                        );
                                      }),
                                ),
                              ],
                            )
                          : const Gap(1),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
