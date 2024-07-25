import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../domain/entities/params/lamf/initiate_loan_import_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/lamf/get_initiate_import_loans/get_initiate_import_loans_cubit.dart';
import '../../cubits/lamf/loan_import_details/loan_import_details_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/error_info_widget.dart';
import 'import_loan_form_fail_screen.dart';

class ImportLoanForm extends StatefulWidget {
  const ImportLoanForm({super.key});

  @override
  State<ImportLoanForm> createState() => _ImportLoanFormState();
}

class _ImportLoanFormState extends State<ImportLoanForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  bool _submittingForm = false;
  bool _submitError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoanImportDetailsCubit, LoanImportDetailsState>(
        listener: (context, state) {
          if (state is LoanImportDetailsSuccess) {
            if (_firstNameController.text.isEmpty) {
              _firstNameController.text =
                  state.loanImportDetailsResponse.firstName ?? '';
            }
            if (_lastNameController.text.isEmpty) {
              _lastNameController.text =
                  state.loanImportDetailsResponse.lastName ?? '';
            }
            if (_phoneController.text.isEmpty) {
              _phoneController.text =
                  state.loanImportDetailsResponse.mobile ?? '';
            }
            if (_dobController.text.isEmpty) {
              _dobController.text = state.loanImportDetailsResponse.dob ?? '';
            }
            if (_emailController.text.isEmpty) {
              _emailController.text =
                  state.loanImportDetailsResponse.email ?? '';
            }
            if (_panController.text.isEmpty) {
              _panController.text = state.loanImportDetailsResponse.pan ?? '';
            }
          }
        },
        builder: (context, state) {
          switch (state) {
            case LoanImportDetailsLoading():
              return const Center(
                child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round),
              );
            case LoanImportDetailsFailure():
              return AppErrorWidget(
                errorType: state.appErrorType,
                error: state.errorMessage,
                onRetry: () => context
                    .read<LoanImportDetailsCubit>()
                    .getLoanImportDetails(),
              );
            case LoanImportDetailsSuccess():
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                controller: _firstNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    nameValidator(value!, true),
                              ),
                              const Gap(16),
                              Text(
                                'Last Name',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                controller: _lastNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    nameValidator(value!, false),
                              ),
                              const Gap(16),
                              Text(
                                'Date of Birth',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                onTap: () async {
                                  final DateTime currDate = DateTime.now();
                                  await showModalBottomSheet<DateTime?>(
                                    context: context,
                                    builder: (context) => SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              3.0,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (date) {
                                          setState(() => _dobController.text =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(date));
                                        },
                                        initialDateTime: _dobController
                                                .text.isNotEmpty
                                            ? Utils.formatStringToDate(
                                                _dobController.text)
                                            : state.loanImportDetailsResponse
                                                        .dob !=
                                                    null
                                                ? Utils.formatStringToDate(state
                                                    .loanImportDetailsResponse
                                                    .dob!)
                                                : DateTime(
                                                    currDate.year - 18,
                                                    currDate.month,
                                                    currDate.day,
                                                  ),
                                        maximumDate: DateTime(
                                          currDate.year - 18,
                                          currDate.month,
                                          currDate.day,
                                        ),
                                        minimumDate: DateTime(
                                          currDate.year - 65,
                                          currDate.month,
                                          currDate.day,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                controller: _dobController,
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    Validators.validateDateOfBirth(value!),
                              ),
                              const Gap(16),
                              Text(
                                'Mobile number',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    Validators.validateMobileNumber(value!),
                                decoration:
                                    const InputDecoration(prefixText: '+91 '),
                              ),
                              const Gap(16),
                              Text(
                                'Email address',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    Validators.validateEmail(value!),
                              ),
                              const Gap(16),
                              Text(
                                'PAN',
                                style: baseTextStyle14500,
                              ),
                              const Gap(8),
                              TextFormField(
                                controller: _panController,
                                textInputAction: TextInputAction.done,
                                validator: (value) =>
                                    Validators.validatePanNumber(value!),
                              ),
                              const Gap(24),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        if (_submitError) const Gap(16),
                        if (_submitError)
                          const ErrorInfoWidget(
                              otpErrorMsg: 'Could not make request'),
                        const Gap(16),
                        BlocConsumer<GetInitiateImportLoansCubit,
                            GetInitiateImportLoansState>(
                          listener: (context, state) {
                            switch (state) {
                              case GetInitiateImportLoansLoading():
                                setState(() => _submittingForm = true);
                              case GetInitiateImportLoansSuccess():
                                {
                                  setState(() => _submittingForm = false);
                                  if (state.getInitiateLoanImportResponse
                                              .questionKey !=
                                          null &&
                                      state.getInitiateLoanImportResponse
                                              .answerKey !=
                                          null &&
                                      state.getInitiateLoanImportResponse
                                              .accessToken !=
                                          null) {
                                    Navigator.pushNamed(context,
                                        Routes.importLoanPhoneValidation,
                                        arguments:
                                            ImportLoanPhoneValidationArgs(
                                          questionKey: state
                                              .getInitiateLoanImportResponse
                                              .questionKey!,
                                          answerKey: state
                                              .getInitiateLoanImportResponse
                                              .answerKey!,
                                          accessToken: state
                                              .getInitiateLoanImportResponse
                                              .accessToken!,
                                          phoneNum:
                                              _phoneController.text.trim(),
                                        ));
                                  } else {
                                    // TODO: Backend needs to send an error response
                                    // of user already being registered. Right
                                    // now frontend is handling it by checking
                                    // if the model parsed correctly or not.
                                    setState(() {
                                      _submittingForm = false;
                                    });

                                    Utils.showWarningAlert(context,
                                        "You've alreaady imported your loans");
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  }
                                }
                              case GetInitiateImportLoansFailure():
                                setState(() {
                                  _submitError = true;
                                  _submittingForm = false;
                                });

                                if (state.errorMessage ==
                                    'Mobile not registered with cibil') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ImportLoanFormFailScreen()),
                                  );
                                }
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<GetInitiateImportLoansCubit>()
                                      .getInitiateImporLoans(
                                          GetInitiateLoanImportsParams(
                                        firstName:
                                            _firstNameController.text.trim(),
                                        lastName:
                                            _lastNameController.text.trim(),
                                        dob: _dobController.text.trim(),
                                        mobile: _phoneController.text.trim(),
                                        pan: _panController.text.trim(),
                                        email: _emailController.text.trim(),
                                      ));
                                }
                              },
                              child: !_submittingForm
                                  ? const Text("Confirm")
                                  : Assets.animations.loading.lottie(),
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(24),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  String? nameValidator(String val, bool first) {
    if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(val)) {
      return null;
    } else {
      return 'Please enter a valid ${first ? 'first' : 'last'} name';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _panController.dispose();
    super.dispose();
  }
}
