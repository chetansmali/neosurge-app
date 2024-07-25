import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../../domain/entities/params/neobaskets/basket_individual_redeem_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/basket_individual_redeem_order/basket_individual_redeem_order_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../widgets/basket_custom_container.dart';

enum _RedeemType { amount, units }

class RedeemBasketIndividualFund extends StatefulWidget {
  const RedeemBasketIndividualFund({
    super.key,
    required this.basket,
    required this.basketPortfolioDetailResponse,
    required this.selectedFundIndex,
  });

  final Basket basket;
  final BasketPortfolioDetailResponse basketPortfolioDetailResponse;
  final int selectedFundIndex;

  @override
  State<RedeemBasketIndividualFund> createState() =>
      _RedeemBasketIndividualFundState();
}

class _RedeemBasketIndividualFundState
    extends State<RedeemBasketIndividualFund> {
  _RedeemType _redeemType = _RedeemType.amount;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hasInputError = false;

  bool _isRedeemAll = false;

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redeem from ${widget.basket.basketName}'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ErrorInfoWidget(
                otpErrorMsg:
                    'Final amount will depend on NAV applicable on the time of redemption request (as confirmed by the AMC).',
                backgroundColor: Color(0xFFFEF7E8),
                foregroundColor: Color(0xFFDC9F18),
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<BasketIndividualRedeemOrderCubit>()
                        .createBasketIndividualRedeem(
                          BasketIndividualRedeemParams(
                            basketId:
                                widget.basketPortfolioDetailResponse.basketID,
                            units:
                                _redeemType != _RedeemType.units || _isRedeemAll
                                    ? null
                                    : double.parse(_amountController.text),
                            amount: _redeemType != _RedeemType.amount ||
                                    _isRedeemAll
                                ? null
                                : double.parse(_amountController.text),
                            schemeId: widget.basketPortfolioDetailResponse
                                .funds[widget.selectedFundIndex].fundIsin,
                            fullRedeem: _isRedeemAll,
                          ),
                        );
                  }
                },
                child: BlocConsumer<BasketIndividualRedeemOrderCubit,
                    BasketIndividualRedeemOrderState>(
                  listener: (context, state) {
                    if (state is BasketIndividualRedeemOrderLoaded) {
                      Navigator.of(context).pushNamed(
                        Routes.redeemOrderSummary,
                        arguments: state.basketRedeemOrderResponse,
                      );
                    }

                    if (state is BasketIndividualRedeemOrderError) {
                      Utils.showErrorAlert(
                          context, state.message ?? 'Something went wrong');
                    }
                  },
                  builder: (context, state) {
                    return state is BasketIndividualRedeemOrderLoading
                        ? Assets.animations.loading.lottie()
                        : const Text('Continue');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BasketCustomContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://mutualfunds.neosurge.money/${widget.basketPortfolioDetailResponse.funds[widget.selectedFundIndex].logoUrl}',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          widget.basketPortfolioDetailResponse
                              .funds[widget.selectedFundIndex].fundName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BasketCustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Would you like to Redeem by',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF47586E),
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          _InvestmentTypeRadioButtons(
                            label: 'Amount',
                            value: _RedeemType.amount,
                            selectedInvestmentType: _redeemType,
                            onSelect: () {
                              if (_isRedeemAll) {
                                _amountController.text = widget
                                    .basketPortfolioDetailResponse
                                    .funds[widget.selectedFundIndex]
                                    .current
                                    .toString();
                              }

                              setState(() {
                                _redeemType = _RedeemType.amount;
                              });
                            },
                          ),
                          const Gap(32),
                          _InvestmentTypeRadioButtons(
                            label: 'Units',
                            value: _RedeemType.units,
                            selectedInvestmentType: _redeemType,
                            onSelect: () {
                              if (_isRedeemAll) {
                                _amountController.text = widget
                                    .basketPortfolioDetailResponse
                                    .funds[widget.selectedFundIndex]
                                    .units
                                    .toString();
                              }
                              setState(() {
                                _redeemType = _RedeemType.units;
                              });
                            },
                          ),
                        ],
                      ),
                      const Gap(30),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _redeemType == _RedeemType.amount
                                  ? 'Enter Amount'
                                  : 'Enter Units',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF47586E),
                              ),
                            ),
                            const Gap(8),
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (String? value) {
                                String? error;

                                if (value == null) return 'Please enter amount';

                                if (_redeemType == _RedeemType.amount) {
                                  if (value.isEmpty) {
                                    error = 'Minimum redeem amount is ₹1';
                                  } else if (double.parse(value) <= 0) {
                                    error = 'Minimum redeem amount is ₹1';
                                  } else if (double.parse(value) >
                                      widget
                                          .basketPortfolioDetailResponse
                                          .funds[widget.selectedFundIndex]
                                          .current) {
                                    error =
                                        'Maximum redeem amount is ₹${widget.basketPortfolioDetailResponse.funds[widget.selectedFundIndex].current}';
                                  }
                                } else {
                                  if ((value).isEmpty) {
                                    error = 'Please enter units to redeem';
                                  } else if (double.parse(value) <= 0) {
                                    error = 'Minimum redeem units is 1';
                                  } else if (double.parse(value) >
                                      widget
                                          .basketPortfolioDetailResponse
                                          .funds[widget.selectedFundIndex]
                                          .units) {
                                    error =
                                        'Maximum redeem units is ${widget.basketPortfolioDetailResponse.funds[widget.selectedFundIndex].units}';
                                  }
                                }

                                setState(() {
                                  _hasInputError = error != null;
                                });

                                return error;
                              },
                              readOnly: _isRedeemAll,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.rupeeSign,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                suffixIcon: _hasInputError
                                    ? const Icon(
                                        Icons.error,
                                        color: Color(0xFFCC3A3A),
                                      )
                                    : null,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 16,
                                ),
                                prefixStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Gap(16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: 'Total Redeemable\n',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF297DFD),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'based on NAV of 15 JUL 2023',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFB0B0B0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  _redeemType == _RedeemType.amount
                                      ? '₹ ${widget.basketPortfolioDetailResponse.funds[widget.selectedFundIndex].current}'
                                      : '${widget.basketPortfolioDetailResponse.funds[widget.selectedFundIndex].units} units',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF297DFD),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     const Text(
                            //       'Redeem Units',
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.w400,
                            //         color: Color(0xFFB0B0B0),
                            //       ),
                            //     ),
                            //     const Spacer(),
                            //     TextButton(
                            //       onPressed: () {
                            //         showModalBottomSheet(
                            //           context: context,
                            //           shape: const RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(32),
                            //               topRight: Radius.circular(32),
                            //             ),
                            //           ),
                            //           builder: (context) {
                            //             return const RedeemableFundBottomSheet();
                            //           },
                            //         );
                            //       },
                            //       child: const Text(
                            //         'View',
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.w600,
                            //           color: Color(0xFF297DFD),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            CheckboxListTile.adaptive(
                              value: _isRedeemAll,
                              onChanged: (val) {
                                _amountController.text =
                                    _redeemType == _RedeemType.amount
                                        ? widget
                                            .basketPortfolioDetailResponse
                                            .funds[widget.selectedFundIndex]
                                            .current
                                            .toString()
                                        : widget
                                            .basketPortfolioDetailResponse
                                            .funds[widget.selectedFundIndex]
                                            .units
                                            .toString();
                                setState(() {
                                  _isRedeemAll = val!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Redeem All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: _isRedeemAll
                                      ? const Color(0xFF297DFD)
                                      : Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(60),
              ],
            ),
          ),
          KeyboardDismissButton(
            buildContext: context,
            onDone: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }
}

class _InvestmentTypeRadioButtons extends StatelessWidget {
  const _InvestmentTypeRadioButtons({
    Key? key,
    required this.onSelect,
    required this.selectedInvestmentType,
    required this.value,
    required this.label,
  }) : super(key: key);

  final VoidCallback onSelect;
  final _RedeemType value;
  final _RedeemType selectedInvestmentType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Row(
        children: [
          Radio<_RedeemType>.adaptive(
            value: value,
            groupValue: selectedInvestmentType,
            onChanged: null,
          ),
          const Gap(4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF47586E),
            ),
          ),
        ],
      ),
    );
  }
}
