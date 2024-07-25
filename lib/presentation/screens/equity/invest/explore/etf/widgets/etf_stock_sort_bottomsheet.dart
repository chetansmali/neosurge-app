import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../../di/get_it.dart';
import '../../../../../../../domain/entities/enums.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../cubits/equity/etf_fund_houses_cubit.dart';
import '../../../../../../cubits/equity/etf_stocks_cubit.dart';
import '../../../../../../theme/app_colors.dart';
import '../etf_filter_screen.dart';

class ETFStockSortBottomsheet extends StatefulWidget {
  final ETFStockSortTypes equitySortType;
  final Function(ETFStockSortTypes) selectedSort;
  final Function(List<String>) selectedFundHouse;
  final List<String> fundHouses;

  const ETFStockSortBottomsheet({
    super.key,
    required this.equitySortType,
    required this.selectedSort,
    required this.selectedFundHouse,
    required this.fundHouses,
  });

  @override
  State<ETFStockSortBottomsheet> createState() =>
      _ETFStockSortBottomsheetState();
}

class _ETFStockSortBottomsheetState extends State<ETFStockSortBottomsheet> {
  late ETFStockSortTypes _type;
  List<String>? fundHouses;

  @override
  void initState() {
    fundHouses = widget.fundHouses;
    _type = widget.equitySortType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter', style: baseTextStyle2),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: AppColors.neutral[700],
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const Gap(20),
            GestureDetector(
              onTap: () async {
                await Navigator.push<List<String>?>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<EtfFundHousesCubit>()..getFundHouses(),
                          ),
                          BlocProvider.value(
                            value: context.read<EtfStocksCubit>(),
                          ),
                        ],
                        child: ETFFilterScreen(
                          selectedFundHouses: fundHouses,
                          selectedFilters: (value) => fundHouses = value,
                          selectedSort: _type.toString(),
                        ),
                      ),
                    ));
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: fundHouses!.isNotEmpty
                          ? AppColors.primary[500]!
                          : AppColors.neutral[300]!),
                  color: fundHouses!.isNotEmpty ? AppColors.primary[50] : null,
                ),
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(2),
                child: Text(
                  fundHouses!.isNotEmpty ? 'Fund House' : 'Apply Filters',
                  style: baseTextStyle14400.copyWith(
                      color: fundHouses!.isNotEmpty
                          ? AppColors.primary[500]
                          : AppColors.neutral[300]),
                ),
              ),
            ),
            const Gap(20),
            const Divider(),
            const Gap(20),
            Text('Sort By', style: baseTextStyle2),
            const Gap(20),
            Row(
              children: [
                Text('A - Z',
                    style: baseTextStyle14400.copyWith(
                        color: AppColors.neutral[400])),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (_type == ETFStockSortTypes.symbolDesc) {
                      setState(() => _type = ETFStockSortTypes.symbolAsc);
                      widget.selectedSort(ETFStockSortTypes.symbolAsc);
                      _handleFundFetch(
                        sort: ETFStockSortTypes.symbolAsc,
                        isFirstFetch: true,
                      );
                    } else {
                      setState(() => _type = ETFStockSortTypes.symbolDesc);
                      widget.selectedSort(ETFStockSortTypes.symbolDesc);
                      _handleFundFetch(
                        sort: ETFStockSortTypes.symbolDesc,
                        isFirstFetch: true,
                      );
                    }
                  },
                  child: (_type == ETFStockSortTypes.symbolAsc ||
                          _type == ETFStockSortTypes.symbolDesc)
                      ? _type == ETFStockSortTypes.symbolAsc
                          ? Assets.icons.sortAse.svg(height: 24)
                          : Assets.icons.sortDse.svg(height: 24)
                      : Assets.icons.sortByAlphabet.svg(height: 24),
                ),
              ],
            ),
            const Gap(8.0),
            Row(
              children: [
                Text('Market Price',
                    style: baseTextStyle14400.copyWith(
                        color: AppColors.neutral[400])),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (_type == ETFStockSortTypes.closeDesc) {
                      setState(() => _type = ETFStockSortTypes.closeAsc);
                      widget.selectedSort(ETFStockSortTypes.closeAsc);
                      _handleFundFetch(
                        sort: ETFStockSortTypes.closeAsc,
                        isFirstFetch: true,
                      );
                    } else {
                      setState(() => _type = ETFStockSortTypes.closeDesc);
                      widget.selectedSort(ETFStockSortTypes.closeDesc);
                      _handleFundFetch(
                        sort: ETFStockSortTypes.closeDesc,
                        isFirstFetch: true,
                      );
                    }
                  },
                  child: (_type == ETFStockSortTypes.closeAsc ||
                          _type == ETFStockSortTypes.closeDesc)
                      ? _type == ETFStockSortTypes.closeAsc
                          ? Assets.icons.sortAse.svg(height: 24)
                          : Assets.icons.sortDse.svg(height: 24)
                      : Assets.icons.sortByPrice.svg(height: 24),
                ),
              ],
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  void _handleFundFetch({
    bool isFirstFetch = false,
    String? filter,
    ETFStockSortTypes? sort,
  }) {
    context.read<EtfStocksCubit>().fetchETFs(
          page: isFirstFetch ? 0 : null,
          filter: filter,
          sort: sort?.toString() ?? ETFStockSortTypes.closeDesc.toString(),
        );
  }
}
