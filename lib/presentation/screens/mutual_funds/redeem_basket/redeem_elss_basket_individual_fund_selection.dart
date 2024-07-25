import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../widgets/basket_custom_container.dart';

class RedeemElssBasketIndividualFundSelection extends StatefulWidget {
  const RedeemElssBasketIndividualFundSelection({super.key});

  @override
  State<RedeemElssBasketIndividualFundSelection> createState() =>
      _RedeemElssBasketIndividualFundSelectionState();
}

class _RedeemElssBasketIndividualFundSelectionState
    extends State<RedeemElssBasketIndividualFundSelection> {
  String _selectedFund = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem From ELSS Basket'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.redeemIndividualFund,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Redeem Individual Fund',
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Funds within lock-in period',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF050C1B),
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Color(0xFFFAEBEB),
                    label: Text(
                      'Non Redeemable',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFCC3A3A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'These are the funds which are within the lock-in period and can only be redeemed after 3 years from the date of investment.',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFB0B0B0),
                ),
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Assets.pngs.basketLargeCap.image(
                    height: 32,
                    width: 32,
                  ),
                  const Gap(8),
                  const Text(
                    'ICICI Prudential Commodities Fund Direct Growth',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'Funds that can be redeemed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF050C1B),
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Color(0xFFEDFBF6),
                    label: Text(
                      'Redeemable',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF48D4A5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BasketCustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _FundSelectionRadio(
                    value: 'HDFC Large Cap Fund Direct Growth',
                    groupValue: _selectedFund,
                    onTap: () {
                      setState(() {
                        _selectedFund = 'HDFC Large Cap Fund Direct Growth';
                      });
                    },
                  ),
                  _FundSelectionRadio(
                    value: 'ICICI Large Cap Fund Direct Growth',
                    groupValue: _selectedFund,
                    onTap: () {
                      setState(() {
                        _selectedFund = 'ICICI Large Cap Fund Direct Growth';
                      });
                    },
                  ),
                  _FundSelectionRadio(
                    value: 'Axis Large Cap Fund Direct Growth',
                    groupValue: _selectedFund,
                    onTap: () {
                      setState(() {
                        _selectedFund = 'Axis Large Cap Fund Direct Growth';
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FundSelectionRadio extends StatelessWidget {
  const _FundSelectionRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onTap,
  }) : super(key: key);

  final String value;
  final String groupValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Opacity(
        opacity: value == groupValue || groupValue == '' ? 1 : 0.5,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio.adaptive(
                value: value,
                groupValue: groupValue,
                onChanged: (value) {},
              ),
              const Gap(12),
              Assets.pngs.basketLargeCap.image(
                height: 32,
                width: 32,
              ),
              const Gap(8),
              const Expanded(
                child: Text(
                  'ICICI Prudential Commodities Fund Direct Growth',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
