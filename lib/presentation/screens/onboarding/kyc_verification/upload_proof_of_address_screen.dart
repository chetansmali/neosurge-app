import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/formatters.dart';
import '../../../../common/utils.dart';
import '../../../../common/validators.dart';
import '../../../../constants/dropdown_constants.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../../constants/meta_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../logger.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_proof_of_address/upload_proof_of_address_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/error_info_widget.dart';
import 'confirm_poa_screen.dart';

class UploadProofOfAddressScreen extends StatefulWidget {
  /// Creates a screen that allows the user to upload a proof of address for KYC verification.
  const UploadProofOfAddressScreen({Key? key}) : super(key: key);

  @override
  State<UploadProofOfAddressScreen> createState() =>
      _UploadProofOfAddressScreenState();
}

class _UploadProofOfAddressScreenState
    extends State<UploadProofOfAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DropDownItem? _addressProofType;
  late final TextEditingController _addressProofController;

  // Front Side of Address Proof
  File? _frontImage;
  bool _isFrontImageValid = true;

  // Back Side of Address Proof
  File? _backImage;
  bool _isBackImageValid = true;

  final ImagePicker _imagePicker = ImagePicker();
  String? _errorMsg;

  bool _isAddressProofNumberValid = true;

  // Edit Mode
  bool _isEditImageMode = false;

  @override
  void initState() {
    super.initState();
    _addressProofController = TextEditingController();

    _fetchExistingData();
  }

  @override
  void dispose() {
    _addressProofController.dispose();
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if (maxCompletedStep >= NonKycFlowRoutes.addressProofUploded.value &&
        !isKycCompliant) {
      context.read<UploadProofOfAddressCubit>().fetchProofOfAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadProofOfAddressCubit, UploadProofOfAddressState>(
      listener: (context, state) {
        if (state is UploadProofOfAddressSuccess && !state.isFetch) {
          context.read<OnboardingPageCubit>().goToNextPage();
          return;
        }
        if (state is UploadProofOfAddressSuccess && state.isFetch) {
          final addressDetails = state.uploadProofOfAddressParams!;
          _addressProofType = DropDownConstants.addressProofList.firstWhere(
              (element) => element.value == addressDetails.proofTypeId);
          _addressProofController.text = addressDetails.proofNumber;
          _frontImage = addressDetails.proofFrontImage;
          _backImage = addressDetails.proofBackImage;
        }
        if (state is UploadProofOfAddressFailure && !state.isFetch) {
          setState(() {
            _errorMsg = Utils.getErrorMessage(
              errorType: state.errorType,
              msg: state.errorMessage,
            );
          });
        }
      },
      builder: (ctx, state) {
        if (state is UploadProofOfAddressLoading && state.isFetch) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state is UploadProofOfAddressFailure && state.isFetch) {
          return Center(
            child: Text(
              Utils.getErrorMessage(
                errorType: state.errorType,
                msg: state.errorMessage,
              ),
            ),
          );
        }
        return Scaffold(
          bottomNavigationBar: Visibility(
            visible: _addressProofType != null,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ErrorInfoWidget(
                      otpErrorMsg: _errorMsg,
                    ),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: _frontImage != null &&
                              _backImage != null &&
                              _isAddressProofNumberValid
                          ? () => _handleUploadPOA(state: state)
                          : null,
                      child:
                          state is UploadProofOfAddressLoading && !state.isFetch
                              ? Assets.animations.loading.lottie()
                              : const Text(
                                  'Upload Proof of Address',
                                ),
                    ),
                    const Gap(10),
                    if (_addressProofType != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _addressProofType = null;
                            _addressProofController.clear();
                            _frontImage = null;
                            _backImage = null;
                            _isAddressProofNumberValid = true;
                            _errorMsg = null;
                            _isFrontImageValid = true;
                            _isBackImageValid = true;
                            _isEditImageMode = false;
                          });
                        },
                        child: const Text(
                          'Change Proof of Address',
                          style: TextStyle(
                            color: AppColors.secondaryViolet,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              // controller: _scrollController,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _addressProofType == null
                                ? 'Proof of Address'
                                : 'Upload ${_addressProofType!.name}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        if (_frontImage != null || _backImage != null)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isEditImageMode = !_isEditImageMode;
                              });
                            },
                            child: _isEditImageMode
                                ? const Text(
                                    'Done',
                                    style: TextStyle(
                                      color: AppColors.secondaryViolet,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Assets.icons.editSvg.svg(),
                          ),
                      ],
                    ),
                    const Gap(24),
                    if (_addressProofType == null) ...[
                      const Text(
                        'Select one of your preferred method',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(20),
                      ProofOfAddressTile(
                        leading: Assets.icons.passport.image(),
                        title: 'Passport',
                        trailing: Assets.icons.arrowForwardFilled.svg(),
                        onTap: () {
                          setState(() {
                            _addressProofController.clear();
                            _addressProofType =
                                DropDownConstants.addressProofList[0];
                          });
                        },
                      ),
                      const Gap(20),
                      ProofOfAddressTile(
                        leading: Assets.icons.voterId.image(),
                        title: 'Voter ID',
                        trailing: Assets.icons.arrowForwardFilled.svg(),
                        onTap: () {
                          setState(() {
                            _addressProofType =
                                DropDownConstants.addressProofList[1];
                          });
                        },
                      ),
                      const Gap(20),
                      ProofOfAddressTile(
                        leading: Assets.icons.drivingLicence.image(),
                        title: 'Driving License',
                        trailing: Assets.icons.arrowForwardFilled.svg(),
                        onTap: () {
                          setState(() {
                            _addressProofType =
                                DropDownConstants.addressProofList[2];
                          });
                        },
                      ),
                    ] else ...[
                      ProofOfAddressTile(
                        hasError: !_isFrontImageValid,
                        leading: _addressProofType!.value == 1
                            ? Assets.icons.passport.image()
                            : _addressProofType!.value == 2
                                ? Assets.icons.voterId.image()
                                : Assets.icons.drivingLicence.image(),
                        title:
                            'Upload Front Side of ${_addressProofType!.name}',
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: _isFrontImageValid &&
                                _frontImage != null &&
                                _isEditImageMode
                            ? TextButton(
                                onPressed: () {
                                  if (Platform.isIOS) {
                                    _openCupertinoActionSheet(
                                      isFront: true,
                                    );
                                  } else if (Platform.isAndroid) {
                                    _openBottomSheet(
                                      isFront: true,
                                    );
                                  }
                                },
                                child: Assets.icons.editSvg.svg(),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_isFrontImageValid &&
                                      _frontImage == null) {
                                    if (Platform.isIOS) {
                                      _openCupertinoActionSheet(
                                        isFront: true,
                                      );
                                    } else if (Platform.isAndroid) {
                                      _openBottomSheet(
                                        isFront: true,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: _isFrontImageValid == true
                                        ? _frontImage == null
                                            ? Colors.white
                                            : AppColors.secondaryViolet
                                        : AppColors.errorRed,
                                    border: _isFrontImageValid == true
                                        ? Border.all(
                                            color: AppColors.secondaryViolet,
                                            width: 1,
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _isFrontImageValid
                                          ? _frontImage == null
                                              ? 'Upload'
                                              : 'Uploaded'
                                          : 'Error',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: _isFrontImageValid
                                            ? _frontImage == null
                                                ? AppColors.secondaryViolet
                                                : Colors.white
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const Gap(20),
                      ProofOfAddressTile(
                        hasError: !_isBackImageValid,
                        leading: _addressProofType!.value == 1
                            ? Assets.icons.passport.image()
                            : _addressProofType!.value == 2
                                ? Assets.icons.voterId.image()
                                : Assets.icons.drivingLicence.image(),
                        title: 'Upload Back Side of ${_addressProofType!.name}',
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: _isBackImageValid &&
                                _backImage != null &&
                                _isEditImageMode
                            ? TextButton(
                                onPressed: () {
                                  if (Platform.isIOS) {
                                    _openCupertinoActionSheet(
                                      isFront: false,
                                    );
                                  } else if (Platform.isAndroid) {
                                    _openBottomSheet(
                                      isFront: false,
                                    );
                                  }
                                },
                                child: Assets.icons.editSvg.svg(),
                              )
                            : InkWell(
                                radius: 12,
                                onTap: () {
                                  if (_isBackImageValid && _backImage == null) {
                                    if (Platform.isIOS) {
                                      _openCupertinoActionSheet(
                                        isFront: false,
                                      );
                                    } else if (Platform.isAndroid) {
                                      _openBottomSheet(
                                        isFront: false,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: _isBackImageValid
                                        ? _backImage == null
                                            ? Colors.white
                                            : AppColors.secondaryViolet
                                        : AppColors.errorRed,
                                    border: _isBackImageValid
                                        ? Border.all(
                                            color: AppColors.secondaryViolet,
                                            width: 1,
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _isBackImageValid
                                          ? _backImage == null
                                              ? 'Upload'
                                              : 'Uploaded'
                                          : 'Error',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: _backImage == null
                                            ? AppColors.secondaryViolet
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                    const Gap(30),
                    if (_addressProofType != null &&
                        _frontImage != null &&
                        _backImage != null) ...[
                      LabelText(
                        label: '${_addressProofType!.name} Number',
                      ),
                      Text(
                        'Please verify if your ${_addressProofType!.name} Number is correct',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _addressProofController,
                        decoration: InputDecoration(
                          fillColor: _isAddressProofNumberValid
                              ? AppColors.lightGrey
                              : AppColors.errorRed.withOpacity(0.08),
                          errorStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          //removing this as its resetting the keyboard to default when switched to numbers
                          UpperCaseTextFormatter(),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\d\s\-_.]{1,100}'),
                          )
                        ],
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        validator: (value) {
                          String? error;
                          if (_addressProofType == null) {
                            error = Validators.validateEmptyField(
                              ValidatorStrings.emptyAddressProofNumber,
                              value,
                            );
                          }
                          //Passport
                          if (_addressProofType ==
                              DropDownConstants.addressProofList[0]) {
                            error = Validators.validatePassportNumber(value);
                          }
                          //Voter ID
                          if (_addressProofType ==
                              DropDownConstants.addressProofList[1]) {
                            error = Validators.validateVoterIDNumber(value);
                          }
                          //Driving License
                          if (_addressProofType ==
                              DropDownConstants.addressProofList[2]) {
                            error =
                                Validators.validateDrivingLicenseNumber(value);
                          }

                          if (error == null) {
                            _isAddressProofNumberValid = true;
                          } else {
                            _isAddressProofNumberValid = false;
                          }

                          setState(() {
                            _errorMsg = error;
                          });

                          return error;
                        },
                      ),
                      const Gap(10),
                      Text(
                        'Format should be like ${_getAddressproofNumberFormat()}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getAddressproofNumberFormat() {
    if (_addressProofType == null) {
      return '';
    }

    switch (_addressProofType!.value) {
      case 1:
        // Passport
        return 'A1234567';
      case 2:
        // Voter ID
        return 'ABC1234567';
      case 3:
        // Driving License
        return 'GJ01 1000000000';
      default:
        return '';
    }
  }

  Future<void> _pickImage(
    ImageSource imageSource, {
    required bool isFront,
  }) async {
    //to reduce the adhaar card size by croping image

    final XFile? image = await _imagePicker.pickImage(
      source: imageSource,
      imageQuality: 50,
      maxHeight: null,
      maxWidth: null,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (image == null || !mounted) return;

    /// for aadhaar maximum image size allowed is 2 mb
    // int maxFileSizedAllowed = _addressProofType == DropDownConstants.addressProofList[3] ? 2 : 5;
    int maxFileSizedAllowed = 5;

    if (!(await Utils.isValidFileSize(File(image.path), maxFileSizedAllowed))) {
      _errorMsg = 'File size should be less than $maxFileSizedAllowed MB';

      if (isFront) {
        _isFrontImageValid = false;
        _frontImage = null;
      } else {
        _isBackImageValid = false;
        _backImage = null;
      }

      setState(() {});
      return;
    }

    if (mounted) {
      var comfirmPOAResult = await Navigator.pushNamed(
        context,
        Routes.comfirmPOAUpload,
        arguments: ConfirmPoaUploadArgs(
          imagePath: image.path,
          documentType: _addressProofType!.name,
        ),
      ) as ConfirmPOAResult?;

      if (comfirmPOAResult == null || comfirmPOAResult.imagePath == null) {
        if (isFront) {
          _frontImage = null;
        } else {
          _backImage = null;
        }

        setState(() {});

        return;
      }

      if (isFront) {
        if (_isFrontImageValid == false) {
          _isFrontImageValid = true;
          _errorMsg = null;
        }

        _frontImage = File(comfirmPOAResult.imagePath!);
      } else {
        if (_isBackImageValid == false) {
          _isBackImageValid = true;
          _errorMsg = null;
        }

        _backImage = File(comfirmPOAResult.imagePath!);
      }

      setState(() {});

      if (_backImage != null && _frontImage != null) {
        /// Extract document number from front/back side of address proof.
        _extractDocumentNumber(
          _addressProofType!.value,
          _frontImage!,
          _backImage!,
        );
      }
    }
  }

  void _extractDocumentNumber(
    int proofTypeId,
    File frontImage,
    File backImage,
  ) async {
    final InputImage inputImage;
    if (proofTypeId == 3) {
      inputImage = InputImage.fromFile(backImage);
    } else {
      inputImage = InputImage.fromFile(frontImage);
    }

    log('Proof Type: $proofTypeId');

    final textRecognizer = TextRecognizer();
    final recognisedText = await textRecognizer.processImage(inputImage);

    var poaDocumentData = recognisedText.text.replaceAll(
      '\n',
      ' ',
    );

    String extrectedDocumentNumber = '';

    log('POA Document Data: $poaDocumentData');

    switch (proofTypeId) {
      /// Passport Number
      case 1:
        extrectedDocumentNumber = RegExp(
              r"[A-PR-WYa-pr-wy][1-9]\d\s?\d{4}[1-9]",
            ).stringMatch(
              poaDocumentData,
            ) ??
            '';
        break;

      /// Voter ID Number
      case 2:
        extrectedDocumentNumber = RegExp(
              r"[A-Z]{3}[0-9]{7}",
            ).stringMatch(
              poaDocumentData,
            ) ??
            '';
        break;

      /// Driving License Number
      case 3:
        extrectedDocumentNumber = RegExp(
              r"(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}",
            ).stringMatch(
              poaDocumentData,
            ) ??
            '';
        log('Driving License Number: $extrectedDocumentNumber');
        break;
    }

    log('Extracted Document Number: $extrectedDocumentNumber');

    _addressProofController.text = extrectedDocumentNumber;
  }

  void _handleUploadPOA({required UploadProofOfAddressState state}) async {
    if (state is UploadProofOfAddressLoading) {
      return;
    }

    if (_frontImage == null) {
      _errorMsg = 'Please upload front side of address proof';
      setState(() {});
      return;
    }

    if (_backImage == null) {
      _errorMsg = 'Please upload back side of address proof';
      setState(() {});
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // If proof type is Aadhaar or Voter ID then we upload proof issue date and proof expiry date as null.
    ///Refer [DropdownConstants.addressProofList] for values.
    context.read<UploadProofOfAddressCubit>().uploadProofOfAddress(
          frontImage: _frontImage!,
          backImage: _backImage!,
          proofTypeId: _addressProofType!.value,
          proofNumber: _addressProofController.text.trim(),
          proofIssueDate: null,
          proofExpiryDate: null,
        );
  }

  void _openCupertinoActionSheet({
    required bool isFront,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Upload Proof of Address'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                _pickImage(
                  ImageSource.camera,
                  isFront: isFront,
                );
              },
              child: const Text('Open Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(
                  ImageSource.gallery,
                  isFront: isFront,
                );
              },
              child: const Text('Upload from Gallery'),
            ),
          ],
        );
      },
    );
  }

  void _openBottomSheet({
    required bool isFront,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    ImageSource.camera,
                    isFront: isFront,
                  );
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(20),
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.textLightGrey,
                      size: 50,
                    ),
                    Gap(10),
                    Text(
                      'Camera',
                      style: TextStyle(
                        color: AppColors.textLightGrey,
                        fontSize: 16,
                      ),
                    ),
                    Gap(20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    ImageSource.gallery,
                    isFront: isFront,
                  );
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(20),
                    Icon(
                      Icons.photo,
                      color: AppColors.textLightGrey,
                      size: 50,
                    ),
                    Gap(10),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: AppColors.textLightGrey,
                        fontSize: 16,
                      ),
                    ),
                    Gap(20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProofOfAddressTile extends StatelessWidget {
  const ProofOfAddressTile({
    Key? key,
    required this.leading,
    required this.title,
    required this.trailing,
    this.onTap,
    this.titleStyle,
    this.hasError = false,
  }) : super(key: key);

  final Widget leading;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasError ? AppColors.errorRed : Colors.transparent,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 28,
              child: leading,
            ),
            const Gap(20),
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
