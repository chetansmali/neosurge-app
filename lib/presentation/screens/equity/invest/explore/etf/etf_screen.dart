import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../data/models/equity/etf_stocks.dart';
import '../../../../../../domain/entities/enums.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/equity/etf_stocks_cubit.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/widgets.dart';
import 'widgets/etf_stock_sort_bottomsheet.dart';
import 'widgets/etf_stock_tile.dart';

class ETFScreen extends StatefulWidget {
  const ETFScreen({super.key});

  @override
  State<ETFScreen> createState() => _ETFScreenState();
}

class _ETFScreenState extends State<ETFScreen> {
  ETFStockSortTypes selectedSort = ETFStockSortTypes.closeDesc;
  List<String> selectedFundHouse = [];
  bool isSearchOpen = false;
  int pageCount = 1;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

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

  void _handleFundFetch({
    bool isFirstFetch = false,
    String? filter,
    ETFStockSortTypes? sort,
  }) {
    context.read<EtfStocksCubit>().fetchETFs(
          page: isFirstFetch ? 0 : null,
          filter: filter?.toUpperCase(),
          sort: sort?.toString() ?? ETFStockSortTypes.closeDesc.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                          value: context.read<EtfStocksCubit>(),
                          child: ETFStockSortBottomsheet(
                            equitySortType: selectedSort,
                            selectedSort: (value) => selectedSort = value,
                            selectedFundHouse: (value) =>
                                selectedFundHouse = value,
                            fundHouses: selectedFundHouse,
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
                _handleFundFetch(isFirstFetch: true, filter: filter);
              },
              textAlign: TextAlign.justify,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                suffixIcon: isSearchOpen
                    ? IconButton(
                        onPressed: () {
                          _handleFundFetch(
                            isFirstFetch: true,
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
        BlocBuilder<EtfStocksCubit, EtfStocksState>(
          builder: (context, state) {
            bool isLoading = false;
            List<ETFStocksModel> stocks = [];
            _loadingError = false;

            if (state is EtfStocksLoading && state.isInitialLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is EtfStocksFailure) {
              _loadingError = true;
              isLoading = false;
              return Center(
                child: AppErrorWidget(
                  errorType: state.errorType,
                  error: state.errorMessage,
                  onRetry: () => context.read<EtfStocksCubit>().fetchETFs(),
                ),
              );
            } else if (state is EtfStocksLoading) {
              isLoading = true;
              stocks = state.oldStocksList;
            } else if (state is EtfStocksLoaded) {
              stocks = state.etfStocksModel;
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
                            ETFStockTile(
                              symbol: stocks[index].symbol ?? '',
                              name: stocks[index].name ?? '',
                              imageUrl: stocks[index].icon ?? '',
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
