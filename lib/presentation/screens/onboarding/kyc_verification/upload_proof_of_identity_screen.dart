import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/utils.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_proof_of_identity/upload_proof_of_identity_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import '../widgets/kyc_item_tile.dart';

class UploadProofOfIdentityScreen extends StatefulWidget {
  /// Creates a screen that allows user to upload proof of identity for KYC Verification.
  const UploadProofOfIdentityScreen({Key? key}) : super(key: key);

  @override
  State<UploadProofOfIdentityScreen> createState() =>
      _UploadProofOfIdentityScreenState();
}

class _UploadProofOfIdentityScreenState
    extends State<UploadProofOfIdentityScreen> {
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchExistingData();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    /* print('maxCompletedStep: $maxCompletedStep'); */
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;

    if ((maxCompletedStep >= NonKycFlowRoutes.panUpload.value &&
        !isKycCompliant)) {
      context.read<UploadProofOfIdentityCubit>().fetchProofOfIdentity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadProofOfIdentityCubit, UploadProofOfIdentityState>(
      listener: (context, state) {
        if (state is UploadProofOfIdentitySuccess && state.isFetch) {
          _imageFile = state.panImage!;
        }
      },
      builder: (ctx, state) {
        if (state is UploadProofOfIdentityLoading && state.isFetch) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state is UploadProofOfIdentityFailure && state.isFetch) {
          return Center(
            child: Text(
              Utils.getErrorMessage(
                errorType: state.errorType,
                msg: state.errorMessage,
              ),
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Upload Proof',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(20),
                      KycItemTile(
                        leading: Assets.pngs.panCard.image(),
                        title: 'Scan/Upload your PAN',
                        trailing: Assets.icons.arrowForwardFilled.svg(),
                        onTap: () {
                          if (Platform.isIOS) {
                            _openCupertinoActionSheet();
                          } else if (Platform.isAndroid) {
                            _openBottomSheet();
                          }
                        },
                      ),
                      if (_imageFile != null &&
                          state is UploadProofOfIdentitySuccess &&
                          state.isFetch) ...[
                        Expanded(
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OnboardingPageCubit>().goToNextPage();
                          },
                          child: const Text('Keep this image'),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource imageSource) async {
    final XFile? image = await _imagePicker.pickImage(
      source: imageSource,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (image == null || !mounted) return;

    if (mounted) {
      Navigator.of(context).pushNamed(
        Routes.comfirmPanUpload,
        arguments: image.path,
      );
    }
  }

  void _openCupertinoActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Upload Proof of Identity'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text('Open Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Upload from Gallery'),
            ),
          ],
        );
      },
    );
  }

  void _openBottomSheet() {
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
                  _pickImage(ImageSource.camera);
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
                  _pickImage(ImageSource.gallery);
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
