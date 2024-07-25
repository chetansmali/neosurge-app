import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../widgets/error_info_widget.dart';
import '../../../common/formatters.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/kyc_steps_constants.dart';
import '../../../data/models/user/user.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/onboarding/confirm_pan/confirm_pan_cubit.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/label_text.dart';

class ConfirmPanDetailsScreen extends StatefulWidget {
  final bool isCompliant;
  final String panNumber;
  final String fullName;

  const ConfirmPanDetailsScreen({
    Key? key,
    this.isCompliant = true,
    required this.panNumber,
    required this.fullName,
  }) : super(key: key);

  @override
  State<ConfirmPanDetailsScreen> createState() =>
      _ConfirmPanDetailsScreenState();
}

class _ConfirmPanDetailsScreenState extends State<ConfirmPanDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _dobController;
  String? _fullName;
  String? _panNumber;
  DateTime? _dateOfBirth;
  bool isEditing = false;
  String? _errorDOBMsg, _errorPanmsg, errorMsg, _errorNameMsg;

  @override
  void initState() {
    super.initState();
    _fullName = widget.fullName;
    _panNumber = widget.panNumber;
    _dobController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _fetchExistingData();
    super.didChangeDependencies();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if ((maxCompletedStep >= KycCompliantStepsRoutes.confirmPan.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.confirmPan.value &&
            !isKycCompliant)) {
      context.read<ConfirmPanCubit>().fetchPanData();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(2016, 10, 26);

    return BlocConsumer<ConfirmPanCubit, ConfirmPanState>(
      listener: (context, state) {
        if (state is ConfirmPanSuccess && state.isFetch) {
          _fullName = state.kycData!.panFullName;
          _panNumber = state.kycData!.panNum;
          final formattedDob = state.kycData!.dateOfBirth == null
              ? null
              : DateFormat('dd-MM-yyyy').format(state.kycData!.dateOfBirth!);
          _dobController.text = formattedDob ?? '';
        }
        if (state is ConfirmPanSuccess && !state.isFetch) {
          final User user = context.read<AuthCubit>().state.user!;
          if (user.maxStepCount == 1) {
            context.read<AuthCubit>().updateUser(
                  user.copyWith(maxStepCount: 2),
                );
          }
          context.read<OnboardingPageCubit>().goToNextPage();
          return;
        }
        if (state is ConfirmPanFailure && !state.isFetch) {
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(
              errorType: state.errorType,
              msg: state.errorMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ConfirmPanLoading && state.isFetch) {
          return const Center(child: CustomLoader());
        }
        if (state is ConfirmPanFailure && state.isFetch) {
          return Center(
            child: AppErrorWidget(
                errorType: state.errorType, error: state.errorMessage),
          );
        }
        return Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isCompliant
                                ? "Confirm PAN Details"
                                : "Enter Pan Card Details",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(25),
                          const LabelText(
                            label: 'Name',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            readOnly: !isEditing,
                            initialValue: _panNumber,
                            onSaved: (value) => _panNumber = value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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

                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  'assets/icons/edit.png',
                                  height: 20,
                                  width: 20,
                                ), // Change this icon to whatever you want
                                onPressed: () {
                                  // Handle button tap

                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                },
                              ),
                            ),
                          ),
                          const Gap(20),
                          const LabelText(label: 'Date of Birth'),
                          const Gap(10),
                          TextFormField(
                            controller: _dobController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.datetime,
                            readOnly: true,
                            onTap: () {
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
                                },
                              );
                            },
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
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              use24hFormat: true,
                                              showDayOfWeek: true,
                                              onDateTimeChanged:
                                                  (DateTime newDate) {
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
                          const Spacer(),
                          if (errorMsg != null && errorMsg!.isNotEmpty)
                            ErrorInfoWidget(otpErrorMsg: errorMsg),
                          const Gap(20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.read<ConfirmPanCubit>().confirmPan(
                                        panNumber: _panNumber!,
                                        fullName: _fullName!.trim(),
                                        dateOfBirth: _dateOfBirth != null
                                            ? DateFormat('yyyy-MM-dd')
                                                .format(_dateOfBirth!)
                                            : DateFormat('yyyy-MM-dd').format(
                                                DateFormat('dd-MM-yyyy').parse(
                                                    _dobController.text)),
                                        isCompliant: widget.isCompliant,
                                      );
                                }
                              },
                              child: const Text('Confirm'),
                            ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
