import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../domain/entities/enums.dart';
import '../../../theme/app_colors.dart';
import 'lumpsum_stepper.dart';
import 'redeem_stepper.dart';
import 'sip_stepper.dart';
import 'stp_stepper.dart';
import 'switch_stepper.dart';
import 'swp_stepper.dart';

class MfOrderStatusScreen extends StatelessWidget {
  final MfOrder mfOrder;

  const MfOrderStatusScreen({Key? key, required this.mfOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${mfOrder.orderType} Order Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mfOrder.amount != null
                  ? Text(
                      NumberFormat.currency(locale: 'en_IN', symbol: '\u20b9').format(mfOrder.amount),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    )
                  : Text(
                      '${mfOrder.units!.toStringAsFixed(4)} units',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
              const Gap(10),
              if (mfOrder.orderType == MFTransactionTypes.switchTransaction || mfOrder.orderType == MFTransactionTypes.stp) ...[
                Text(
                  mfOrder.outFundName!,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Gap(10),
                const Icon(Icons.arrow_downward),
                const Gap(10),
                Text(
                  mfOrder.inFundName!,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ] else
                Text(
                  mfOrder.fundName ?? 'null',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              const Gap(30),
              const Divider(
                thickness: 1,
              ),
              const Gap(10),
              _TwoRowText(
                title: 'Nav Date',
                subtitle: DateFormat('dd MMM yyyy').format(mfOrder.createdAt.subtract(const Duration(days: 1))),
                subtitleStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const Gap(10),
              _TwoRowText(title: 'Folio No.', subtitle: mfOrder.folioNumber ?? '-'),
              const Gap(10),
              _TwoRowText(title: 'Order ID', subtitle: mfOrder.orderId ?? '-'),
              const Gap(10),
              _TwoRowText(title: 'Transaction Date', subtitle: DateFormat('dd MMM yyyy hh:mm a').format(mfOrder.createdAt.toLocal())),
              const Divider(
                thickness: 1,
              ),
              const Gap(10),
              const Text(
                'Order Status',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              if (mfOrder.orderType == MFTransactionTypes.lumpsum) LumpsumStepper(mfOrder: mfOrder),
              if (mfOrder.orderType == MFTransactionTypes.sip) SipStepper(mfOrder: mfOrder),
              if (mfOrder.orderType == MFTransactionTypes.redemption) RedeemStepper(mfOrder: mfOrder),
              if (mfOrder.orderType == MFTransactionTypes.switchTransaction) SwitchStepper(mfOrder: mfOrder),
              if (mfOrder.orderType == MFTransactionTypes.stp) StpStepper(mfOrder: mfOrder),
              if (mfOrder.orderType == MFTransactionTypes.swp) SwpStepper(mfOrder: mfOrder),
            ],
          ),
        ),
      ),
    );
  }
}

class _TwoRowText extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? subtitleStyle;

  const _TwoRowText({Key? key, required this.title, required this.subtitle, this.subtitleStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkGrey,
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          flex: 2,
          child: Text(
            subtitle,
            style: subtitleStyle ??
                const TextStyle(
                  fontSize: 12,
                ),
          ),
        ),
      ],
    );
  }
}
