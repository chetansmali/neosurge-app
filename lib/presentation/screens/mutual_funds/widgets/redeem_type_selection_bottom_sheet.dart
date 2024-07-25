import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';

enum _RedeemType { basket, individualFund }

class RedeemTypeSelectionBottomSheet extends StatefulWidget {
  const RedeemTypeSelectionBottomSheet({
    super.key,
    required this.basketPortfolioDetailResponse,
    required this.basket,
  });

  final BasketPortfolioDetailResponse basketPortfolioDetailResponse;
  final Basket basket;

  @override
  State<RedeemTypeSelectionBottomSheet> createState() =>
      _RedeemTypeSelectionBottomSheetState();
}

class _RedeemTypeSelectionBottomSheetState
    extends State<RedeemTypeSelectionBottomSheet> {
  _RedeemType? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.basketPortfolioDetailResponse.basketState == 'WHOLE')
              RadioListTile.adaptive(
                value: _RedeemType.basket,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                title: const Text('Basket Redeem'),
              ),
            RadioListTile.adaptive(
              value: _RedeemType.individualFund,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              title: const Text('Individual Fund Redeem'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: _selectedValue == null
                  ? null
                  : () {
                      Navigator.pop(context);

                      if (_selectedValue == _RedeemType.basket) {
                        Navigator.of(context).pushNamed(
                          Routes.redeemBasket,
                          arguments: RedeemFundSelectionArgs(
                            basketPortfolioDetailResponse:
                                widget.basketPortfolioDetailResponse,
                            basket: widget.basket,
                          ),
                        );
                      } else if (_selectedValue == _RedeemType.individualFund) {
                        Navigator.of(context).pushNamed(
                          Routes.redeemIndividualFundSelection,
                          arguments: RedeemFundSelectionArgs(
                            basketPortfolioDetailResponse:
                                widget.basketPortfolioDetailResponse,
                            basket: widget.basket,
                          ),
                        );
                      }
                    },
              child: const Text('Redeem'),
            ),
          ],
        ),
      ),
    );
  }
}
