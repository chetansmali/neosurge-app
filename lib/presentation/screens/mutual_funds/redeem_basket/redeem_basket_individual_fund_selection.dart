import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../widgets/basket_custom_container.dart';

class RedeemBasketIndividualFundSelection extends StatefulWidget {
  const RedeemBasketIndividualFundSelection({
    super.key,
    required this.basketPortfolioDetailResponse,
    required this.basket,
  });

  final BasketPortfolioDetailResponse basketPortfolioDetailResponse;
  final Basket basket;

  @override
  State<RedeemBasketIndividualFundSelection> createState() =>
      _RedeemBasketIndividualFundSelectionState();
}

class _RedeemBasketIndividualFundSelectionState
    extends State<RedeemBasketIndividualFundSelection> {
  String _selectedFund = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redeem From ${widget.basket.basketName}'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.redeemIndividualFund,
                arguments: RedeemIndividualFundArgs(
                  basket: widget.basket,
                  basketPortfolioDetailResponse:
                      widget.basketPortfolioDetailResponse,
                  index: widget.basketPortfolioDetailResponse.funds.indexWhere(
                    (element) => element.fundName == _selectedFund,
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Continue',
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Choose any of the Fund',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF050C1B),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          const Divider(
            color: Color(0xFFE6E6E6),
          ),
          BasketCustomContainer(
            child: ListView.builder(
              itemCount: widget.basketPortfolioDetailResponse.funds.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return _FundSelectionRadio(
                  title: widget
                      .basketPortfolioDetailResponse.funds[index].fundName,
                  value: widget
                      .basketPortfolioDetailResponse.funds[index].fundName,
                  groupValue: _selectedFund,
                  onTap: () {
                    setState(() {
                      _selectedFund = widget
                          .basketPortfolioDetailResponse.funds[index].fundName;
                    });
                  },
                  logoUrl:
                      'https://mutualfunds.neosurge.money/${widget.basketPortfolioDetailResponse.funds[index].logoUrl}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FundSelectionRadio extends StatelessWidget {
  const _FundSelectionRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.logoUrl,
  }) : super(key: key);

  final String title;
  final String value;
  final String groupValue;
  final String logoUrl;
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
              CachedNetworkImage(
                imageUrl: logoUrl,
                height: 32,
                width: 32,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
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
