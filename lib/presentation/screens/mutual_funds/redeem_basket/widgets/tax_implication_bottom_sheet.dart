import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaxImplicationBottomSheet extends StatelessWidget {
  const TaxImplicationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: const [
                Center(
                  child: Text(
                    'Tax Implication for Mutual Funds',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                Gap(16),
                Text(
                  'What is Tax on Mutual Funds?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
                Text(
                  'Profits gained from investment in mutual funds are subject to tax as \'Capital gains\'.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                ),
                Divider(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Any Units\n',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB0B0B0),
                        ),
                        children: [
                          TextSpan(
                            text: 'Sold within 15 days',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF297DFD),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'AMC fees Applicable\n',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB0B0B0),
                        ),
                        children: [
                          TextSpan(
                            text: '15.0%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF050C1B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info,
                      color: Color(0xFFFFCF34),
                    ),
                    Gap(8),
                    Expanded(
                      child: Text(
                        'Equity Mutual Funds gains up to Rs.1 L per year are tax free. Taxes applicable on gains > Rs.1 L per year',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF47586E),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info,
                      color: Color(0xFFFFCF34),
                    ),
                    Gap(8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Capital Gains will not be taxed at source\n',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF050C1B),
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Taxes have to be filed on realisation of gains when you sell the Mutual Funds units',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF47586E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Understood'),
            ),
          ),
        ],
      ),
    );
  }
}
