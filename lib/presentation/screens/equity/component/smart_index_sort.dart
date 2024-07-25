import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../../domain/entities/enums.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/filter_by_index_cubit.dart';
import '../../../theme/app_colors.dart';

class SmartIndexSortBottomsheet extends StatefulWidget {
  final EquityStockSortTypes equitySortType;
  final String index;
  final Function(EquityStockSortTypes) selectedSort;

  const SmartIndexSortBottomsheet({
    super.key,
    required this.equitySortType,
    required this.index,
    required this.selectedSort,
  });

  @override
  State<SmartIndexSortBottomsheet> createState() =>
      _SmartIndexSortBottomsheetState();
}

class _SmartIndexSortBottomsheetState extends State<SmartIndexSortBottomsheet> {
  late EquityStockSortTypes _type;

  @override
  void initState() {
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
                Text('Sort By', style: baseTextStyle2),
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
                          _handleSort(sort: EquityStockSortTypes.dse);
                        } else if (_type == EquityStockSortTypes.dse) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                          _handleSort(sort: EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.ase;
                          widget.selectedSort(EquityStockSortTypes.ase);
                          _handleSort(sort: EquityStockSortTypes.ase);
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
                          _handleSort(sort: EquityStockSortTypes.mphighLow);
                        } else if (_type == EquityStockSortTypes.mphighLow) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                          _handleSort(sort: EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.mplowHigh;
                          widget.selectedSort(EquityStockSortTypes.mplowHigh);
                          _handleSort(sort: EquityStockSortTypes.mplowHigh);
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
                        if (_type == EquityStockSortTypes.lowHigh) {
                          _type = EquityStockSortTypes.highLow;
                          widget.selectedSort(EquityStockSortTypes.highLow);
                          _handleSort(sort: EquityStockSortTypes.highLow);
                        } else if (_type == EquityStockSortTypes.highLow) {
                          _type = EquityStockSortTypes.noOrder;
                          widget.selectedSort(EquityStockSortTypes.noOrder);
                          _handleSort(sort: EquityStockSortTypes.noOrder);
                        } else {
                          _type = EquityStockSortTypes.lowHigh;
                          widget.selectedSort(EquityStockSortTypes.lowHigh);
                          _handleSort(sort: EquityStockSortTypes.lowHigh);
                        }
                      });
                    },
                    child: _type == EquityStockSortTypes.lowHigh
                        ? Assets.pngs.blueArrow.image(width: 24, height: 24)
                        : (_type == EquityStockSortTypes.highLow)
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

  void _handleSort({
    EquityStockSortTypes? sort,
  }) {
    context.read<FilterByIndexCubit>().filterByIndex(
          page: 0,
          isInitialLoading: true,
          index: widget.index,
          sort: sort?.toString() ?? EquityStockSortTypes.highLow.toString(),
        );
  }
}
