import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/amount_widget.dart';

Padding negativeTransaction(String description, String date, double price) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(blurRadius: 12.0, color: Colors.black.withOpacity(0.08))
          ],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.pngs.negativeTransaction.path.toString(),
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: baseTextStyle12500.copyWith(
                          color: const Color(0xFF727579)),
                    ),
                    Text(
                      date,
                      style: baseTextStyle14400.copyWith(
                          color: const Color(0xFF9EA0A3)),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '- ',
                  style: baseTextStyle12500.copyWith(
                      color: const Color(0xFFFF4949)),
                ),
                AmountWidget(
                  amount: price,
                  style: baseTextStyle12500.copyWith(
                      color: Colors.black), // Style for the rest of the text
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Padding positiveTransaction(String description, String date, double price) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(blurRadius: 12.0, color: Colors.black.withOpacity(0.08))
          ],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.pngs.positiveTransaction.path.toString(),
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: baseTextStyle12500.copyWith(
                          color: const Color(0xFF727579)),
                    ),
                    Text(
                      DateFormat('MMM dd, yyyy').format(
                          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, true)),
                      style: baseTextStyle14400.copyWith(
                          color: const Color(0xFF9EA0A3)),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '+ ',
                      style: baseTextStyle12500.copyWith(
                          color: const Color(0xFF11CE66)),
                    ),
                    AmountWidget(
                      amount: price,
                      style: baseTextStyle12500.copyWith(
                          color:
                              Colors.black), // Style for the rest of the text
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFAEC),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9.0, vertical: 3),
                    child: Text(
                      'Upcoming',
                      style: baseTextStyle10400.copyWith(
                          color: const Color(0xFFFFCC3C)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Padding pledgedMF(String scripName, double price) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(blurRadius: 12.0, color: Colors.black.withOpacity(0.08))
          ],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Gap(8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scripName,
                      style: baseTextStyle12500.copyWith(
                          color: const Color(0xFF727579)),
                    ),
                  ],
                )
              ],
            ),
            AmountWidget(
              amount: price,
              style: baseTextStyle12500.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
