import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

const List<Color> _colors = [
  Color(0xFFF2af1a),
  Color(0xFFF27e45),
  Color(0xFFcb5d38),
];

class PendingOrderItem extends HookWidget {
  final MfOrder order;

  const PendingOrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() => NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0));
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.mfOrderStatusScreen, arguments: MfOrderStatusArgs(mfOrder: order)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(order.orderType == MFTransactionTypes.switchTransaction || order.orderType == MFTransactionTypes.stp ? order.outFundName! : order.fundName ?? 'null'),
                  ),
                  const Gap(20),
                  Text(order.amount == null ? '${order.units!.toStringAsFixed(4)} units' : inrFormatter.format(order.amount)),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getColor(order.orderType).withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      '${order.orderType}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _getColor(order.orderType)),
                    ),
                  ),
                  const Text(
                    'Order Status',
                    style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(MFTransactionTypes orderType) {
    switch (orderType) {
      case MFTransactionTypes.lumpsum:
        return _colors[0];
      case MFTransactionTypes.sip:
        return _colors[1];
      case MFTransactionTypes.redemption:
        return _colors[2];
      case MFTransactionTypes.switchTransaction:
        return _colors[0];
      case MFTransactionTypes.stp:
        return _colors[1];
      case MFTransactionTypes.swp:
        return _colors[2];
      case MFTransactionTypes.stopSip:
        return _colors[0];
      case MFTransactionTypes.stopSwp:
        return _colors[1];
      default:
        return _colors[0];
    }
  }
}
