import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'string_list_screen.dart';
import '../../widgets/error_info_widget.dart';

import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../constants/kyc_steps_constants.dart';
import '../../../constants/meta_strings.dart';
import '../../../data/models/kyc/get_kyc_personal_details_model.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/kyc/upload_personal_details_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_personal_details/upload_personal_details_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/label_text.dart';

class UploadPersonalDetailsScreen extends StatefulWidget {
  const UploadPersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UploadPersonalDetailsScreen> createState() =>
      _UploadPersonalDetailsScreenState();
}

class _UploadPersonalDetailsScreenState
    extends State<UploadPersonalDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _fatherName;
  String? _motherName;
  int? _maritalStatusId;
  int? _occupationId;
  static const int _kycRelationId =
      2; //Set default relation to Father // not to be changed without consulting backend
  List<String> errorMsg = ['error1', 'error2', 'error3', 'error4'];
  String? errorText;

  Gender _gender = Gender.male;
  Nationality _nationality = Nationality.indian;
  bool _politicallyExposedPerson = false;
  bool _relatedToPoliticallyExposedPerson = false;
  final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  int? selectedIndex;

  @override
  void initState() {
    _fetchExistingData();
    super.initState();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if ((maxCompletedStep >= KycCompliantStepsRoutes.personalDetails.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.personalDetails.value &&
            !isKycCompliant)) {
      context.read<UploadPersonalDetailsCubit>().fetchPersonalDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<UploadPersonalDetailsCubit, UploadPersonalDetailsState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: errorMsg[0] == 'null' &&
                        errorMsg[1] == 'null' &&
                        errorMsg[2] == 'null' &&
                        errorMsg[3] == 'null'
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          context
                              .read<UploadPersonalDetailsCubit>()
                              .uploadPersonalDetails(
                                  UploadPersonalDetailsParams(
                                      fatherName: _fatherName!.trim(),
                                      motherName: _motherName!.trim(),
                                      gender: _gender,
                                      maritalStatusId: _maritalStatusId!,
                                      kycRelationTypeId: _kycRelationId,
                                      // need to be changed
                                      occupationId: _occupationId!,
                                      isRelationWithPoliticallyExposedPerson:
                                          _relatedToPoliticallyExposedPerson,
                                      politicalExposure:
                                          _politicallyExposedPerson));
                          // context
                          //     .read<OnboardingPageCubit>()
                          //     .goToNextPage();
                        }
                      }
                    : null,
                child: state is UploadPersonalDetailsLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              ),
            ),
          );
        },
      ),
      body:
          BlocConsumer<UploadPersonalDetailsCubit, UploadPersonalDetailsState>(
        listener: (context, state) {
          if (state is UploadPersonalDetailsSuccess && !state.isFetch) {
            context.read<OnboardingPageCubit>().goToNextPage();
            return;
          }
          if (state is UploadPersonalDetailsFailure && !state.isFetch) {
            Utils.showErrorAlert(
              context,
              Utils.getErrorMessage(
                  errorType: state.errorType, msg: state.errorMessage),
            );
            return;
          }

          if (state is UploadPersonalDetailsSuccess && state.isFetch) {
            GetKycPersonalDetailsModel model =
                state.getKycPersonalDetailsModel!;
            _fatherName = model.fatherName;
            _motherName = model.motherName;

            _maritalStatusId = model.maritalStatus.value;
            _gender = model.gender.value == 1
                ? Gender.male
                : model.gender.value == 2
                    ? Gender.female
                    : Gender.transgender;

            _occupationId = model.occupationType.value;
            selectedIndex = _occupationId;
            _politicallyExposedPerson = model.isPoliticallyExposedPerson;
            _relatedToPoliticallyExposedPerson =
                model.isRelationWithPoliticallyExposedPerson;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              var validation = _formKey.currentState!.validate();
              if (validation) {
                _formKey.currentState!.save();
                setState(() {
                  errorMsg = ['null', 'null', 'null', 'null'];
                });
              }
            });
          }
        },
        builder: (context, state) {
          if (state is UploadPersonalDetailsLoading && state.isFetch) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (state is UploadPersonalDetailsFailure && state.isFetch) {
            return const Center(
              child: Text('Failed to fetch personal details'),
            );
          }
          return CustomScrollView(slivers: [
            Form(
              key: _formKey,
              child: SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Details",
                        style: baseTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                      const Gap(10),
                      const LabelText(label: 'Father\'s Name'),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              errorMsg[0] == 'null' || errorMsg[0] == 'error1'
                                  ? AppColors.lightGrey
                                  : AppColors.errorRed.withOpacity(0.08),
                          errorStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            errorMsg[0] = Validators.validateEmptyField(
                                    ValidatorStrings.emptyFathersNameField,
                                    value)
                                .toString();
                            errorText = errorMsg[0];
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        autofocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) => _fatherName = value?.trim(),
                        initialValue: _fatherName,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z .]'),
                          ),
                          //Deny more than one space between words
                          // FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                        ],
                        validator: (value) => Validators.validateEmptyField(
                            ValidatorStrings.emptyFathersNameField, value),
                      ),
                      const Gap(10),
                      const LabelText(
                        label: 'Mother\'s Name',
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              errorMsg[1] == 'null' || errorMsg[1] == 'error2'
                                  ? AppColors.lightGrey
                                  : AppColors.errorRed.withOpacity(0.08),
                          errorStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            errorMsg[1] = Validators.validateEmptyField(
                                    ValidatorStrings.emptyFathersNameField,
                                    value)
                                .toString();
                            errorText = errorMsg[1];
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) => _motherName = value?.trim(),
                        textInputAction: TextInputAction.next,
                        initialValue: _motherName,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z .]'),
                          ),
                          //Deny more than one space between words
                          // FilteringTextInputFormatter.deny(RegExp(r'\s{2,}')),
                        ],
                        validator: (value) => Validators.validateEmptyField(
                            ValidatorStrings.emptyMothersNameField, value),
                      ),
                      const Gap(10),

                      const LabelText(label: 'Occupation'),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute<int>(
                              builder: (context) => const StringListScreen(
                                title: 'Occupation',
                                items: DropDownConstants.occupationTypeList,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedIndex = result;
                              _occupationId = result;
                              errorMsg[2] = 'null';
                            });
                          }
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                              color: const Color(0xFFEBEBEB),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 12, bottom: 12, top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (selectedIndex == null)
                                    ? const SizedBox.shrink()
                                    : Text(DropDownConstants
                                        .occupationTypeList[selectedIndex! - 1]
                                        .name),
                                const Icon(
                                  Icons.arrow_right,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // DropdownSearch<DropDownItem?>(
                      //   dropdownDecoratorProps: DropDownDecoratorProps(
                      //     dropdownSearchDecoration: CustomStyles.dropDownDecoration,
                      //   ),
                      //   selectedItem: _occupationId == null
                      //       ? null
                      //       : DropDownConstants.occupationTypeList.firstWhere(
                      //         (element) => element.value == _occupationId,
                      //   ),
                      //   autoValidateMode: AutovalidateMode.onUserInteraction,
                      //   validator: (DropDownItem? value) => Validators.validateEmptyField(ValidatorStrings.emptyOccupationType, value?.name),
                      //   items: DropDownConstants.occupationTypeList,
                      //   popupProps: const PopupProps.menu(),
                      //   onChanged: (DropDownItem? value) {
                      //     _occupationId = value!.value;
                      //   },
                      //   itemAsString: (DropDownItem? item) => item!.name,
                      // ),

                      const Gap(10),
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
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
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
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
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
                                      color: Color(
                                              (_gender == Gender.transgender)
                                                  ? 0xFF5B89FA
                                                  : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
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
                      const Gap(10),
                      const LabelText(label: 'Marital Status'),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _maritalStatusId = 1;
                                  errorMsg[3] = 'null';
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_maritalStatusId == 1)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Married',
                                      style: baseTextStyle.copyWith(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: (_maritalStatusId == 1)
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
                                  _maritalStatusId = 2;
                                  errorMsg[3] = 'null';
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_maritalStatusId == 2)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Unmarried',
                                      style: baseTextStyle.copyWith(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: (_maritalStatusId == 2)
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
                                  _maritalStatusId = 3;
                                  errorMsg[3] = 'null';
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_maritalStatusId == 3)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Others',
                                      style: baseTextStyle.copyWith(
                                          color: (_maritalStatusId == 3)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      const Gap(10),
                      const LabelText(label: 'Nationality'),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _nationality = Nationality.indian;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_nationality ==
                                                  Nationality.indian)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Indian',
                                      style: baseTextStyle.copyWith(
                                          color: (_nationality ==
                                                  Nationality.indian)
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
                                  _nationality = Nationality.nri;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                              (_nationality == Nationality.nri)
                                                  ? 0xFF5B89FA
                                                  : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'NRI',
                                      style: baseTextStyle.copyWith(
                                          color:
                                              (_nationality == Nationality.nri)
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      const LabelText(
                          label: 'Are you Politically Exposed Person?'),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _politicallyExposedPerson = true;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_politicallyExposedPerson ==
                                                  true)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Yes',
                                      style: baseTextStyle.copyWith(
                                          color: (_politicallyExposedPerson ==
                                                  true)
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
                                  _politicallyExposedPerson = false;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color((_politicallyExposedPerson ==
                                                  false)
                                              ? 0xFF5B89FA
                                              : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'No',
                                      style: baseTextStyle.copyWith(
                                          color: (_politicallyExposedPerson ==
                                                  false)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      const LabelText(
                          label:
                              'Are you related to Politically Exposed Person?'),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _relatedToPoliticallyExposedPerson = true;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                              (_relatedToPoliticallyExposedPerson ==
                                                      true)
                                                  ? 0xFF5B89FA
                                                  : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'Yes',
                                      style: baseTextStyle.copyWith(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              (_relatedToPoliticallyExposedPerson ==
                                                      true)
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
                                  _relatedToPoliticallyExposedPerson = false;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                              (_relatedToPoliticallyExposedPerson ==
                                                      false)
                                                  ? 0xFF5B89FA
                                                  : 0xFFFFFFFF)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 7,
                                        bottom: 7),
                                    child: Text(
                                      'No',
                                      style: baseTextStyle.copyWith(
                                          color:
                                              (_relatedToPoliticallyExposedPerson ==
                                                      false)
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      const Gap(10),
                      if (errorText != 'null' && errorText != null)
                        ErrorInfoWidget(otpErrorMsg: errorText),

                      const Gap(20),
                    ],
                  ),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
