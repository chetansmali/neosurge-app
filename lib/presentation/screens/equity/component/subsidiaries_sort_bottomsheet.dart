import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/equity/smart_filter_subsidiaries/get_subsidiaries_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/equity/smart_filter_subsidiaries/cubit/get_subsidiaries_cubit.dart';
import '../../../theme/app_colors.dart';

class SubsidiariesSortStocks extends StatefulWidget {
  final String businessHouse;
  final EquityStockSortTypes equitySortType;
  final Function(EquityStockSortTypes) selectedSort;

  const SubsidiariesSortStocks({
    super.key,
    required this.businessHouse,
    required this.equitySortType,
    required this.selectedSort,
  });

  @override
  State<SubsidiariesSortStocks> createState() => _SubsidiariesSortStocksState();
}

class _SubsidiariesSortStocksState extends State<SubsidiariesSortStocks> {
  late EquityStockSortTypes _type;
  List<String>? sectors;

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
          children: [
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sort By', style: baseTextStyle2),
                IconButton(
                  onPressed: () => Navigator.pop(context, _type),
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
                          _handleSort(direction: 'DESC', sortBy: 'symbol');
                        } else {
                          _type = EquityStockSortTypes.ase;
                          widget.selectedSort(EquityStockSortTypes.ase);
                          _handleSort(direction: 'ASC', sortBy: 'symbol');
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
                          _handleSort(direction: 'DESC', sortBy: 'close');
                        } else {
                          _type = EquityStockSortTypes.mplowHigh;
                          widget.selectedSort(EquityStockSortTypes.mplowHigh);
                          _handleSort(direction: 'ASC', sortBy: 'close');
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
                          _handleSort(
                              direction: 'DESC',
                              sortBy: 'marketCapitalization');
                        } else {
                          _type = EquityStockSortTypes.lowHigh;
                          widget.selectedSort(EquityStockSortTypes.lowHigh);
                          _handleSort(
                              direction: 'ASC', sortBy: 'marketCapitalization');
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
    String? direction,
    String? sortBy,
  }) {
    context.read<GetSubsidiariesCubit>().getSubsidiaries(
          GetSubsidiariesParams(
            businessHouse: widget.businessHouse,
            page: 0,
            size: 100,
            sort: '$sortBy,$direction',
          ),
        );
  }
}
