import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import '../../../../../data/models/equity/equity_explore/all_stocks.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/etf_stocks_cubit.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../component/equity_explore_sort_bottomsheet.dart';
import '../../../../../common/common.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_explore/all_stocks_cubit.dart';
import '../../component/stock_banner.dart';
import 'etf/etf_screen.dart';
import 'index_price_card_list.dart';

class ExploreScreen extends StatefulHookWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var result = EquityStockSortTypes.mcHighLow;
  late String selectedSort = '';
  List<String>? sectorResults;
  bool isSearchOpen = false;
  int pageCount = 1;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  late final ScrollController scrollController;
  bool _isLastPage = false;
  bool _loadError = false;

  String? filter;
  String? direction;
  String? sortBy;

  @override
  void initState() {
    super.initState();
    _setupScrollController();
    selectedSort = 'market_capitalization,DESC';
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  final smallcaseAuthToken =
                      context.watch<AuthCubit>().state.user?.smallcaseAuthToken;
                  if (smallcaseAuthToken != null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const Gap(20),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor),
                            color: Colors.blue[50]),
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Link to a broker account to start investing',
                              style: baseTextStyle14400,
                            ),
                            const Gap(32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 140,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.equityLogin,
                                      );
                                    },
                                    child: const Text('Get started'),
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        right: 2,
                                        bottom: 12,
                                        child: Text('+6 more'),
                                      ),
                                      Positioned(
                                        right: 70,
                                        child:
                                            Assets.pngs.equityGrowwBroker.image(
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                      Positioned(
                                        right: 95,
                                        child: Assets.pngs.equityExploreupstox
                                            .image(
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                      Positioned(
                                        child: Assets.pngs.equityExploreZerodha
                                            .image(
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Gap(12.0),
              const IndexPriceCardList(),
            ],
          ),
        ),
      ],
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.5,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
              indicatorColor: AppColors.primary[500]!,
              labelColor: AppColors.neutral[900],
              unselectedLabelColor: AppColors.neutral[400],
              tabs: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 6.0),
                  child: const Text('Equity'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 6.0),
                  child: const Text('ETF'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      if (!isSearchOpen) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 24.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0)),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (_) {
                                      return BlocProvider.value(
                                        value: context.read<AllStocksCubit>(),
                                        child: EquityExploreSort(
                                          equitySortType: result,
                                          sectors: sectorResults,
                                          selectedSectors: (value) =>
                                              sectorResults = value,
                                          selectedSort: (value) =>
                                              result = value,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Assets.icons.filterIcon
                                    .image(height: 24, width: 24),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() => isSearchOpen = !isSearchOpen);
                                },
                                child: Assets.icons.magnifierIcon
                                    .image(height: 24, width: 24),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Gap(20),
                            Expanded(
                              child: exploreOptions('Index', () {
                                Navigator.pushNamed(context, Routes.smartIndex);
                              }),
                            ),
                            const Gap(16),
                            Expanded(
                              child: exploreOptions('Subsidiary', () {
                                Navigator.pushNamed(
                                    context, Routes.smartSubsidiaryScreen);
                              }),
                            ),
                            const Gap(20),
                          ],
                        ),
                        const Gap(16),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: _textEditingController,
                            autofocus: true,
                            cursorColor: Colors.blue[50],
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (value) {
                              final filter = _textEditingController.text;
                              _handleFundFetch(
                                  isFirstFetch: true, filter: filter);
                            },
                            textAlign: TextAlign.justify,
                            focusNode: _searchFocusNode,
                            decoration: InputDecoration(
                              suffixIcon: isSearchOpen
                                  ? IconButton(
                                      onPressed: () {
                                        _handleFundFetch(
                                          isFirstFetch: true,
                                          sortBy: selectedSort,
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
                      BlocBuilder<AllStocksCubit, AllStocksState>(
                        builder: (context, state) {
                          bool isLoading = false;
                          List<AllStocksModel> stocks = [];
                          _loadError = false;

                          if (state is AllStocksLoading &&
                              state.isInitialLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is AllStocksFailure) {
                            _loadError = true;
                            isLoading = false;
                            return AppErrorWidget(
                              errorType: state.errorType,
                              error: state.errorMessage,
                              onRetry: () => _handleFundFetch(),
                            );
                          } else if (state is AllStocksLoading) {
                            isLoading = true;
                            stocks = state.oldStocksList;
                          } else if (state is AllStocksLoaded) {
                            stocks = state.allStocksModel;
                            _isLastPage = state.isLastPage;
                          }

                          return stocks.isEmpty
                              ? const Center(child: Text('No stocks found'))
                              : Expanded(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    shrinkWrap: true,
                                    itemCount:
                                        stocks.length + (isLoading ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      if (index == stocks.length) {
                                        return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        );
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 16.0),
                                        child: StockBanner(
                                          industry:
                                              stocks[index].industry ?? '',
                                          symbol: stocks[index].symbol ?? '',
                                          name: stocks[index].companyName ?? '',
                                          close: stocks[index].close ?? 0,
                                          change: stocks[index].change ?? 0,
                                          percentage:
                                              stocks[index].percentChange ?? 0,
                                          icon: stocks[index].icon ?? '',
                                        ),
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                      const Gap(24.0),
                    ],
                  ),
                  BlocProvider(
                    create: (context) => getIt<EtfStocksCubit>()..fetchETFs(),
                    child: const ETFScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exploreOptions(String title, VoidCallback function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral[50]!),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title == 'Index'
                ? Assets.pngs.indexLogo.image(width: 22, height: 22)
                : Assets.pngs.subsidiaryLogo.image(width: 22, height: 22),
            const Gap(14),
            Text(
              title,
              style:
                  baseTextStyle14400.copyWith(color: const Color(0xFF2C3137)),
            ),
          ],
        ),
      ),
    );
  }

  void _setupScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          150) {
        if (scrollController.position.pixels != 0 &&
            !_isLastPage &&
            !_loadError) {
          _handleFundFetch();
        }
      }
    });
  }

  void _handleFundFetch({
    bool isFirstFetch = false,
    String? filter,
    String? direction,
    String? sortBy,
    String? sectors,
  }) {
    context.read<AllStocksCubit>().fetchStocks(
          page: isFirstFetch ? 0 : null,
          filter: filter?.toUpperCase(),
          direction: direction,
          sortBy: sortBy,
          sectors: sectors,
        );
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }
}
