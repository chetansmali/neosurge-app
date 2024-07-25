import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../common/utils.dart';
import '../../../data/models/mutual_funds/fund.dart';
import '../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../data/models/transaction_data.dart';
import '../../../data/models/user/user_bank_details_model.dart';
import '../../../domain/entities/enums.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mutual_funds/redeem/create_redeem_order/create_redeem_order_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/error_info_widget.dart';
import '../../widgets/keyboard_dismiss_btn.dart';
import '../../widgets/primary_bank_card.dart';
import '../mutual_funds/widgets/basket_custom_container.dart';

enum _RedeemType { amount, units }

class RedeemScreen extends StatefulWidget {
  final UserMfScheme scheme;
  final Fund fund;

  const RedeemScreen({
    Key? key,
    required this.scheme,
    required this.fund,
  }) : super(key: key);

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  _RedeemType _redeemType = _RedeemType.amount;
  bool _hasInputError = false;
  bool _isRedeemAll = false;
  late UserBank _userBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Fund'),
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
              BlocConsumer<CreateRedeemOrderCubit, CreateRedeemOrderState>(
                  listener: (context, state) {
                if (state is CreateRedeemOrderSuccess) {
                  transactionData.clearData();
                  transactionData.fund = widget.fund;
                  transactionData.bank = _userBank;
                  transactionData.amount = _isRedeemAll
                      ? widget.scheme.redeemableAmount.toString()
                      : _redeemType == _RedeemType.amount
                          ? _amountController.text
                          : null;
                  transactionData.units = _isRedeemAll
                      ? widget.scheme.redeemableUnits.toString()
                      : _redeemType == _RedeemType.units
                          ? _amountController.text
                          : null;
                  transactionData.transactionType =
                      MFTransactionTypes.redemption;
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.redeemVerifyOtp,
                    arguments: RedeemTransactionArgs(
                      scheme: widget.scheme,
                      redeemResponse: state.response,
                      fund: widget.fund,
                    ),
                  );
                }
                if (state is CreateRedeemOrderFailure) {
                  Utils.showErrorAlert(
                    context,
                    Utils.getErrorMessage(
                      errorType: state.errorType,
                      msg: state.error,
                    ),
                  );
                }
              }, builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    FocusScope.of(context).unfocus();
                    context.read<CreateRedeemOrderCubit>().redeemFund(
                          scheme: widget.scheme,
                          amount: _isRedeemAll
                              ? null
                              : _redeemType == _RedeemType.amount
                                  ? double.parse(
                                      _amountController.text,
                                    )
                                  : null,
                          units: _isRedeemAll
                              ? null
                              : _redeemType == _RedeemType.units
                                  ? double.parse(
                                      _amountController.text,
                                    )
                                  : null,
                          userId: context.read<AuthCubit>().state.user!.id,
                          isAssisted: widget.scheme.isAssistedFund,
                          isRedeemAll: _isRedeemAll,
                        );
                  },
                  child: state is CreateRedeemOrderLoading
                      ? Assets.animations.loading.lottie()
                      : const Text('Continue'),
                );
              }),
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
                          imageUrl: widget.fund.imgUrl,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          widget.fund.schemeName,
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
                                _amountController.text =
                                    widget.scheme.currentValue.toString();
                              } else {
                                _amountController.text = '';
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
                                _amountController.text =
                                    widget.scheme.redeemableUnits.toString();
                              } else {
                                _amountController.text = '';
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
                                  } else if (double.parse(value) <
                                      widget.fund.minWithdrawalAmount) {
                                    error =
                                        'Minimum redeem amount is ₹${widget.fund.minWithdrawalAmount}';
                                  } else if (double.parse(value) >
                                      widget.scheme.currentValue) {
                                    error =
                                        'Maximum redeem amount is ₹${widget.scheme.currentValue}';
                                  }
                                } else {
                                  if ((value).isEmpty) {
                                    error = 'Please enter units to redeem';
                                  } else if (double.parse(value) <= 0) {
                                    error =
                                        'Minimum redeem units is 0.0001 units';
                                  } else if (double.parse(value) >
                                      widget.scheme.redeemableUnits) {
                                    error =
                                        'Maximum redeem units is ${widget.scheme.redeemableUnits}';
                                  }
                                }

                                setState(() {
                                  _hasInputError = error != null;
                                });

                                return error;
                              },
                              readOnly: _isRedeemAll,
                              decoration: InputDecoration(
                                prefixIcon: _redeemType == _RedeemType.amount
                                    ? const Icon(
                                        FontAwesomeIcons.rupeeSign,
                                        size: 14,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.cubes,
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
                                _redeemType == _RedeemType.amount
                                    ? AmountWidget(
                                        amount: widget.scheme.currentValue,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF297DFD),
                                        ),
                                      )
                                    : Text(
                                        '${widget.scheme.redeemableUnits} units',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF297DFD),
                                        ),
                                      ),
                              ],
                            ),
                            CheckboxListTile.adaptive(
                              value: _isRedeemAll,
                              onChanged: (val) {
                                _amountController.text = _redeemType ==
                                        _RedeemType.amount
                                    ? widget.scheme.currentValue.toString()
                                    : widget.scheme.redeemableUnits.toString();
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
                            ),
                            const Divider(
                              height: 30,
                            ),
                            BlocConsumer<GetPrimaryBankCubit,
                                GetPrimaryBankState>(
                              listener: (context, state) {
                                if (state is GetPrimaryBankLoaded) {
                                  _userBank = state.bankDetails;
                                }
                              },
                              builder: (context, state) {
                                if (state is GetPrimaryBankLoaded) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Transfer amount to',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      PrimaryBankCard(
                                        bank: state.bankDetails,
                                        padding: const EdgeInsets.all(0),
                                      ),
                                    ],
                                  );
                                }
                                return const Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: AppColors.yellowPrimary,
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: Text(
                                        'The amount will be credited to your primary bank account',
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
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
