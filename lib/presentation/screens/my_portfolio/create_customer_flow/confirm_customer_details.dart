import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../widgets/error_info_widget.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/formatters.dart';
import '../../../../common/validators.dart';
import '../../../../domain/entities/enums.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/label_text.dart';
import 'confirm_customer_address.dart';

class ConfirmCustomerDetails extends StatefulWidget {
  const ConfirmCustomerDetails({Key? key}) : super(key: key);

  @override
  State<ConfirmCustomerDetails> createState() => _ConfirmCustomerDetailsState();
}

class _ConfirmCustomerDetailsState extends State<ConfirmCustomerDetails> {
  late final TextEditingController _dobController;
  String? _fullName;
  String? _panNumber;
  bool isEdit = false;
  Gender _gender = Gender.male;

  String? _errorDOBMsg, _errorPanmsg, errorMsg, _errorNameMsg;

  @override
  void initState() {
    super.initState();
    _fullName = 'Tanishk';
    _panNumber = '1234123412';
    _dobController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(2016, 10, 26);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ConfirmCustomerAddressScreen()));
            },
            child: const Text('Continue'),
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
                    Text(
                      "Confirm your Details",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                      textAlign: TextAlign.start,
                    ),
                    const Gap(25),
                    const LabelText(
                      label: 'First Name',
                    ),
                    const Gap(10),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: _errorNameMsg == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                      ),
                      // TO Change to widget.isCompliant //
                      readOnly: false,
                      initialValue: _fullName,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z .]'),
                        ),
                      ],
                      textCapitalization: TextCapitalization.words,
                      onSaved: (value) => _fullName = value,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          _errorNameMsg = Validators.validateEmptyField(
                              'Please enter full name', value);
                          errorMsg = _errorNameMsg;
                        });
                      },
                      validator: (value) {
                        return Validators.validateEmptyField(
                          'Please enter full name',
                          value,
                        );
                      },
                    ),
                    const Gap(20),
                    const LabelText(
                      label: 'Last Name',
                    ),
                    const Gap(10),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: _errorNameMsg == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                      ),
                      // TO Change to widget.isCompliant //
                      readOnly: false,
                      initialValue: _fullName,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z .]'),
                        ),
                      ],
                      textCapitalization: TextCapitalization.words,
                      onSaved: (value) => _fullName = value,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          _errorNameMsg = Validators.validateEmptyField(
                              'Please enter full name', value);
                          errorMsg = _errorNameMsg;
                        });
                      },
                      validator: (value) {
                        return Validators.validateEmptyField(
                          'Please enter full name',
                          value,
                        );
                      },
                    ),
                    const Gap(20),
                    const LabelText(label: 'PAN Number'),
                    const Gap(10),
                    TextFormField(
                      readOnly: isEdit,
                      initialValue: _panNumber,
                      onSaved: (value) => _panNumber = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          errorMsg = Validators.validatePanNumber(value);
                          _errorPanmsg = errorMsg;
                        });
                      },
                      validator: Validators.validatePanNumber,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d]'),
                        ),
                        LengthLimitingTextInputFormatter(10),
                        // UpperCaseTextFormatter(),
                      ],
                      decoration: InputDecoration(
                        // <-- Add this
                        fillColor: _errorPanmsg == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),

                        // suffixIcon: IconButton(
                        //   icon: Image.asset(
                        //     'assets/icons/edit.png',
                        //     height: 20,
                        //     width: 20,
                        //   ), // Change this icon to whatever you want
                        //   onPressed: () {
                        //     // Handle button tap
                        //
                        //     setState(() {
                        //       isEdit = !isEdit;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                    const Gap(20),
                    const LabelText(label: 'Date of Birth'),
                    const Gap(10),
                    TextFormField(
                      controller: _dobController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        String? err = Validators.dobValidator(value!,
                            shouldBeAdult: true);
                        errorMsg = err;
                        _errorDOBMsg = err;
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'\d'),
                        ),
                        LengthLimitingTextInputFormatter(10),
                        DateTextFormatter(),
                      ],
                      onChanged: (value) => value.length == 10
                          ? //Remove focus from the field
                          FocusScope.of(context).unfocus()
                          : null,
                      decoration: InputDecoration(
                        fillColor: _errorDOBMsg == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            'assets/icons/calender.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return SizedBox(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height /
                                        3,
                                    child: Center(
                                      child: CupertinoDatePicker(
                                        initialDateTime: date,
                                        mode: CupertinoDatePickerMode.date,
                                        use24hFormat: true,
                                        showDayOfWeek: true,
                                        onDateTimeChanged: (DateTime newDate) {
                                          setState(() {
                                            _dobController.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(newDate);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    const Gap(20),
                    const LabelText(label: 'Gender'),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _gender = Gender.male;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color((_gender == Gender.male)
                                            ? 0xFF5B89FA
                                            : 0xFFFFFFFF)
                                        .withOpacity(1),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12, top: 7, bottom: 7),
                                  child: Text(
                                    'Male',
                                    style: baseTextStyle.copyWith(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: (_gender == Gender.male)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _gender = Gender.female;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color((_gender == Gender.female)
                                            ? 0xFF5B89FA
                                            : 0xFFFFFFFF)
                                        .withOpacity(1),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12, top: 7, bottom: 7),
                                  child: Text(
                                    'Female',
                                    style: baseTextStyle.copyWith(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: (_gender == Gender.female)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _gender = Gender.transgender;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color((_gender == Gender.transgender)
                                            ? 0xFF5B89FA
                                            : 0xFFFFFFFF)
                                        .withOpacity(1),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12, top: 7, bottom: 7),
                                  child: Text(
                                    'Transgender',
                                    style: baseTextStyle.copyWith(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: (_gender == Gender.transgender)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
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
