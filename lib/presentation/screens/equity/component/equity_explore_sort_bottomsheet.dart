import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/equity/equity_explore/all_stocks_cubit.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/get_sectors_and_industries_cubit.dart';
import '../../../theme/app_colors.dart';
import 'smart_filter.dart';

class EquityExploreSort extends StatefulWidget {
  final EquityStockSortTypes equitySortType;
  final Function(EquityStockSortTypes) selectedSort;
  final List<String>? sectors;
  final Function(List<String>?) selectedSectors;

  const EquityExploreSort({
    super.key,
    required this.equitySortType,
    required this.selectedSort,
    required this.sectors,
    required this.selectedSectors,
  });

  @override
  State<EquityExploreSort> createState() => _EquityExploreSortState();
}

class _EquityExploreSortState extends State<EquityExploreSort> {
  late EquityStockSortTypes _type;
  List<String>? sectors;

  @override
  void initState() {
    _type = widget.equitySortType;
    if (widget.sectors != null) {
      sectors = widget.sectors;
    }
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
          children: [
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
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) =>
                                  getIt<GetSectorsAndIndustriesCubit>()
                                    ..getSectorAndIndustry(),
                              child: BlocProvider.value(
                                value: context.read<AllStocksCubit>(),
                                child: EquitySmartFilterScreen(
                                  selectedFundHouses: sectors,
                                  selectedSectors: (value) => sectors = value,
                                  selectedSort: _type.toString(),
                                ),
                              ),
                            )));
                widget.selectedSectors(sectors);
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: sectors != null
                          ? AppColors.primary[500]!
                          : AppColors.neutral[300]!),
                  color: sectors != null ? AppColors.primary[50] : null,
                ),
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(2),
                child: Text(
                  'Sector',
                  style: baseTextStyle14400.copyWith(
                      color: sectors != null
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'A-Z',
                  style: baseTextStyle14400,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (_type == EquityStockSortTypes.ase) {
                          _type = EquityStockSortTypes.dse;
                          widget.selectedSort(EquityStockSortTypes.dse);
                          _handleFundFetch(
                            direction: 'DESC',
                            isFirstFetch: true,
                          );
                        } else if (_type == EquityStockSortTypes.dse) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.ase;
                          widget.selectedSort(EquityStockSortTypes.ase);
                          _handleFundFetch(
                            direction: 'ASC',
                            isFirstFetch: true,
                          );
                        }
                      });
                    },
                    child: _type == EquityStockSortTypes.ase
                        ? Assets.pngs.blueArrow.image(width: 24, height: 24)
                        : (_type == EquityStockSortTypes.dse)
                            ? RotatedBox(
                                quarterTurns: 2,
                                child: Assets.pngs.blueArrow
                                    .image(width: 24, height: 24))
                            : Assets.pngs.atoZ.image(width: 24, height: 24))
              ],
            ),
            const Gap(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Price',
                  style: baseTextStyle14400,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (_type == EquityStockSortTypes.mplowHigh) {
                          _type = EquityStockSortTypes.mphighLow;
                          widget.selectedSort(EquityStockSortTypes.mphighLow);
                          _handleFundFetch(
                            direction: 'DESC',
                            sortBy: 'close',
                            isFirstFetch: true,
                          );
                        } else if (_type == EquityStockSortTypes.mphighLow) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.mplowHigh;
                          widget.selectedSort(EquityStockSortTypes.mplowHigh);
                          _handleFundFetch(
                            direction: 'ASC',
                            sortBy: 'close',
                            isFirstFetch: true,
                          );
                        }
                      });
                    },
                    child: _type == EquityStockSortTypes.mplowHigh
                        ? Assets.pngs.blueArrow.image(width: 24, height: 24)
                        : (_type == EquityStockSortTypes.mphighLow)
                            ? RotatedBox(
                                quarterTurns: 2,
                                child: Assets.pngs.blueArrow
                                    .image(width: 24, height: 24))
                            : Assets.pngs.marketPrice
                                .image(width: 24, height: 24))
              ],
            ),
            const Gap(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Cap',
                  style: baseTextStyle14400,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (_type == EquityStockSortTypes.mcLowHigh) {
                          _type = EquityStockSortTypes.mcHighLow;
                          widget.selectedSort(EquityStockSortTypes.mcHighLow);
                          _handleFundFetch(
                            direction: 'DESC',
                            sortBy: 'market_capitalization',
                            isFirstFetch: true,
                          );
                        } else if (_type == EquityStockSortTypes.mcHighLow) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.mcLowHigh;
                          widget.selectedSort(EquityStockSortTypes.mcLowHigh);
                          _handleFundFetch(
                            direction: 'ASC',
                            sortBy: 'market_capitalization',
                            isFirstFetch: true,
                          );
                        }
                      });
                    },
                    child: _type == EquityStockSortTypes.mcLowHigh
                        ? Assets.pngs.blueArrow.image(width: 24, height: 24)
                        : (_type == EquityStockSortTypes.mcHighLow)
                            ? RotatedBox(
                                quarterTurns: 2,
                                child: Assets.pngs.blueArrow
                                    .image(width: 24, height: 24))
                            : Assets.pngs.marketCap
                                .image(width: 24, height: 24))
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
}
