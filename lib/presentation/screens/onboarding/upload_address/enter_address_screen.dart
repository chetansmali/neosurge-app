import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/validators.dart';
import '../../../../constants/constants.dart';

import '../../../../data/models/kyc/get_kyc_addresss_details_model.dart';
import '../../../../domain/entities/params/kyc/get_pincode_data_params.dart';
import '../../../../domain/entities/params/kyc/upload_address_details_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/get_data_from_pincode/get_pincode_data_cubit.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_address_details/upload_address_details_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/error_info_widget.dart';
import '../../../widgets/label_text.dart';

class EnterAddressScreen extends StatefulWidget {
  const EnterAddressScreen({
    super.key,
    required this.fullName,
    required this.panNumber,
  });

  final String fullName;
  final String panNumber;

  @override
  State<EnterAddressScreen> createState() => _EnterAddressScreenState();
}

class _EnterAddressScreenState extends State<EnterAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _pinCodeFocusNode;
  String _permAddressLine1 = '';
  String? _permAddressLine2;
  String _permCity = '';
  String _permState = '';
  String? _permPinCode;
  String? errorMsg = '', errorMsgAddress, errorMsgPincode;

  String? _currAddressLine1;
  String? _currAddressLine2;
  String? _currCity;
  int? _currState;
  String? _currPinCode;
  bool _isCurAddressSameAsPerm = true;

  late TextEditingController _permAddressLine1Controller;
  late TextEditingController _permAddressLine2Controller;
  late TextEditingController _permStateController;
  late TextEditingController _permCityController;

  final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

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
  void didChangeDependencies() {
    _fetchExistingData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pinCodeFocusNode.dispose();
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if ((maxCompletedStep >= KycCompliantStepsRoutes.addressDetails.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.addressDetails.value &&
            !isKycCompliant)) {
      context.read<UploadAddressDetailsCubit>().fetchAddressDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<UploadAddressDetailsCubit, UploadAddressDetailsState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: errorMsg != null
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context
                              .read<UploadAddressDetailsCubit>()
                              .uploadAddressDetails(UploadAddressDetailsParams(
                                permAddressLine1: _permAddressLine1.trim(),
                                permAddressLine2: _permAddressLine2!.trim(),
                                permCity: _permCity.trim(),
                                permPincode: int.parse(_permPinCode!),
                                permState: DropDownConstants.statesOfIndiaList
                                    .firstWhere(
                                      (element) =>
                                          element.name.toLowerCase() ==
                                          _permState.toLowerCase(),
                                    )
                                    .value,
                                permSameAsCurr: _isCurAddressSameAsPerm,
                                currAddressLine1: _isCurAddressSameAsPerm
                                    ? null
                                    : _currAddressLine1!.trim(),
                                currAddressLine2: _isCurAddressSameAsPerm
                                    ? null
                                    : _currAddressLine2!.trim(),
                                currCity: _isCurAddressSameAsPerm
                                    ? null
                                    : _currCity!.trim(),
                                currPincode: _isCurAddressSameAsPerm
                                    ? null
                                    : _currPinCode != null
                                        ? int.parse(_currPinCode!)
                                        : null,
                                currState: _isCurAddressSameAsPerm
                                    ? null
                                    : _currState!,
                              ));
                        }
                      },
                child: state is UploadAddressDetailsLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              ),
            ),
          );
        },
      ),
      body: BlocListener<GetPinCodeDataCubit, GetPincodeDataState>(
        listener: (context, state) {
          if (state is GetPincodeDataSuccess) {
            setState(() {
              _permCity = state.pinCodeData.city;
              _permState = state.pinCodeData.stateName;
              _permAddressLine1 = state.pinCodeData.countryName;
              _permCityController.text = _permCity;
              _permStateController.text = _permState;
              _permAddressLine1Controller.text = _permAddressLine1;
            });
          }
        },
        child:
            BlocConsumer<UploadAddressDetailsCubit, UploadAddressDetailsState>(
          listener: (context, state) {
            if (state is UploadAddressDetailsSuccess && !state.isFetch) {
              context.read<OnboardingPageCubit>().goToNextPage();
              return;
            }
            if (state is UploadAddressDetailsSuccess && state.isFetch) {
              GetKycAddressDetailsModel addressDtls = state.kycAddressDetails!;
              log(addressDtls.toJson().toString());
              _permAddressLine1 = addressDtls.permAddressLine1;
              _permAddressLine2 = addressDtls.permAddressLine2;
              _permCity = addressDtls.permCity;
              _permCityController.text = _permCity;
              _permState = addressDtls.permState.name;
              _permStateController.text = _permState;
              _permAddressLine1Controller.text = addressDtls.permCountry.name;
              _permAddressLine2Controller.text = addressDtls.permAddressLine2;
              _permPinCode = addressDtls.permPincode.toString();
              _currAddressLine1 = addressDtls.currAddressLine1;
              _currAddressLine2 = addressDtls.currAddressLine2;
              _currCity = addressDtls.currCity;
              _currState = addressDtls.currState?.value;
              _currPinCode = addressDtls.currPincode.toString();
              _isCurAddressSameAsPerm = addressDtls.permSameAsCurr;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                var validation = _formKey.currentState!.validate();
                if (validation) {
                  _formKey.currentState!.save();
                  setState(() {
                    errorMsg = null;
                  });
                }
              });
            }

            if (state is UploadAddressDetailsFailure) {
              // Utils.showErrorAlert(
              //   context,
              //   Utils.getErrorMessage(
              //       errorType: state.errorType, msg: state.errorMessage),
              // );
              // return;
            }
          },
          builder: (context, state) {
            if (state is UploadAddressDetailsLoading && state.isFetch) {
              return const Center(
                child: CustomLoader(),
              );
            }
            if (state is UploadAddressDetailsFailure && state.isFetch) {
              return const Center(
                  child: Text('Failed to fetch address details'));
            }
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Enter Address',
                                style: baseTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          const Gap(10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Please enter your address details as per Aadhar.',
                                style: baseTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: _permPinCode,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onChanged: (value) async {
                              setState(() {
                                errorMsg = Validators.validatePinCode(value);
                                errorMsgPincode = errorMsg;
                              });
                              if (value.length == 6) {
                                _fetchDetailsByPincode(value);
                              }
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                    ValidatorStrings.emptyAddressLine2Field,
                                    value);
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const Spacer(),
                          if (errorMsg != null &&
                              errorMsg!.isNotEmpty &&
                              errorMsg != '')
                            ErrorInfoWidget(otpErrorMsg: errorMsg),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _fetchDetailsByPincode(String value) async {
    context.read<GetPinCodeDataCubit>().getPincodeData(
          GetPincodeDataParams(
            pinCode: value,
          ),
        );
  }
}
