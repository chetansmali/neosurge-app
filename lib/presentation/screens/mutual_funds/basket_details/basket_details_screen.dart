import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/neobaskets/basket_details.dart';
import '../../../../domain/entities/params/neobaskets/basket_details_params.dart';
import '../../../../domain/entities/params/neobaskets/get_basket_chart_params.dart';
import '../../../cubits/neobaskets/basket_chart/basket_chart_cubit.dart';
import '../../../cubits/neobaskets/neobasket_discovery_details/basket_details_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../widgets/basket_custom_container.dart';
import '../widgets/neo_basket_tile.dart';
import '../widgets/scheme_detail_card.dart';

class BasketDetailScreen extends StatefulWidget {
  const BasketDetailScreen({
    super.key,
    required this.basketId,
  });

  final String basketId;

  @override
  State<BasketDetailScreen> createState() => _BasketDetailScreenState();
}

class _BasketDetailScreenState extends State<BasketDetailScreen> {
  late BasketDetailsModel basketDetailsModel;

  @override
  void initState() {
    super.initState();
    context.read<BasketDetailsCubit>().getBasketDetails(
          BasketDetailsParams(
            basketId: widget.basketId,
          ),
        );

    context.read<BasketChartCubit>().getBasketChartData(
          GetBasketChartParams(
            basketId: widget.basketId,
            duration: '1Y',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(double.infinity, 56),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.buyBasketScreen,
                      arguments: BasketOrderArgs(
                        basketDetails: basketDetailsModel,
                      ),
                    );
                  },
                  child: const Text(
                    'Buy basket',
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<BasketDetailsCubit, BasketDetailsState>(
          builder: (context, state) {
            if (state is BasketDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is BasketDetailsFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () =>
                    context.read<BasketDetailsCubit>().getBasketDetails(
                          BasketDetailsParams(
                            basketId: widget.basketId,
                          ),
                        ),
              );
            }

            if (state is BasketDetailsSuccess) {
              basketDetailsModel = state.basketDetailsModel;

              return Column(
                children: [
                  NeoBasketTile(
                    onTap: () {},
                    basketName: basketDetailsModel.name,
                    basketDescription: basketDetailsModel.name,
                    cagr: basketDetailsModel.cagr,
                    minSip: basketDetailsModel.minSip,
                    aum: basketDetailsModel.aum ?? 0,
                    imageUrl: basketDetailsModel.imageUrl ?? '',
                  ),
                  BasketCustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'About this basket',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          basketDetailsModel.aboutBasket ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF47586E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _BasketPerformanceChart(
                    basketId: basketDetailsModel.basketId ?? '',
                    sixM: basketDetailsModel.sixM,
                    oneY: basketDetailsModel.oneY,
                    threeY: basketDetailsModel.threeY,
                    fiveY: basketDetailsModel.fiveY,
                  ),
                  BasketCustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Funds in this basket (${basketDetailsModel.basketFunds.length})',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Gap(10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: basketDetailsModel.basketFunds.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return BasketSchemeDetailCard(
                              basketFund: basketDetailsModel.basketFunds[index],
                              animatedCard: true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BasketCustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Why this basket?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Gap(10),
                        const Divider(
                          thickness: 1,
                        ),
                        const Gap(10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: basketDetailsModel.whyInvest.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                _WhyThisBasketPointTile(
                                  title: basketDetailsModel.whyInvest[index],
                                ),
                                const Gap(22),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const BasketCustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Disclaimer',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Gap(10),
                        Text(
                          'Mutual Funds are subject to market risk. Please consult your financial advisor or CA before making any investments.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF47586E),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(100),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _WhyThisBasketPointTile extends StatelessWidget {
  const _WhyThisBasketPointTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xFF43B649),
        ),
        const Gap(10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF47586E),
            ),
          ),
        )
      ],
    );
  }
}

class _BasketPerformanceChart extends StatefulWidget {
  const _BasketPerformanceChart({
    Key? key,
    required this.basketId,
    required this.sixM,
    required this.oneY,
    required this.threeY,
    required this.fiveY,
  }) : super(key: key);

  final String basketId;
  final bool sixM;
  final bool oneY;
  final bool threeY;
  final bool fiveY;

  @override
  State<_BasketPerformanceChart> createState() =>
      _BasketPerformanceChartState();
}

class _BasketPerformanceChartState extends State<_BasketPerformanceChart> {
  String selectedDuration = '1Y';

  @override
  void initState() {
    super.initState();
    if (widget.sixM) {
      selectedDuration = '6M';
    } else if (widget.oneY) {
      selectedDuration = '1Y';
    } else if (widget.threeY) {
      selectedDuration = '3Y';
    } else if (widget.fiveY) {
      selectedDuration = '5Y';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 18,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryViolet,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const Gap(8),
                const Text(
                  'Basket',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                // const Gap(16),
                // Container(
                //   height: 4,
                //   width: 18,
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFB0B0B0),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
                // const Gap(8),
                // const Text(
                //   'Nifty',
                //   style: TextStyle(
                //     fontSize: 10,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
          const Gap(82),
          BlocBuilder<BasketChartCubit, BasketChartState>(
            builder: (context, state) {
              if (state is BasketChartLoading) {
                return const SizedBox(
                  height: 124,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (state is BasketChartFailure) {
                return AppErrorWidget(
                  errorType: state.appErrorType,
                  error: state.message,
                  onRetry: () =>
                      context.read<BasketChartCubit>().getBasketChartData(
                            GetBasketChartParams(
                              basketId: widget.basketId,
                              duration: selectedDuration,
                            ),
                          ),
                );
              }

              if (state is BasketChartSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 100,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            dotData: const FlDotData(
                              show: false,
                            ),
                            spots:
                                state.basketChartResponse.basketChartDataList ??
                                    [],
                            color: AppColors.secondaryViolet,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFBFD1FD),
                                  const Color(0xFFBFD1FD).withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                          // Nifty Chart Data
                          // LineChartBarData(
                          //   dotData: const FlDotData(
                          //     show: false,
                          //   ),
                          //   color: const Color(0xFFB0B0B0),
                          //   dashArray: const [5, 2],
                          //   spots: [
                          //     const FlSpot(0, 1 / 3),
                          //     const FlSpot(1, 2 / 3),
                          //     const FlSpot(2, 1.4 / 3),
                          //     const FlSpot(3, 3 / 3),
                          //     const FlSpot(4, 5 / 3),
                          //     const FlSpot(5, 2.2 / 3),
                          //     const FlSpot(6, 1.8 / 3),
                          //     const FlSpot(7, 1.9 / 3),
                          //     const FlSpot(8, 2 / 3),
                          //     const FlSpot(9, 1.7 / 3),
                          //     const FlSpot(10, 1.6 / 3),
                          //     const FlSpot(11, 2.2 / 3),
                          //     const FlSpot(12, 2.4 / 3),
                          //     const FlSpot(13, 1.9 / 3),
                          //     const FlSpot(14, 1.5 / 3),
                          //     const FlSpot(15, 1.7 / 3),
                          //     const FlSpot(16, 3.6 / 3),
                          //     const FlSpot(17, 2.2 / 3),
                          //     const FlSpot(18, 1.8 / 3),
                          //     const FlSpot(19, 1.9 / 3),
                          //     const FlSpot(20, 1.5 / 3),
                          //     const FlSpot(21, 1.7 / 3),
                          //     const FlSpot(22, 1.6 / 3),
                          //     const FlSpot(23, 2.2 / 3),
                          //     const FlSpot(24, 1.8 / 3),
                          //     const FlSpot(25, 1.9 / 3),
                          //     const FlSpot(26, 1.5 / 3),
                          //     const FlSpot(27, 1.7 / 3),
                          //     const FlSpot(28, 1.6 / 3),
                          //     const FlSpot(29, 2.2 / 3),
                          //     const FlSpot(30, 1.8 / 3),
                          //   ],
                          // )
                        ],
                        lineTouchData: const LineTouchData(
                          enabled: false,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        gridData: const FlGridData(
                          show: false,
                        ),
                        titlesData: const FlTitlesData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Gap(34),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.sixM)
                InkWell(
                  onTap: () {
                    context.read<BasketChartCubit>().getBasketChartData(
                          GetBasketChartParams(
                            basketId: widget.basketId,
                            duration: '6M',
                          ),
                        );
                    setState(() {
                      selectedDuration = '6M';
                    });
                  },
                  child: Chip(
                    label: Text(
                      '6M',
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedDuration == '6M' ? Colors.white : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: selectedDuration == '6M'
                        ? AppColors.secondaryViolet
                        : Colors.white,
                  ),
                ),
              if (widget.oneY)
                InkWell(
                  onTap: () {
                    context.read<BasketChartCubit>().getBasketChartData(
                          GetBasketChartParams(
                            basketId: widget.basketId,
                            duration: '1Y',
                          ),
                        );
                    setState(() {
                      selectedDuration = '1Y';
                    });
                  },
                  child: Chip(
                    label: Text(
                      '1Y',
                      style: TextStyle(
                        color: selectedDuration == '1Y' ? Colors.white : null,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: selectedDuration == '1Y'
                        ? AppColors.secondaryViolet
                        : Colors.white,
                  ),
                ),
              if (widget.threeY)
                InkWell(
                  onTap: () {
                    context.read<BasketChartCubit>().getBasketChartData(
                          GetBasketChartParams(
                            basketId: widget.basketId,
                            duration: '3Y',
                          ),
                        );
                    setState(() {
                      selectedDuration = '3Y';
                    });
                  },
                  child: Chip(
                    label: Text(
                      '3Y',
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedDuration == '3Y' ? Colors.white : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: selectedDuration == '3Y'
                        ? AppColors.secondaryViolet
                        : Colors.white,
                  ),
                ),
              if (widget.fiveY)
                InkWell(
                  onTap: () {
                    context.read<BasketChartCubit>().getBasketChartData(
                          GetBasketChartParams(
                            basketId: widget.basketId,
                            duration: '5Y',
                          ),
                        );
                    setState(() {
                      selectedDuration = '5Y';
                    });
                  },
                  child: Chip(
                    label: Text(
                      '5Y',
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedDuration == '5Y' ? Colors.white : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: selectedDuration == '5Y'
                        ? AppColors.secondaryViolet
                        : Colors.white,
                  ),
                ),
            ],
          ),
          const Gap(16),
          BlocBuilder<BasketChartCubit, BasketChartState>(
              builder: (context, state) {
            if (state is BasketChartLoading) {
              return const SizedBox.shrink();
            }
            if (state is BasketChartSuccess &&
                state.basketChartResponse.returns != null) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '₹ 1L invested for $selectedDuration years would have been',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(4),
                    AmountWidget(
                      amount: state.basketChartResponse.returns!,
                      isCompact: false,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF43B649),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
