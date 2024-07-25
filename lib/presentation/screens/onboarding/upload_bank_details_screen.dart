import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../di/get_it.dart';
import '../../../logger.dart';
import '../../cubits/onboarding/verify_bank_account/verify_bank_account_cubit.dart';
import 'bank_account_verification_screen.dart';
import '../../widgets/error_info_widget.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../constants/kyc_steps_constants.dart';
import '../../../constants/meta_strings.dart';
import '../../../domain/entities/params/kyc/upload_bank_details_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_bank_details/upload_bank_details_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/label_text.dart';

class UploadBankDetailsScreen extends StatefulWidget {
  const UploadBankDetailsScreen({
    Key? key,
    required this.fullName,
  }) : super(key: key);

  final String fullName;

  @override
  State<UploadBankDetailsScreen> createState() =>
      _UploadBankDetailsScreenState();
}

class _UploadBankDetailsScreenState extends State<UploadBankDetailsScreen> {
  // BankDetailsFetchType _fetchType = BankDetailsFetchType.manual;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _accHolderNameController;
  late TextEditingController _accNumberController;
  late TextEditingController _ifscController;

  DropDownItem? _accountType = const DropDownItem('Savings', 'Savings');

  @override
  void initState() {
    super.initState();
    _accHolderNameController = TextEditingController(
      text: widget.fullName,
    );
    _accNumberController = TextEditingController();
    _ifscController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _fetchExistingData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _accHolderNameController.dispose();
    _accNumberController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;

    log('maxCompletedStep $maxCompletedStep isKycCompliant $isKycCompliant kycCompliantSteps ${KycCompliantStepsRoutes.bankDetails.value}');
    if ((maxCompletedStep >= KycCompliantStepsRoutes.bankDetails.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.bankDetails.value &&
            !isKycCompliant)) {
      context.read<UploadBankDetailsCubit>().fetchBankDetails();
    }
  }

  List<String> errorMsg = ['null', 'error1', 'error2'];
  String? errorText;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocSelector<GetBankByIfscCubit, GetBankByIfscState,
          GetBankByIfscSuccess?>(
        selector: (state) {
          return state is GetBankByIfscSuccess ? state : null;
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: errorMsg[0] == 'null' &&
                        errorMsg[1] == 'null' &&
                        errorMsg[2] == 'null'
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (state != null) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<UploadBankDetailsCubit>()
                                .uploadBankDetails(
                                  bankDetailsParams: UploadBankDetailsParams(
                                    accountHolderName:
                                        _accHolderNameController.text.trim(),
                                    accountNumber: _accNumberController.text,
                                    bankName: state.bank.bankName,
                                    branchName: state.bank.branchName,
                                    ifscCode: state.bank.ifscCode,
                                    accountType:
                                        _accountType!.value.toString() ==
                                                'Savings'
                                            ? 1
                                            : 2,
                                    isPrimaryAccount: true,
                                  ),
                                );
                            setState(() {
                              _loading = true;
                            });
                          }
                        }
                      }
                    : null,
                child: _loading
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              ),
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocConsumer<UploadBankDetailsCubit, UploadBankDetailsState>(
              listener: (context, state) {
                if (state is UploadBankDetailsSuccess && !state.isFetch) {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => getIt<VerifyBankAccountCubit>()
                              ..verifyBankAccount(),
                          ),
                          BlocProvider.value(
                            value: context.read<OnboardingPageCubit>(),
                          ),
                        ],
                        child: const BankAccountVerificationScreen(),
                      ),
                    ),
                  );

                  setState(() {
                    _loading = false;
                  });

                  return;
                }
                if (state is UploadBankDetailsSuccess && state.isFetch) {
                  _accHolderNameController = TextEditingController(
                    text: state.bankDetails!.accountHolderName,
                  );

                  _accNumberController = TextEditingController(
                    text: state.bankDetails!.accountNumber,
                  );

                  _ifscController = TextEditingController(
                    text: state.bankDetails!.ifscCode,
                  );

                  _accountType = state.bankDetails!.accountType;

                  _loading = false;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {
                      errorMsg = ['null', 'null', 'null'];
                    });
                    context.read<GetBankByIfscCubit>().getBankDetailsByIfsc(
                          ifscCode: state.bankDetails!.ifscCode,
                        );
                  });
                }
                if (state is UploadBankDetailsFailure) {
                  //   Utils.showErrorAlert(
                  //     context,
                  //     Utils.getErrorMessage(
                  //         errorType: state.errorType, msg: state.errorMessage),
                  //   );

                  //   return;
                }
              },
              builder: (BuildContext context, UploadBankDetailsState state) {
                if (state is UploadBankDetailsLoading && state.isFetch) {
                  return const Center(child: CustomLoader());
                }
                if (state is UploadBankDetailsFailure && state.isFetch) {
                  return const Center(
                    child: Text('Failed to fetch bank details'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bank Account Details",
                          style: baseTextStyle.copyWith(fontSize: 18),
                        ),
                        const Gap(5),
                        Text(
                          'We will deposit ₹ 1 to verify your bank account as per SEBI regulations.',
                          style: baseTextStyle.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                        const Gap(30),
                        const LabelText(label: 'Account Type'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _accountType = const DropDownItem(
                                        'Savings', 'Savings');
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color((_accountType?.name ==
                                                    'Savings')
                                                ? 0xFF5B89FA
                                                : 0xFFFFFFFF)
                                            .withOpacity(1),
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          right: 12,
                                          top: 7,
                                          bottom: 7),
                                      child: Text(
                                        'Savings',
                                        style: baseTextStyle.copyWith(
                                            color: (_accountType?.name ==
                                                    'Savings')
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _accountType = const DropDownItem(
                                        'Current', 'Current');
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color((_accountType?.name ==
                                                    'Current')
                                                ? 0xFF5B89FA
                                                : 0xFFFFFFFF)
                                            .withOpacity(1),
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          right: 12,
                                          top: 7,
                                          bottom: 7),
                                      child: Text(
                                        'Current',
                                        style: baseTextStyle.copyWith(
                                            color: (_accountType?.name ==
                                                    'Current')
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const Gap(30),
                        const LabelText(label: 'Name'),
                        TextFormField(
                          controller: _accHolderNameController,
                          onChanged: (value) {
                            setState(() {
                              errorMsg[0] = Validators.validateEmptyField(
                                ValidatorStrings.emptyAccountHolderNameField,
                                value,
                              ).toString();
                              errorText = errorMsg[0];
                            });
                          },

                          textCapitalization: TextCapitalization.words,
                          // onSaved: (value) => _accHoldersName = value,
                          // initialValue: _accHoldersName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            fillColor:
                                errorMsg[0] == 'null' || errorMsg[0] == 'error0'
                                    ? AppColors.lightGrey
                                    : AppColors.errorRed.withOpacity(0.08),
                            errorStyle: const TextStyle(
                              fontSize: 0,
                            ),
                            hintText: 'should match PAN name',
                          ),
                          validator: (value) => Validators.validateEmptyField(
                              ValidatorStrings.emptyAccountHolderNameField,
                              value),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              //Allow only alphabets and one space between words
                              RegExp(r'[a-zA-Z .]'),
                            ),
                            // //Deny more than one space between words
                            // FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                          ],
                        ),
                        const Gap(30),
                        const LabelText(label: 'Account Number'),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              errorMsg[1] =
                                  Validators.validateBankAccountNumber(value)
                                      .toString();
                              errorText = errorMsg[1];
                            });
                          },
                          keyboardType: TextInputType.number,
                          controller: _accNumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          maxLength: 18,
                          decoration: InputDecoration(
                            counterText: '',
                            fillColor:
                                errorMsg[1] == 'null' || errorMsg[1] == 'error1'
                                    ? AppColors.lightGrey
                                    : AppColors.errorRed.withOpacity(0.08),
                            errorStyle: const TextStyle(
                              fontSize: 0,
                            ),
                          ),
                          validator: Validators.validateBankAccountNumber,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              //Allow only numbers
                              RegExp(r'\d'),
                            ),
                          ],
                        ),
                        const Gap(30),
                        const LabelText(label: 'IFSC Code'),
                        BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                          builder: (context, state) {
                            return TextFormField(
                              maxLength: 11,
                              controller: _ifscController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: Validators.validateIFSCCode,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.characters,
                              onChanged: (value) {
                                setState(() {
                                  errorMsg[2] =
                                      Validators.validateIFSCCode(value)
                                          .toString();
                                  errorText = errorMsg[2];
                                });
                                context.read<GetBankByIfscCubit>().reset();
                                if (value.length == 11) {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<GetBankByIfscCubit>()
                                      .getBankDetailsByIfsc(ifscCode: value);
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: errorMsg[2] == 'null' ||
                                        errorMsg[2] == 'error2'
                                    ? AppColors.lightGrey
                                    : AppColors.errorRed.withOpacity(0.08),
                                errorStyle: const TextStyle(
                                  fontSize: 0,
                                ),
                                counterText: '',
                                suffixIcon: state is GetBankByIfscLoading
                                    ? Container(
                                        height: 24,
                                        width: 24,
                                        padding: const EdgeInsets.all(12),
                                        child: const CustomLoader(),
                                      )
                                    : state is GetBankByIfscSuccess
                                        ? const Icon(
                                            Icons.check,
                                            color: AppColors.green,
                                          )
                                        : state is GetBankByIfscFailure
                                            ? const Icon(
                                                Icons.error,
                                                color: AppColors.errorRed,
                                              )
                                            : null,
                                errorText: _errorMessageGetter(state),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                          builder: (context, state) {
                            if (state is GetBankByIfscSuccess) {
                              final bankInfo = state.bank;
                              return Column(
                                children: [
                                  const Gap(30),
                                  const LabelText(label: 'Bank Name'),
                                  TextFormField(
                                    initialValue: bankInfo.bankName,
                                    enabled: false,
                                  ),
                                  const Gap(30),
                                  const LabelText(label: 'Branch Name'),
                                  TextFormField(
                                    initialValue: bankInfo.branchName,
                                    enabled: false,
                                  ),
                                  const Gap(30),
                                  const LabelText(label: 'Branch State'),
                                  TextFormField(
                                    initialValue: bankInfo.state,
                                    enabled: false,
                                  ),
                                  const Gap(30),
                                  const LabelText(label: 'Branch Address'),
                                  TextFormField(
                                    initialValue: bankInfo.branchAddress,
                                    enabled: false,
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const Gap(50),
                        const Spacer(),
                        if (errorText != 'null' && errorText != null)
                          ErrorInfoWidget(otpErrorMsg: errorText),
                        const Gap(20),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String? _errorMessageGetter(GetBankByIfscState state) {
    if (state is GetBankByIfscFailure) {
      return Utils.getErrorMessage(
          errorType: state.errorType, msg: state.errorMessage);
    }
    return null;
  }
}
