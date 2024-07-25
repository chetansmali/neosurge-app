import 'dart:developer';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'string_list_screen.dart';
import '../../widgets/error_info_widget.dart';

import '../../../common/custom_styles.dart';
import '../../../common/formatters.dart';
import '../../../common/utils.dart';
import '../../../common/validators.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../constants/kyc_steps_constants.dart';
import '../../../constants/meta_strings.dart';
import '../../../data/models/dropdowns/country_model.dart';
import '../../../di/get_it.dart';
import '../../../domain/entities/params/kyc/upload_fatca_details_params.dart';
import '../../../domain/entities/params/no_params.dart';
import '../../../domain/usecases/dropdown/get_all_countries.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_fatca_details/upload_fatca_details_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/label_text.dart';

class FatcaDetailsScreen extends StatefulWidget {
  const FatcaDetailsScreen({Key? key}) : super(key: key);

  @override
  State<FatcaDetailsScreen> createState() => _FatcaDetailsScreenState();
}

class _FatcaDetailsScreenState extends State<FatcaDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? _fatcaSourceOfIncome;
  String? _annualIncome;
  bool _isAnotherCountryTaxResident = false;
  CountryModel? _countryOfBirth;
  CountryModel? _taxResidencyCountry;
  String? _typeOfTaxIdentification;
  String? _taxIdentificationNumber;
  List<CountryModel>? _countries;
  List<String> errorMsg = ['error1', 'error2', 'error3'];
  String? errorText;

  @override
  void initState() {
    super.initState();
    _fetchExistingData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;

    log('$maxCompletedStep ${KycCompliantStepsRoutes.fatcaDetails.value} $isKycCompliant');
    if ((maxCompletedStep >= KycCompliantStepsRoutes.fatcaDetails.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.fatcaDetails.value &&
            !isKycCompliant)) {
      context.read<UploadFatcaDetailsCubit>().fetchFatcaDetails();
    }
  }

  int? selectedIndex, selectedIndex2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<UploadFatcaDetailsCubit, UploadFatcaDetailsState>(
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
                          FocusScope.of(context).unfocus();
                          context
                              .read<UploadFatcaDetailsCubit>()
                              .uploadFatcaDetails(UploadFatcaDetailsParams(
                                  haveAnotherTaxResidence:
                                      _isAnotherCountryTaxResident,
                                  taxResidencyCountryId:
                                      _isAnotherCountryTaxResident
                                          ? _taxResidencyCountry!.id
                                          : null,
                                  countryOfBirthId: _countryOfBirth!.id,
                                  typeOfTaxIdentification:
                                      _isAnotherCountryTaxResident
                                          ? _typeOfTaxIdentification!
                                          : null,
                                  taxIdentificationNum:
                                      _isAnotherCountryTaxResident
                                          ? _taxIdentificationNumber!
                                          : null,
                                  fatcaSourceOfWealthId: _fatcaSourceOfIncome!,
                                  grossAnnualIncome:
                                      double.parse(_annualIncome!)));
                        } else {
                          Utils.showWarningAlert(
                              context, 'Please fill in all required fields');
                        }
                      }
                    : null,
                child: state is UploadFatcaDetailsLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Next'),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<UploadFatcaDetailsCubit, UploadFatcaDetailsState>(
        listener: (context, state) {
          if (state is UploadFatcaDetailsSuccess && !state.isFetch) {
            context.read<OnboardingPageCubit>().goToNextPage();
            return;
          }
          if (state is UploadFatcaDetailsSuccess && state.isFetch) {
            final model = state.fatcaDetails!;
            _fatcaSourceOfIncome = model.fatcaSourceOfWealth.value;
            selectedIndex = _fatcaSourceOfIncome;

            _annualIncome = NumberFormat.currency(
              locale: 'en_IN',
              decimalDigits: 0,
              symbol: '',
            ).format(model.grossAnnualIncome);
            _isAnotherCountryTaxResident = model.haveAnotherTaxResidence;
            _countryOfBirth = CountryModel(
              id: model.countryOfBirth.value,
              name: model.countryOfBirth.name,
            );

            selectedIndex2 = model.countryOfBirth.value;

            _taxResidencyCountry = model.taxResidencyCountry == null
                ? null
                : CountryModel(
                    id: model.taxResidencyCountry!.value,
                    name: model.taxResidencyCountry!.name);
            _typeOfTaxIdentification = model.typeOfTaxIdentification;
            _taxIdentificationNumber = model.taxIdentificationNum;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              var validation = _formKey.currentState!.validate();
              if (validation) {
                _formKey.currentState!.save();
                setState(() {
                  errorMsg = ['null', 'null', 'null'];
                });
              }
            });
          }
          if (state is UploadFatcaDetailsFailure && !state.isFetch) {
            // Utils.showErrorAlert(
            //   context,
            //   Utils.getErrorMessage(errorType: state.appErrorType, msg: state.errorMessage),
            // );
            // return;
          }
        },
        builder: (context, state) {
          if (state is UploadFatcaDetailsLoading && state.isFetch) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (state is UploadFatcaDetailsFailure && state.isFetch) {
            return Center(
              child: Text(Utils.getErrorMessage(
                  errorType: state.appErrorType, msg: state.errorMessage)),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FATCA Details",
                          style: baseTextStyle.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20),
                        const LabelText(label: 'Source of Income'),
                        // DropdownSearch<DropDownItem?>(
                        //   items: DropDownConstants.incomeSourceList,
                        //   autoValidateMode: AutovalidateMode.onUserInteraction,
                        //   dropdownDecoratorProps: DropDownDecoratorProps(
                        //     dropdownSearchDecoration: CustomStyles.dropDownDecoration,
                        //   ),
                        //   popupProps: const PopupProps.menu(),
                        //   itemAsString: (DropDownItem? item) => item!.name,
                        //   validator: (DropDownItem? value) => Validators.validateEmptyField(ValidatorStrings.emptyStateField, value?.name),
                        //   onChanged: (DropDownItem? value) {
                        //     _fatcaSourceOfIncome = value!.value;
                        //   },
                        //   selectedItem: _fatcaSourceOfIncome == null
                        //       ? null
                        //       : DropDownConstants.incomeSourceList.firstWhere(
                        //         (element) => element.value == _fatcaSourceOfIncome,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute<int>(
                                builder: (context) => const StringListScreen(
                                  title: 'source of income.',
                                  items: DropDownConstants.incomeSourceList,
                                ),
                              ),
                            );

                            if (result != null) {
                              errorMsg[0] = 'null';
                              setState(() {
                                selectedIndex = result;
                              });
                              _fatcaSourceOfIncome = result;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (selectedIndex == null)
                                      ? const SizedBox.shrink()
                                      : Text(DropDownConstants
                                          .incomeSourceList[selectedIndex! - 1]
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
                        const Gap(20),
                        const LabelText(label: 'Annual Income'),

                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              errorMsg[1] = Validators.validateEmptyField(
                                      ValidatorStrings.emptyAnnualIncome, value)
                                  .toString();
                              errorText = errorMsg[1];
                            });
                          },
                          validator: (value) => Validators.validateEmptyField(
                              ValidatorStrings.emptyAnnualIncome, value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _annualIncome,
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onSaved: (value) =>
                              _annualIncome = value?.replaceAll(',', ''),
                          decoration: InputDecoration(
                            fillColor:
                                errorMsg[1] == 'null' || errorMsg[1] == 'error2'
                                    ? AppColors.lightGrey
                                    : AppColors.errorRed.withOpacity(0.08),
                            errorStyle: const TextStyle(
                              fontSize: 0,
                            ),
                            hintText: 'in terms of 1,000s',
                            prefixText: '\u20B9 ',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyTextInputFormatter(
                                locale: 'en_IN', decimalDigits: 0, symbol: ''),
                          ],
                        ),

                        const Gap(20),
                        const LabelText(label: 'Country of Birth'),
                        // DropdownSearch<CountryModel?>(
                        //   asyncItems: (text) async => await _getCountries(),
                        //   autoValidateMode: AutovalidateMode.onUserInteraction,
                        //   dropdownDecoratorProps: DropDownDecoratorProps(
                        //     dropdownSearchDecoration: CustomStyles.dropDownDecoration,
                        //   ),
                        //   selectedItem: _countryOfBirth,
                        //   validator: (value) => Validators.validateEmptyField(ValidatorStrings.emptyCountryOfBirth, value?.toString()),
                        //   items: _countries ?? [],
                        //   popupProps: PopupProps.modalBottomSheet(
                        //     showSearchBox: true,
                        //     searchFieldProps: const TextFieldProps(autofocus: true),
                        //     errorBuilder: (context, error, dynamic exception) => Center(
                        //       child: Text(
                        //         exception.toString(),
                        //       ),
                        //     ),
                        //     itemBuilder: (context, CountryModel? item, isSelected) => ListTile(
                        //       title: Text(item!.name),
                        //       selected: _countryOfBirth == item,
                        //     ),
                        //   ),
                        //   onChanged: (CountryModel? value) {
                        //     _countryOfBirth = value;
                        //   },
                        //   itemAsString: (CountryModel? country) => country!.name,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            await _getCountries();

                            if (!context.mounted) return;

                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute<int>(
                                builder: (context) => StringListScreen2(
                                  title: 'Country of birth.',
                                  items: _countries ?? [],
                                ),
                              ),
                            );
                            if (result != null &&
                                result < (_countries?.length ?? 0)) {
                              setState(() {
                                selectedIndex2 = result;
                                _countryOfBirth =
                                    _countries![selectedIndex2! - 1];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (selectedIndex2 == null)
                                      ? const SizedBox.shrink()
                                      : Text(_countryOfBirth?.name ?? ""),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(30),
                        const LabelText(
                            label: 'Do you pay tax in another country?'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isAnotherCountryTaxResident = true;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(
                                                (_isAnotherCountryTaxResident ==
                                                        true)
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
                                        'Yes',
                                        style: baseTextStyle.copyWith(
                                            color:
                                                (_isAnotherCountryTaxResident ==
                                                        true)
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
                                    _isAnotherCountryTaxResident = false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(
                                                (_isAnotherCountryTaxResident ==
                                                        false)
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
                                        'No',
                                        style: baseTextStyle.copyWith(
                                            color:
                                                (_isAnotherCountryTaxResident ==
                                                        false)
                                                    ? Colors.white
                                                    : Colors.black),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const Gap(30),
                        if (_isAnotherCountryTaxResident) ...[
                          const LabelText(label: 'Country of Tax Residence'),
                          DropdownSearch<CountryModel?>(
                            asyncItems: (text) async => await _getCountries(),
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  CustomStyles.dropDownDecoration,
                            ),
                            items: _countries ?? [],
                            selectedItem: _taxResidencyCountry,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyCountryOfTaxResidency,
                                value?.toString()),
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchFieldProps:
                                  const TextFieldProps(autofocus: true),
                              errorBuilder:
                                  (context, error, dynamic exception) => Center(
                                child: Text(
                                  exception.toString(),
                                ),
                              ),
                              itemBuilder:
                                  (context, CountryModel? item, isSelected) =>
                                      ListTile(
                                title: Text(item!.name),
                                selected: _taxResidencyCountry == item,
                              ),
                            ),
                            itemAsString: (CountryModel? country) =>
                                country!.name,
                            onChanged: (CountryModel? value) {
                              _taxResidencyCountry = value;
                            },
                          ),
                          const Gap(30),
                          const LabelText(label: 'Type of Tax Identification'),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: _typeOfTaxIdentification,
                            textInputAction: TextInputAction.next,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyTaxIdentificationType,
                                value),
                            onSaved: (value) =>
                                _typeOfTaxIdentification = value,
                          ),
                          const Gap(30),
                          const LabelText(label: 'Tax Identification Number'),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: _taxIdentificationNumber,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyTaxIdentificationNumber,
                                value),
                            onSaved: (value) =>
                                _taxIdentificationNumber = value,
                          ),
                        ],
                        const Spacer(),

                        const Gap(20),
                        const Spacer(),
                        if (errorText != 'null' && errorText != null)
                          ErrorInfoWidget(otpErrorMsg: errorText),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<CountryModel>> _getCountries() async {
    List<CountryModel> countries = [];
    if (_countries != null) {
      return _countries!;
    }
    final response = await getIt<GetAllCountries>().call(NoParams());
    response.fold((l) {
      throw Utils.getErrorMessage(errorType: l.errorType, msg: l.error);
    }, (r) {
      countries = r;
      _countries = r;
    });
    return countries;
  }
}
