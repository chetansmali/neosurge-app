import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';

class CartTransactionStatusScreen extends StatelessWidget {
  const CartTransactionStatusScreen({
    super.key,
    required this.mfTransactionStatus,
  });

  final MfTransactionStatus mfTransactionStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            if (mfTransactionStatus == MfTransactionStatus.success)
              Assets.animations.buyBasketSuccess.lottie()
            else if (mfTransactionStatus == MfTransactionStatus.failure)
              Assets.animations.buyBasketFail.lottie()
            else
              Assets.animations.buyBasketPending.lottie(),
            const Gap(12),
            Text(
              _getTransactionStatusText(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF050C1B),
              ),
            ),
            const Gap(2),
            Text(
              _getTransactionStatusDescription(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFFB0B0B0),
              ),
            ),
            const Gap(12),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF7E8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _getTransactionStatusNote(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF2AF1A),
                ),
              ),
            ),
            const Spacer(),
            if (mfTransactionStatus == MfTransactionStatus.success) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                },
                child: const Text(
                  'Go to Portfolio',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.neoBasketOrders,
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Track Order'),
              )
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(12),
              TextButton(
                onPressed: () {},
                child: const Text('Contact Support'),
              ),
            ]
          ],
        ),
      ),
    );
  }

  String _getTransactionStatusText() {
    if (mfTransactionStatus == MfTransactionStatus.success) {
      return 'Payment Received!';
    } else if (mfTransactionStatus == MfTransactionStatus.failure) {
      return 'Transaction Failed';
    } else {
      return 'Transaction Pending';
    }
  }

  String _getTransactionStatusDescription() {
    if (mfTransactionStatus == MfTransactionStatus.success) {
      return 'Request will be sent to AMC.';
    } else if (mfTransactionStatus == MfTransactionStatus.failure) {
      return 'Unable to process your request. Please try again later.';
    } else {
      return 'We are processing your request.';
    }
  }

  String _getTransactionStatusNote() {
    if (mfTransactionStatus == MfTransactionStatus.success) {
      return 'The Basket will show up in your portfolio in the next 2-3 days';
    } else if (mfTransactionStatus == MfTransactionStatus.failure) {
      return 'Any money deducted will be refunded within 48 hours.';
    } else {
      return 'We will notify you once the transaction is complete.';
    }
  }
}
