import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DigitalGoldSipCard extends StatelessWidget {
  const DigitalGoldSipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gold SIP'),
          Row(
            children: [
              Expanded(
                child: Text('Next Due on Jan 22'),
              ),
              Gap(20),
              Text('\u20b9 1,000'),
              Gap(20),
              Icon(
                Icons.chevron_right,
                size: 16,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
