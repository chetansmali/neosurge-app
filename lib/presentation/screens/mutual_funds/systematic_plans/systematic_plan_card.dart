import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mutual_funds/systematic_plan.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';

const List<Color> _colors = [
  Color(0xFFF2af1a),
  Color(0xFFF27e45),
  Color(0xFFcb5d38),
];

class SystematicPlanCard extends StatelessWidget {
  final SystematicPlan plan;

  const SystematicPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (plan.orderType == MFTransactionTypes.sip) {
            Navigator.pushNamed(context, Routes.sipDetail, arguments: SystematicPlanArgs(plan: plan));
          } else if (plan.orderType == MFTransactionTypes.stp) {
            Navigator.pushNamed(context, Routes.stpDetail, arguments: SystematicPlanArgs(plan: plan));
          } else {
            Navigator.pushNamed(context, Routes.swpDetail, arguments: SystematicPlanArgs(plan: plan));
          }
        },
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(imageUrl: plan.imgUrl, width: 50, height: 50),
              dense: true,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.plan,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getColor(plan.orderType).withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      '${plan.orderType}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: getColor(plan.orderType)),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: plan.status == SystematicPlansStatus.deactivated
                  ? Text(
                      '${plan.orderType} Cancelled on ${DateFormat('dd MMM yyyy').format(plan.updatedAt)}',
                      style: const TextStyle(fontSize: 10),
                    )
                  : Text(
                      'Next due on ${DateFormat('dd MMM yyyy').format(plan.nextInstallmentDate)}',
                      style: const TextStyle(fontSize: 10),
                    ),
              dense: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (plan.status != SystematicPlansStatus.deactivated)
                    Text(
                      NumberFormat.currency(locale: 'en_IN', symbol: '\u20b9', decimalDigits: 0).format(plan.amount),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  const Gap(10),
                  const Icon(Icons.arrow_forward_ios, size: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(MFTransactionTypes orderType) {
    switch (orderType) {
      case MFTransactionTypes.sip:
        return _colors[0];
      case MFTransactionTypes.swp:
        return _colors[1];
      case MFTransactionTypes.stp:
        return _colors[2];
      default:
        return Colors.black;
    }
  }
}
