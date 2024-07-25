import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../widgets/error_info_widget.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/validators.dart';
import '../../../../constants/meta_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/label_text.dart';
import 'enter_otp_screen.dart';

class ConfirmCustomerAddressScreen extends StatefulWidget {
  const ConfirmCustomerAddressScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCustomerAddressScreen> createState() =>
      _ConfirmCustomerAddressScreenState();
}

class _ConfirmCustomerAddressScreenState
    extends State<ConfirmCustomerAddressScreen> {
  late final FocusNode _pinCodeFocusNode;
  bool isChecked = false;
  String _permAddressLine1 = '';
  String? _permAddressLine2;
  String _permCity = '';
  String _permState = '';
  String? _permPinCode;
  String? errorMsg = '', errorMsgAddress, errorMsgPincode;

  late TextEditingController _permAddressLine1Controller;
  late TextEditingController _permAddressLine2Controller;
  late TextEditingController _permStateController;
  late TextEditingController _permCityController;

  @override
  void initState() {
    super.initState();
    _pinCodeFocusNode = FocusNode();
    _permAddressLine1Controller =
        TextEditingController(text: _permAddressLine1);
    _permAddressLine2Controller =
        TextEditingController(text: _permAddressLine2);
    _permStateController = TextEditingController(text: _permState);
    _permCityController = TextEditingController(text: _permCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EnterCustomerOTPScreen()));
            },
            child: const Text('Confirm'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Confirm Permanent Address',
                              style: baseTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                          IconButton(
                            icon: Image.asset(
                              'assets/icons/edit.png',
                              height: 20,
                              width: 20,
                            ), // Change this icon to whatever you want
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const LabelText(label: 'Pincode'),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: errorMsgPincode == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                      ),
                      focusNode: _pinCodeFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _permPinCode,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (value) async {
                        // setState(() {
                        //   errorMsg = Validators.validatePinCode(value);
                        //   errorMsg_pincode = errorMsg;
                        // });
                        // if (value.length == 6) {
                        //   _fetchDetailsByPincode(value);
                        // }
                      },
                      onSaved: (value) async {
                        _permPinCode = value;
                      },
                      validator: Validators.validatePinCode,
                    ),
                    const Gap(20),
                    const LabelText(label: 'City'),
                    TextFormField(
                      controller: _permCityController,
                      readOnly: true,
                      validator: (value) => Validators.validateEmptyField(
                          ValidatorStrings.emptyCityField, value),
                      onSaved: (value) => _permCity = value!,
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d ]'),
                        ),
                      ],
                    ),
                    const Gap(20),
                    const LabelText(label: 'State'),
                    TextFormField(
                      controller: _permStateController,
                      readOnly: true,
                      validator: (value) => Validators.validateEmptyField(
                          ValidatorStrings.emptyStateField, value),
                      onSaved: (value) => _permState = value!,
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d ]'),
                        ),
                      ],
                    ),
                    const Gap(10),
                    const LabelText(label: 'Country'),
                    TextFormField(
                      controller: _permAddressLine1Controller,
                      readOnly: true,
                      validator: (value) => Validators.validateEmptyField(
                          ValidatorStrings.emptyAddressLine1Field, value),
                      onSaved: (value) => _permAddressLine1 = value!,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d\s,.-]'),
                        ),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(20),
                    const LabelText(
                      label: 'Address',
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          errorMsgAddress = Validators.validateEmptyField(
                              ValidatorStrings.emptyAddressLine2Field, value);
                          errorMsg = errorMsgAddress;
                        });
                      },
                      controller: _permAddressLine2Controller,
                      decoration: InputDecoration(
                        fillColor: errorMsgAddress == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                      ),
                      validator: (value) => Validators.validateEmptyField(
                          ValidatorStrings.emptyAddressLine2Field, value),
                      onSaved: (value) => _permAddressLine2 = value,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d\s,.-]'),
                        ),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const Gap(20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => setState(() => isChecked = !isChecked),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            width: 20, // Checkbox size
                            height: 20, // Checkbox size
                            child: isChecked
                                ? const Icon(Icons.check,
                                    size: 14, color: Colors.black)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8), // You can adjust this space
                        const Text(
                          'Permanent Address same as Current Address?',
                          style: TextStyle(color: Color(0xFF565A5F)),
                        ),
                      ],
                    ),
                    if (errorMsg != null && errorMsg!.isNotEmpty)
                      ErrorInfoWidget(otpErrorMsg: errorMsg),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
