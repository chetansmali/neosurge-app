import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../domain/entities/enums.dart';
import '../../../../../../gen/assets.gen.dart';

class PortfolioSortStocks extends StatefulWidget {
  final EquityStockSortTypes equitySortType;

  const PortfolioSortStocks({super.key, required this.equitySortType});

  @override
  State<PortfolioSortStocks> createState() => _SortStocksState();
}

class _SortStocksState extends State<PortfolioSortStocks> {
  late EquityStockSortTypes _type;

  @override
  void initState() {
    _type = widget.equitySortType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sort by', style: baseTextStyle2),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Assets.icons.crossIcon.image(height: 24, width: 24)),
              ],
            ),
            const Gap(16),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'A-Z',
                    style: baseTextStyle14400,
                  ),
                  leading: Radio<EquityStockSortTypes>(
                    value: EquityStockSortTypes.ase,
                    groupValue: _type,
                    onChanged: (EquityStockSortTypes? value) {
                      setState(() {
                        _type = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Z-A', style: baseTextStyle14400),
                  leading: Radio<EquityStockSortTypes>(
                    value: EquityStockSortTypes.dse,
                    groupValue: _type,
                    onChanged: (EquityStockSortTypes? value) {
                      setState(() {
                        _type = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Price: Low-High',
                    style: baseTextStyle14400,
                  ),
                  leading: Radio<EquityStockSortTypes>(
                    value: EquityStockSortTypes.lowHigh,
                    groupValue: _type,
                    onChanged: (EquityStockSortTypes? value) {
                      setState(() {
                        _type = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Price: High-Low',
                    style: baseTextStyle14400,
                  ),
                  leading: Radio<EquityStockSortTypes>(
                    value: EquityStockSortTypes.highLow,
                    groupValue: _type,
                    onChanged: (EquityStockSortTypes? value) {
                      setState(() {
                        _type = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _type);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
