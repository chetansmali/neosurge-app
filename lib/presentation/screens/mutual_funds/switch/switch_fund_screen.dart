import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import '../../../../common/utils.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../data/models/transaction_data.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/create_switch_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/switch/create_switch_order/create_switch_order_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';

import '../../../widgets/amount_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../widgets/basket_custom_container.dart';

enum _SwitchType { amount, units }

class SwitchFundScreen extends StatefulWidget {
  final Fund fund;
  final Fund switchFund;
  final UserMfScheme scheme;

  const SwitchFundScreen({
    Key? key,
    required this.fund,
    required this.switchFund,
    required this.scheme,
  }) : super(key: key);

  @override
  State<SwitchFundScreen> createState() => _SwitchFundScreenState();
}

class _SwitchFundScreenState extends State<SwitchFundScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  _SwitchType _switchType = _SwitchType.amount;
  bool _isSwitchAll = false;
  bool _hasInputError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocConsumer<CreateSwitchOrderCubit, CreateSwitchOrderState>(
            listener: (context, state) {
              if (state is CreateSwitchOrderSuccess) {
                transactionData.clearData();
                transactionData.fund = widget.fund;
                transactionData.switchStpFund = widget.switchFund;
                transactionData.amount = _isSwitchAll
                    ? null
                    : _switchType == _SwitchType.amount
                        ? _amountController.text
                        : null;
                transactionData.units = _isSwitchAll
                    ? widget.scheme.redeemableUnits.toString()
                    : _switchType == _SwitchType.units
                        ? _amountController.text
                        : null;

                transactionData.transactionType =
                    MFTransactionTypes.switchTransaction;

                Navigator.pushReplacementNamed(
                  context,
                  Routes.switchVerifyOtp,
                  arguments: SwitchFundArgs(
                    fund: widget.fund,
                    scheme: widget.scheme,
                    switchFund: widget.switchFund,
                    switchResponse: state.response,
                  ),
                );
              }
              if (state is CreateSwitchOrderFailure) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      errorType: state.errorType, msg: state.errorMessage),
                );
              }
            },
            builder: (context, state) => ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                context.read<CreateSwitchOrderCubit>().createSwitchOrder(
                      CreateSwitchOrderParams(
                        userId: context.read<AuthCubit>().state.user!.id,
                        folioNumber: widget.scheme.folioNumber,
                        nav: widget.scheme.nav,
                        //scheme out is current fund
                        //scheme in is new fund
                        //Fund amount should be redeemable amount
                        fundAmount: _isSwitchAll
                            ? null
                            : _switchType == _SwitchType.amount
                                ? double.parse(
                                    _amountController.text,
                                  )
                                : null,
                        units: _isSwitchAll
                            ? widget.scheme.redeemableUnits
                            : _switchType == _SwitchType.units
                                ? double.parse(
                                    _amountController.text,
                                  )
                                : null,
                        schemeOutIsin: widget.fund.isin,
                        schemeInIsin: widget.switchFund.isin,
                        schemeOutFundPlanId: widget.fund.schemeCode,
                        schemeInFundPlanId: widget.switchFund.schemeCode,
                        switchOutMinAmt: widget.fund.switchMinAmt,
                        switchInAllowed:
                            widget.fund.switchAllowed == 'Y' ? true : false,
                        switchInSchemeName: widget.switchFund.schemeNameUnique,
                        switchOutSchemeName: widget.fund.schemeNameUnique,
                        switchInImgUrl: widget.switchFund.imgUrl,
                        switchOutImgUrl: widget.fund.imgUrl,
                        isAssisted: widget.scheme.isAssistedFund,
                      ),
                    );
              },
              child: state is CreateSwitchOrderLoading
                  ? Assets.animations.loading.lottie()
                  : const Text('Confirm'),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Would you like to switch by',
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
                            value: _SwitchType.amount,
                            selectedInvestmentType: _switchType,
                            onSelect: () {
                              if (_isSwitchAll) {
                                _amountController.text =
                                    widget.scheme.currentValue.toString();
                              } else {
                                _amountController.text = '';
                              }

                              setState(() {
                                _switchType = _SwitchType.amount;
                              });
                            },
                          ),
                          const Gap(32),
                          _InvestmentTypeRadioButtons(
                            label: 'Units',
                            value: _SwitchType.units,
                            selectedInvestmentType: _switchType,
                            onSelect: () {
                              if (_isSwitchAll) {
                                _amountController.text =
                                    widget.scheme.redeemableUnits.toString();
                              } else {
                                _amountController.text = '';
                              }
                              setState(() {
                                _switchType = _SwitchType.units;
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
                              _switchType == _SwitchType.amount
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

                                if (value == null || value.isEmpty) {
                                  return 'Please enter amount';
                                }

                                if (_switchType == _SwitchType.amount) {
                                  if (value.isEmpty) {
                                    error = 'Minimum switch amount is ₹1';
                                  } else if (double.parse(value) <
                                      widget.switchFund.switchMinAmt) {
                                    error =
                                        'Minimum switch amount is ₹${widget.switchFund.switchMinAmt}';
                                  } else if (double.parse(value) >
                                      widget.scheme.redeemableAmount) {
                                    error =
                                        'Maximum switch amount is ₹${widget.scheme.redeemableAmount}';
                                  }
                                } else {
                                  if ((value).isEmpty) {
                                    error = 'Please enter units to switch';
                                  } else if (double.parse(value) <= 0) {
                                    error =
                                        'Minimum switch units is 0.0001 units';
                                  } else if (double.parse(value) >
                                      widget.scheme.redeemableUnits) {
                                    error =
                                        'Maximum switch units is ${widget.scheme.redeemableUnits}';
                                  }
                                }

                                setState(() {
                                  _hasInputError = error != null;
                                });

                                return error;
                              },
                              readOnly: _isSwitchAll,
                              decoration: InputDecoration(
                                prefixIcon: _switchType == _SwitchType.amount
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
                                    text: 'Total Switchable\n',
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
                                _switchType == _SwitchType.amount
                                    ? AmountWidget(
                                        amount: widget.scheme.currentValue,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF297DFD),
                                        ),
                                        isCompact: false,
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
                              value: _isSwitchAll,
                              onChanged: (val) {
                                _amountController.text = _switchType ==
                                        _SwitchType.amount
                                    ? widget.scheme.redeemableAmount.toString()
                                    : widget.scheme.redeemableUnits.toString();
                                setState(() {
                                  _isSwitchAll = val!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Switch All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: _isSwitchAll
                                      ? const Color(0xFF297DFD)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Transfer to',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                BasketCustomContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.switchFund.imgUrl,
                        width: 40,
                        height: 40,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          widget.switchFund.schemeName,
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
              ],
            ),
          ),
          KeyboardDismissButton(
            buildContext: context,
            onDone: () {
              FocusManager.instance.primaryFocus?.unfocus();
              // formKey.currentState!.validate();
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
  final _SwitchType value;
  final _SwitchType selectedInvestmentType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Row(
        children: [
          Radio<_SwitchType>.adaptive(
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
