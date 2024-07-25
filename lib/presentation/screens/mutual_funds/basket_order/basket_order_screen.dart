import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/neobaskets/basket_details.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/keyboard_dismiss_btn.dart';
import '../widgets/basket_custom_container.dart';
import 'widgets/investment_type_radio_btn.dart';
import 'widgets/sip_date_selector.dart';
import 'widgets/sip_duration_picker.dart';

class BasketOrderScreen extends StatefulWidget {
  const BasketOrderScreen({
    super.key,
    required this.basketDetailsModel,
  });

  final BasketDetailsModel basketDetailsModel;

  @override
  State<BasketOrderScreen> createState() => _BasketOrderScreenState();
}

class _BasketOrderScreenState extends State<BasketOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BasketInvestmentType _basketInvestmentType = BasketInvestmentType.lumpsum;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _investmentDateController = TextEditingController(
    text: '1',
  );
  late final TextEditingController _investmentDurationController;

  int installments = 36;
  String? _amountErrorMsg;
  bool _isMaxInvestmentPeriod = true;
  int selectedInvestmentDurationYear = DateTime.now().year + 3;
  int selectedInvestmentDurationMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();

    _investmentDurationController = TextEditingController(
      text:
          '${DateFormat('MMM yyyy').format(now).toUpperCase()} - ${DateFormat('MMM yyyy').format(now.add(const Duration(days: 365 * 3))).toUpperCase()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_amountErrorMsg != null && _amountErrorMsg!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ErrorInfoWidget(
                    otpErrorMsg: '$_amountErrorMsg',
                  ),
                ),
              const Gap(16),
              ElevatedButton(
                onPressed: _amountErrorMsg == null
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed(
                            Routes.buyBasketOrderSummaryScreen,
                            arguments: BasketOrderSummaryArgs(
                              basketDetails: widget.basketDetailsModel,
                              investmentAmount:
                                  int.parse(_amountController.text),
                              basketInvestmentType: _basketInvestmentType,
                              investmentDate: int.parse(
                                _investmentDateController.text,
                              ),
                              installments:
                                  _isMaxInvestmentPeriod ? 360 : installments,
                            ),
                          );
                        }
                      }
                    : null,
                child: const Text('Continue'),
              ),
              const Gap(20),
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
                      CircleAvatar(
                        backgroundColor: const Color(0xFFBFD1FD),
                        radius: 24,
                        child: CachedNetworkImage(
                          imageUrl: widget.basketDetailsModel.imageUrl ?? '',
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColors.error[500],
                          ),
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        widget.basketDetailsModel.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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
                        'Would you like to ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF47586E),
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          InvestmentTypeRadioButtons(
                            label: 'Lumpsum',
                            value: BasketInvestmentType.lumpsum,
                            selectedInvestmentType: _basketInvestmentType,
                            onSelect: () {
                              setState(() {
                                _basketInvestmentType =
                                    BasketInvestmentType.lumpsum;
                              });
                            },
                          ),
                          const Gap(32),
                          InvestmentTypeRadioButtons(
                            label: 'SIP',
                            value: BasketInvestmentType.sip,
                            selectedInvestmentType: _basketInvestmentType,
                            onSelect: () {
                              setState(() {
                                _basketInvestmentType =
                                    BasketInvestmentType.sip;
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
                              _basketInvestmentType ==
                                      BasketInvestmentType.lumpsum
                                  ? 'Enter Amount'
                                  : 'Monthly SIP Amount',
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
                              onChanged: (value) {
                                setState(() {
                                  _amountErrorMsg = null;
                                  _formKey.currentState!.validate();
                                });
                              },
                              validator: (String? value) {
                                String? error;

                                if (value == null || value.isEmpty) {
                                  error = 'Please enter amount';

                                  setState(() {
                                    _amountErrorMsg = error;
                                  });

                                  return error;
                                }

                                int investmentAmount = int.parse(value);
                                double minLumpsumAmount =
                                    widget.basketDetailsModel.minLumpsum ?? 1;
                                double minSipAmount =
                                    widget.basketDetailsModel.minSip ?? 1;

                                if (_basketInvestmentType ==
                                    BasketInvestmentType.lumpsum) {
                                  if (investmentAmount <
                                      minLumpsumAmount.ceil()) {
                                    error =
                                        'Min. Lumpsum Amount: ₹${minLumpsumAmount.ceil()}';
                                  }
                                } else {
                                  if (investmentAmount < minSipAmount.ceil()) {
                                    error =
                                        'Min. SIP Amount: ₹ ${minSipAmount.ceil()}';
                                  }
                                }

                                setState(() {
                                  _amountErrorMsg = error;
                                });

                                return error;
                              },
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  fontSize: 0,
                                ),
                                fillColor: _amountErrorMsg == null
                                    ? AppColors.lightGrey
                                    : AppColors.errorRed.withOpacity(0.08),
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.rupeeSign,
                                  size: 14,
                                  color: Colors.black,
                                ),
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
                            if (_basketInvestmentType ==
                                BasketInvestmentType.sip) ...[
                              const Gap(20),
                              const Text(
                                'Monthly SIP Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF47586E),
                                ),
                              ),
                              const Gap(8),
                              TextFormField(
                                onTap: () async {
                                  var selectedInvestmentDate =
                                      await showModalBottomSheet<int>(
                                    context: context,
                                    isScrollControlled: false,
                                    backgroundColor: Colors.white,
                                    isDismissible: false,
                                    enableDrag: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SipDateSelector(
                                        defaultSelectedDate: int.parse(
                                          _investmentDateController.text,
                                        ),
                                      );
                                    },
                                  );

                                  _investmentDateController.text =
                                      selectedInvestmentDate.toString();
                                },
                                controller: _investmentDateController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                readOnly: true,
                                validator: (String? value) {
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.sortDown,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 16,
                                  ),
                                  prefixStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Gap(20),
                              CheckboxListTile.adaptive(
                                value: _isMaxInvestmentPeriod,
                                onChanged: (val) {
                                  setState(() {
                                    _isMaxInvestmentPeriod = val!;
                                  });
                                },
                                title: const Text(
                                  'Maximum Investment Period',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (!_isMaxInvestmentPeriod) ...[
                                const Gap(20),
                                const Text(
                                  'Investment Duration',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF47586E),
                                  ),
                                ),
                                const Gap(8),
                                TextFormField(
                                  onTap: () async {
                                    var selectedInvestmentEndDuration =
                                        await showModalBottomSheet<DateTime>(
                                      context: context,
                                      isScrollControlled: false,
                                      isDismissible: false,
                                      enableDrag: false,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return SipDurationPicker(
                                          defaultSelectedYear:
                                              selectedInvestmentDurationYear,
                                          defaultSelectedMonth:
                                              selectedInvestmentDurationMonth,
                                        );
                                      },
                                    );

                                    if (selectedInvestmentEndDuration != null) {
                                      // 'Current Month & Year - Selected Month & Year'

                                      _investmentDurationController.text =
                                          '${DateFormat('MMM yyyy').format(DateTime.now()).toUpperCase()} - ${DateFormat('MMM yyyy').format(selectedInvestmentEndDuration).toUpperCase()}';

                                      selectedInvestmentDurationYear =
                                          selectedInvestmentEndDuration.year;
                                      selectedInvestmentDurationMonth =
                                          selectedInvestmentEndDuration.month;

                                      installments =
                                          (selectedInvestmentEndDuration.year -
                                                      DateTime.now().year) *
                                                  12 +
                                              selectedInvestmentEndDuration
                                                  .month -
                                              DateTime.now().month;
                                    }
                                  },
                                  readOnly: true,
                                  controller: _investmentDurationController,
                                  validator: (String? value) {
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.sortDown,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 16,
                                    ),
                                    prefixStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
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
              _formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }
}
