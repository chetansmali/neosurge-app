import 'package:flutter/material.dart';

import '../../../data/models/mutual_funds/fund_holding.dart';
import '../../theme/app_colors.dart';

class AllHoldingsScreen extends StatelessWidget {
  final List<FundHolding> holdings;

  const AllHoldingsScreen({Key? key, required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holdings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(310),
              2: FlexColumnWidth(140),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.2,
                    ),
                  ),
                ),
                children: [
                  _TitleText('Name'),
                  _TitleText('Assets'),
                ],
              ),
              ...List.generate(
                holdings.length,
                (index) => TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.2,
                      ),
                    ),
                  ),
                  children: [
                    _InfoText(
                      holdings[index].security,
                      TextStyle(
                        fontSize: 12,
                        color: AppColors.neutral[300],
                      ),
                    ),
                    _InfoText(
                      '${holdings[index].holdingPerc} %',
                      const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _InfoText(this.text, this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.neutral[100],
        ),
      ),
    );
  }
}
