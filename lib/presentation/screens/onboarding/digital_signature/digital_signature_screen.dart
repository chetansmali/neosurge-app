import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/kyc_create_account/kyc_create_account_cubit.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_digital_signature/upload_digital_signature_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import 'widgets/create_kyc_account_dialog.dart';

class DigitalSignatureScreen extends StatelessWidget {
  final bool isKycCompliant;

  const DigitalSignatureScreen({Key? key, required this.isKycCompliant})
      : super(key: key);

  @override
  Widget build(BuildContext context) => isKycCompliant
      ? const _KycDigitalSignature()
      : const _NonKycDigitalSignature();
}

class _KycDigitalSignature extends StatefulWidget {
  const _KycDigitalSignature({Key? key}) : super(key: key);

  @override
  State<_KycDigitalSignature> createState() => _KycDigitalSignatureState();
}

class _KycDigitalSignatureState extends State<_KycDigitalSignature> {
  final ImagePicker _imagePicker = ImagePicker();
  late final SignatureController _signatureController;
  Image? _image;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 2.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void didChangeDependencies() {
    _fetchExistingData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if ((maxCompletedStep >= KycCompliantStepsRoutes.signatureUpload.value &&
            isKycCompliant) ||
        (maxCompletedStep >= NonKycFlowRoutes.signatureUpload.value &&
            !isKycCompliant)) {
      context.read<UploadDigitalSignatureCubit>().fetchSignature();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<UploadDigitalSignatureCubit,
                UploadDigitalSignatureState>(
              listener: (context, state) {
                if (state is UploadDigitalSignatureSuccess && !state.isFetch) {
                  // Navigator.pushNamed(context, Routes.kycCreateAccountScreen);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return BlocProvider<KycCreateAccountCubit>(
                        create: (_) => getIt<KycCreateAccountCubit>(),
                        child: const KycAccountCreationDialog(),
                      );
                    },
                  );
                }
                if (state is UploadDigitalSignatureSuccess && state.isFetch) {
                  _image = Image.file(state.signature!);
                  _imageBytes = state.signatureBytes!;
                }
                if (state is UploadDigitalSignatureFailure && !state.isFetch) {
                  // Utils.showErrorAlert(
                  //   context,
                  //   Utils.getErrorMessage(
                  //       errorType: state.errorType, msg: state.errorMessage),
                  // );
                  // return;
                }
              },
              builder: (context, state) {
                if (state is UploadDigitalSignatureLoading && state.isFetch) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (state is UploadDigitalSignatureFailure && state.isFetch) {
                  return const Center(
                      child: Text('Failed to fetch digital signature details'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "eSIGN",
                      style: baseTextStyle.copyWith(fontSize: 18),
                    ),
                    const Gap(5),
                    Text(
                      'Please make sure that your signature should be same as on your PAN card.',
                      style:
                          baseTextStyle.copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                    const Gap(30),
                    _image != null
                        ? Stack(
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight / 2.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: _image!,
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.digitalSignatureCapture,
                                arguments: DigitalSignatureArgs(
                                    signatureController: _signatureController),
                              ).then((value) async {
                                if (value == true) {
                                  final fileBytes =
                                      await _signatureController.toPngBytes();
                                  _imageBytes = fileBytes;
                                  if (fileBytes != null) {
                                    _image = Image.memory(fileBytes);
                                  }
                                  setState(() {});
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: screenHeight / 2.6,
                              decoration: CustomStyles.kycUploadDecoration,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Click here to draw your signature',
                                    style: baseTextStyle.copyWith(
                                        color: const Color(0xFF326CF9),
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const Gap(20),
                    if (_image == null) ...[
                      const ORDivider(),
                    ],
                    const Gap(20),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _image != null
                                ? context
                                    .read<UploadDigitalSignatureCubit>()
                                    .uploadSignature(_imageBytes!)
                                : _pickImage();
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _image != null
                                    ? const Color(0xFF326CF9)
                                    : Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    200.0), // or any other value you want for border radius
                                side: const BorderSide(
                                    color: Color(0xFF326CF9), width: 2),
                              ),
                            ),
                          ),
                          child: _image == null
                              ? Text(
                                  'Upload',
                                  style: baseTextStyle.copyWith(
                                    color: const Color(0xFF326CF9),
                                    fontSize: 16,
                                  ),
                                )
                              : Text(
                                  'Continue',
                                  style: baseTextStyle.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                    _image == null
                        ? const SizedBox.shrink()
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                _signatureController.clear();
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    'Try again',
                                    style: baseTextStyle.copyWith(
                                        fontSize: 14,
                                        color: const Color(0xFF326CF9)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const Gap(20),
                  ],
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  void _pickImage() async {
    final image = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      if (await Utils.isValidFileSize(File(image.path), 5)) {
        _image = Image.file(File(image.path));
        _imageBytes = await image.readAsBytes();
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: 'File size should be less than 5MB');
      }
    }
  }
}

class _NonKycDigitalSignature extends StatefulWidget {
  const _NonKycDigitalSignature({Key? key}) : super(key: key);

  @override
  State<_NonKycDigitalSignature> createState() =>
      _NonKycDigitalSignatureState();
}

class _NonKycDigitalSignatureState extends State<_NonKycDigitalSignature> {
  final ImagePicker _imagePicker = ImagePicker();
  late final SignatureController _signatureController;
  Image? _image;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 2.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              _image != null
                  ? context
                      .read<UploadDigitalSignatureCubit>()
                      .uploadSignature(_imageBytes!)
                  : (Platform.isIOS)
                      ? {
                          _openCupertinoActionSheet(
                            isFront: true,
                          )
                        }
                      : {
                          _openBottomSheet(
                            isFront: true,
                          )
                        };
            },
            child: _image == null ? const Text('Upload') : const Text('Next'),
          ),
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<UploadDigitalSignatureCubit,
                UploadDigitalSignatureState>(
              listener: (context, state) {
                if (state is UploadDigitalSignatureSuccess && !state.isFetch) {
                  context.read<OnboardingPageCubit>().goToNextPage();
                  return;
                }
                if (state is UploadDigitalSignatureSuccess && state.isFetch) {
                  _image = Image.file(state.signature!);
                  _imageBytes = state.signatureBytes!;
                }
              },
              builder: (context, state) {
                if (state is UploadDigitalSignatureLoading && state.isFetch) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (state is UploadDigitalSignatureFailure && state.isFetch) {
                  return const Center(
                      child: Text('Failed to fetch digital signature details'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "eSIGN",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(5),
                    const Text(
                      'Use your finger or digital pen to sign the account opening form',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(20),
                    // const FileSizeDisclaimer(),
                    _image != null
                        ? Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: _image!,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.5)),
                                  child: IconButton(
                                    icon: const Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      _signatureController.clear();
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.digitalSignatureCapture,
                                arguments: DigitalSignatureArgs(
                                    signatureController: _signatureController),
                              ).then((value) async {
                                if (value == true) {
                                  final fileBytes =
                                      await _signatureController.toPngBytes();
                                  _imageBytes = fileBytes;
                                  if (fileBytes != null) {
                                    _image = Image.memory(fileBytes);
                                  }
                                  setState(() {});
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 60, horizontal: 80),
                              decoration: CustomStyles.kycUploadDecoration,
                              child: Column(
                                children: [
                                  Assets.svgs.digitalSignature.svg(height: 120),
                                  const Gap(20),
                                  const Text(
                                    'Click the screen to add your signature',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const Spacer(),
                    if (_image == null) ...[
                      const ORDivider(),
                      const Spacer(),
                    ],
                    // const Center(child: DataSecure()),
                    const Gap(10),
                  ],
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  void _pickImage(ImageSource source) async {
    final image =
        await _imagePicker.pickImage(source: source, imageQuality: 50);
    if (image != null) {
      if (await Utils.isValidFileSize(File(image.path), 5)) {
        _image = Image.file(File(image.path));
        _imageBytes = await image.readAsBytes();
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: 'File size should be less than 5MB');
      }
    }
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
                );
              },
              child: const Text('Open Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(
                  ImageSource.gallery,
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
