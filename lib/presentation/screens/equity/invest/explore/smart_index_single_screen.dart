import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../../../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_smart_filtering/cubit/filter_by_index_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/amount_widget.dart';
import '../../../../widgets/widgets.dart';
import '../../component/smart_index_sort.dart';
import '../../component/stock_banner.dart';

class SmartIndexSingleDetailScreen extends StatefulWidget {
  const SmartIndexSingleDetailScreen({
    super.key,
    required this.index,
  });
  final String index;

  @override
  State<SmartIndexSingleDetailScreen> createState() =>
      _SmartIndexSingleDetailScreenState();
}

class _SmartIndexSingleDetailScreenState
    extends State<SmartIndexSingleDetailScreen> {
  IndexDetails? _indexDetails;

  EquityStockSortTypes selectedSort = EquityStockSortTypes.highLow;
  bool isSearchOpen = false;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  late final ScrollController _scrollController;
  bool _isLastPage = false;
  bool _loadingError = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          150) {
        if (_scrollController.position.pixels != 0 &&
            !_isLastPage &&
            !_loadingError) {
          _handleFundFetch();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FilterByIndexCubit, FilterByIndexState>(
          builder: (context, state) {
            if (_indexDetails != null) {
              return Text(_indexDetails!.name);
            }

            if (state is FilterByIndexSuccess) {
              _indexDetails = state.stocksByIndex.index;

              return Text(state.stocksByIndex.index.name);
            }
            return const SizedBox();
          },
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<FilterByIndexCubit, FilterByIndexState>(
            builder: (context, state) {
              if (_indexDetails != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _IndexContainer(bannerData: _indexDetails!),
                );
              }

              if (state is FilterByIndexSuccess) {
                final IndexDetails bannerData = state.stocksByIndex.index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _IndexContainer(bannerData: bannerData),
                );
              }

              return const SizedBox();
            },
          ),
          if (!isSearchOpen) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 18.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext _) {
                          return BlocProvider.value(
                            value: context.read<FilterByIndexCubit>(),
                            child: SmartIndexSortBottomsheet(
                              equitySortType: selectedSort,
                              index: widget.index,
                              selectedSort: (value) => selectedSort = value,
                            ),
                          );
                        },
                      );
                    },
                    child: Assets.icons.filterIcon.image(height: 24, width: 24),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSearchOpen = !isSearchOpen;
                      });
                    },
                    child: Assets.icons.magnifierIcon.image(
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            )
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _textEditingController,
                autofocus: true,
                cursorColor: Colors.blue[50],
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  final filter = _textEditingController.text;
                  _handleFundFetch(
                    isFirstFetch: true,
                    filter: filter,
                  );
                },
                textAlign: TextAlign.justify,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  suffixIcon: isSearchOpen
                      ? IconButton(
                          onPressed: () {
                            _handleFundFetch(
                              isFirstFetch: true,
                              sort: selectedSort,
                            );
                            setState(() {
                              _textEditingController.clear();
                              isSearchOpen = !isSearchOpen;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Icon(
                          Icons.search,
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle: baseTextStyle2.copyWith(
                      color: AppColors.textLightGrey, fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                ),
              ),
            )
          ],
          BlocBuilder<FilterByIndexCubit, FilterByIndexState>(
            builder: (context, state) {
              bool isLoading = false;
              List<SubsidiaryModel> stocks = [];
              _loadingError = false;

              if (state is FilterByIndexLoading && state.isInitialLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is FilterByIndexFailure) {
                _loadingError = true;
                isLoading = false;
                return Center(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    error: state.errorMessage,
                    onRetry: () => context
                        .read<FilterByIndexCubit>()
                        .filterByIndex(index: widget.index),
                  ),
                );
              } else if (state is FilterByIndexLoading) {
                isLoading = true;
                stocks = state.oldStocksList;
              } else if (state is FilterByIndexSuccess) {
                stocks = state.stocksByIndex.indexInstruments;
                _isLastPage = state.isLastPage;
              }

              if (stocks.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: stocks.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) => index == stocks.length
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : Column(
                            children: [
                              StockBanner(
                                industry: stocks[index].industry ?? '',
                                symbol: stocks[index].symbol ?? '',
                                name: stocks[index].companyName ?? '',
                                icon: stocks[index].icon ?? '',
                                close: stocks[index].close ?? 0.0,
                                change: stocks[index].change ?? 0.0,
                                percentage: stocks[index].percentChange ?? 0.0,
                              ),
                              const Gap(16),
                            ],
                          ),
                  ),
                );
              } else {
                return const Center(child: Text('No stocks found'));
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleFundFetch({
    bool isFirstFetch = false,
    String? filter,
    EquityStockSortTypes? sort,
  }) {
    context.read<FilterByIndexCubit>().filterByIndex(
          index: widget.index,
          page: isFirstFetch ? 0 : null,
          sort: sort?.toString() ?? EquityStockSortTypes.highLow.toString(),
          filter: filter,
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _IndexContainer extends StatefulWidget {
  const _IndexContainer({required this.bannerData});
  final IndexDetails bannerData;

  @override
  State<_IndexContainer> createState() => __IndexContainerState();
}

class __IndexContainerState extends State<_IndexContainer> {
  EquityExploreBannerTimePeriod currentTimePeriod =
      EquityExploreBannerTimePeriod.daily;
  late double _price;
  late double _priceChange;
  late double _pricePercentageChange;

  @override
  void initState() {
    super.initState();
    _price = widget.bannerData.close;
    _priceChange = widget.bannerData.oneDayChange;
    _pricePercentageChange = widget.bannerData.oneDayPercentChange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                widget.bannerData.name,
                style: baseTextStyle14500.copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(12.0),
              GestureDetector(
                onTap: () {
                  if (currentTimePeriod ==
                      EquityExploreBannerTimePeriod.daily) {
                    setState(() {
                      currentTimePeriod = EquityExploreBannerTimePeriod.weekly;
                      _priceChange = widget.bannerData.oneWeekChange;
                      _pricePercentageChange =
                          widget.bannerData.oneWeekPercentChange;
                    });
                  } else if (currentTimePeriod ==
                      EquityExploreBannerTimePeriod.weekly) {
                    setState(() {
                      currentTimePeriod = EquityExploreBannerTimePeriod.monthly;
                      _priceChange = widget.bannerData.oneMonthChange;
                      _pricePercentageChange =
                          widget.bannerData.oneMonthPercentChange;
                    });
                  } else if (currentTimePeriod ==
                      EquityExploreBannerTimePeriod.monthly) {
                    setState(() {
                      currentTimePeriod = EquityExploreBannerTimePeriod.yearly;
                      _priceChange = widget.bannerData.oneYearChange;
                      _pricePercentageChange =
                          widget.bannerData.oneYearPercentChange;
                    });
                  } else if (currentTimePeriod ==
                      EquityExploreBannerTimePeriod.yearly) {
                    setState(() {
                      currentTimePeriod = EquityExploreBannerTimePeriod.daily;
                      _priceChange = widget.bannerData.oneDayChange;
                      _pricePercentageChange =
                          widget.bannerData.oneDayPercentChange;
                    });
                  }
                },
                child: Row(
                  children: [
                    Assets.icons.dayChangeIcon.image(width: 16.0),
                    const Gap(8.0),
                    Text(
                      _getIndexFrame(),
                      style: baseTextStyle14500.copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '${_priceChange.isNegative ? '' : '+'}'
                '${_priceChange.toStringAsFixed(2)}',
                style: baseTextStyle12500.copyWith(
                    color: _priceChange.isNegative
                        ? AppColors.error[500]
                        : AppColors.success[500]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Gap(4.0),
          Row(
            children: [
              Expanded(
                child: AmountWidget(
                  amount: _price,
                  style: baseTextStyle14400.copyWith(
                      color: _price.isNegative
                          ? AppColors.error[500]
                          : AppColors.success[500]),
                ),
              ),
              Text(
                '(${_pricePercentageChange.isNegative ? '' : '+'}'
                '${_pricePercentageChange.toStringAsFixed(2)}%)',
                style: baseTextStyle12500.copyWith(
                    color: _pricePercentageChange.isNegative
                        ? AppColors.error[500]
                        : AppColors.success[500]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIndexFrame() {
    switch (currentTimePeriod) {
      case EquityExploreBannerTimePeriod.daily:
        return ('1D');
      case EquityExploreBannerTimePeriod.weekly:
        return ('1W');
      case EquityExploreBannerTimePeriod.monthly:
        return ('1M');
      case EquityExploreBannerTimePeriod.yearly:
        return ('1Y');
    }
  }
}
