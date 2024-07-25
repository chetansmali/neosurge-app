import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class SortStocks extends StatefulWidget {
  final EquityStockSortTypes equitySortType;

  const SortStocks({super.key, required this.equitySortType});

  @override
  State<SortStocks> createState() => _SortStocksState();
}

class _SortStocksState extends State<SortStocks> {
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
                Text('Sort by', style: baseTextStyle2),
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
                        } else {
                          _type = EquityStockSortTypes.ase;
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
                  'Market Cap',
                  style: baseTextStyle14400,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (_type == EquityStockSortTypes.lowHigh) {
                          _type = EquityStockSortTypes.highLow;
                        } else {
                          _type = EquityStockSortTypes.lowHigh;
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
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
