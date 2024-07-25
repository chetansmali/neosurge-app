import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../../domain/entities/params/neobaskets/basket_redeem_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/basket_redeem_order/basket_redeem_order_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../widgets/basket_custom_container.dart';
import 'widgets/ratio_bottom_sheet.dart';

enum _RedeemType { invested, current }

class RedeemBasket extends StatefulWidget {
  const RedeemBasket({
    super.key,
    required this.basketPortfolioDetailResponse,
    required this.basket,
  });

  final BasketPortfolioDetailResponse basketPortfolioDetailResponse;
  final Basket basket;

  @override
  State<RedeemBasket> createState() => _RedeemBasketState();
}

class _RedeemBasketState extends State<RedeemBasket> {
  _RedeemType _redeemType = _RedeemType.invested;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();

  bool _hasInputError = false;
  bool _isRedeemAll = false;
  bool _isFundByRatioVisible = false;

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
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<BasketRedeemOrderCubit>().createBasketRedeem(
                      BasketRedeemOrderParams(
                        basketId: widget.basketPortfolioDetailResponse.basketID,
                        amount: _isRedeemAll ? null : _amountController.text,
                        redemptionType: _redeemType == _RedeemType.invested
                            ? 'INVESTED'
                            : 'CURRENT',
                        redeemAll: _isRedeemAll,
                        isBroken: false,
                      ),
                    );
              }
            },
            child: BlocConsumer<BasketRedeemOrderCubit, BasketRedeemOrderState>(
              listener: (context, state) {
                if (state is BasketRedeemOrderCreated) {
                  Navigator.of(context).pushNamed(
                    Routes.redeemOrderSummary,
                    arguments: state.basketRedeemOrderResponse,
                  );
                }

                if (state is BasketRedeemOrderError) {
                  Utils.showErrorAlert(
                    context,
                    state.message ?? 'Something went wrong',
                  );
                }
              },
              builder: (context, state) {
                return state is BasketRedeemOrderCreating
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue');
              },
            ),
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
                      CircleAvatar(
                        backgroundColor: const Color(0xFFBFD1FD),
                        radius: 24,
                        child: CachedNetworkImage(
                          imageUrl: widget.basket.imageUrl ?? '',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          widget.basketPortfolioDetailResponse.basketID,
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
                      Row(
                        children: [
                          const Text(
                            'Would you like to redeem in ratio of',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF47586E),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return const RatioBottomSheet();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.info,
                              color: Color(0xFFFFCF34),
                            ),
                          )
                        ],
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          _InvestmentTypeRadioButtons(
                            label: 'Invested Value',
                            value: _RedeemType.invested,
                            selectedInvestmentType: _redeemType,
                            onSelect: () {
                              setState(() {
                                _redeemType = _RedeemType.invested;
                                _amountController.text = '';
                                _isFundByRatioVisible = false;
                                _isRedeemAll = false;
                              });
                            },
                          ),
                          const Gap(32),
                          _InvestmentTypeRadioButtons(
                            label: 'Current Value',
                            value: _RedeemType.current,
                            selectedInvestmentType: _redeemType,
                            onSelect: () {
                              setState(() {
                                _redeemType = _RedeemType.current;
                                _amountController.text = '';
                                _isFundByRatioVisible = false;
                                _isRedeemAll = false;
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
                            const Text(
                              'Enter Redeem Amount',
                              style: TextStyle(
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

                                if (value == null || value.isEmpty) {
                                  return 'Minimum redeem amount is ₹1';
                                } else if (double.parse(value) <= 0) {
                                  return 'Minimum redeem amount is ₹1';
                                }

                                if (_redeemType == _RedeemType.invested &&
                                    double.parse(value) >
                                        (widget.basketPortfolioDetailResponse
                                                .basketInvestedValue ??
                                            0.0)) {
                                  error =
                                      'Maximum redeem amount is ₹${widget.basketPortfolioDetailResponse.basketInvestedValue?.toStringAsFixed(2)}';
                                } else if (_redeemType == _RedeemType.current &&
                                    double.parse(value) >
                                        (widget.basketPortfolioDetailResponse
                                                .basketCurrentValue ??
                                            0.0)) {
                                  error =
                                      'Maximum redeem amount is ₹${widget.basketPortfolioDetailResponse.basketCurrentValue?.toStringAsFixed(2)}';
                                }

                                if (error != null) {
                                  setState(() {
                                    _hasInputError = true;
                                  });
                                } else {
                                  setState(() {
                                    _hasInputError = false;
                                  });
                                }

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
                                Text.rich(
                                  TextSpan(
                                    text: 'Total Redeemable\n',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF297DFD),
                                    ),
                                    children: [
                                      TextSpan(
                                        // TODO: Change this to dynamic date
                                        text:
                                            'based on NAV of ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFB0B0B0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                AmountWidget(
                                  amount: _redeemType == _RedeemType.invested
                                      ? widget.basketPortfolioDetailResponse
                                              .basketInvestedValue ??
                                          0.0
                                      : widget.basketPortfolioDetailResponse
                                              .basketCurrentValue ??
                                          0.0,
                                  isCompact: false,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF297DFD),
                                  ),
                                )
                              ],
                            ),
                            const Gap(16),
                            CheckboxListTile.adaptive(
                              value: _isRedeemAll,
                              onChanged: (val) {
                                if (val ?? false) {
                                  _amountController.text =
                                      _redeemType == _RedeemType.invested
                                          ? widget.basketPortfolioDetailResponse
                                                  .basketInvestedValue
                                                  ?.toStringAsFixed(2) ??
                                              ''
                                          : widget.basketPortfolioDetailResponse
                                                  .basketCurrentValue
                                                  ?.toStringAsFixed(2) ??
                                              '';
                                } else {
                                  _amountController.text = '';
                                }

                                _formKey.currentState!.validate();

                                setState(() {
                                  _isFundByRatioVisible = val ?? false;
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
                            ),
                            if (_isFundByRatioVisible) ...[
                              const Gap(24),
                              const Text(
                                'Fund Ratio Details',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF47586E),
                                ),
                              ),
                              const Gap(12),
                              ListView.builder(
                                itemCount: widget
                                    .basketPortfolioDetailResponse.funds.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  double valueByAllocationPercentage = 0;
                                  if (_redeemType == _RedeemType.invested) {
                                    valueByAllocationPercentage = widget
                                            .basketPortfolioDetailResponse
                                            .funds[index]
                                            .allocationPercentage *
                                        double.parse(_amountController.text) /
                                        100;
                                  } else {
                                    valueByAllocationPercentage = widget
                                            .basketPortfolioDetailResponse
                                            .funds[index]
                                            .allocationPercentage *
                                        double.parse(_amountController.text) /
                                        100;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.basketPortfolioDetailResponse
                                                .funds[index].fundName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ),
                                        AmountWidget(
                                          amount: valueByAllocationPercentage,
                                          isCompact: false,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF000000),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ErrorInfoWidget(
                                otpErrorMsg:
                                    'The Fund Split Ratio on Invested Value is:\n ${widget.basketPortfolioDetailResponse.funds.map((e) => e.allocationPercentage).join(' : ')}',
                                backgroundColor: const Color(0xFFFEF7E8),
                                foregroundColor: const Color(0xFFDC9F18),
                                textAlign: TextAlign.center,
                              ),
                            ],
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

              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isFundByRatioVisible = true;
                });
              } else {
                setState(() {
                  _isFundByRatioVisible = false;
                });
              }
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
