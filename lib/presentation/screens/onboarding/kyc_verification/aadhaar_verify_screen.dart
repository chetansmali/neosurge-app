import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_adhaar_number/upload_adhaar_number_cubit.dart';
import '../../../cubits/util_cubits/ocr_read_cubit.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/label_text.dart';
import '../../../widgets/ocr_reading_dialog.dart';

// import '../../../../common/adhaar_validator.dart' as Adharvalidator;
class AadhaarVerifyScreen extends StatefulWidget {
  /// User will be entering is Aadhaar number
  /// and will be used to verify the Aadhaar number for KYC verification.
  const AadhaarVerifyScreen({Key? key}) : super(key: key);

  @override
  State<AadhaarVerifyScreen> createState() => _AadhaarVerifyScreenState();
}

class _AadhaarVerifyScreenState extends State<AadhaarVerifyScreen> {
  late final TextEditingController _aadhaarNumberController;

  @override
  void initState() {
    super.initState();
    _aadhaarNumberController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _fetchExistingData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _aadhaarNumberController.dispose();
    super.dispose();
  }

  void _fetchExistingData() {
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    if (maxCompletedStep >= NonKycFlowRoutes.aadharNumberUploaded.value) {
      context.read<UploadAadhaarNumberCubit>().fetchAadhaarNumber();
    }
  }

  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child:
              BlocBuilder<UploadAadhaarNumberCubit, UploadAadhaarNumberState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: errorMsg != null
                    ? null
                    : () {
                        context
                            .read<UploadAadhaarNumberCubit>()
                            .uploadAadhaarNumber(
                                aadhaarNumber: _aadhaarNumberController.text);
                      },
                child: (state is UploadAadhaarNumberLoading)
                    ? const Center(child: CustomLoader())
                    : const Text('Continue'),
              );
            },
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OcrReadCubit, OcrReadState>(
            listener: (context, ocrState) {
              if (ocrState is OcrReadLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const OcrReadingDialog(),
                );
              }
              if (ocrState is OcrReadLoaded) {
                Navigator.of(context).pop();
                if (ocrState.ocrResponse.docNum.length != 12) {
                  return;
                }
                _aadhaarNumberController.text =
                    ocrState.ocrResponse.docNum.substring(8, 12);
              }
              if (ocrState is OcrReadFailure) {
                Navigator.of(context).pop();
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      errorType: ocrState.appErrorType,
                      msg: ocrState.errorMessage),
                );
              }
            },
          ),
          BlocListener<UploadAadhaarNumberCubit, UploadAadhaarNumberState>(
            listener: (_, state) {
              if (state is UploadAadhaarNumberSuccess) {
                state.isFetch
                    ? _aadhaarNumberController.text = state.adhaarNumber ?? ''
                    : context.read<OnboardingPageCubit>().goToNextPage();
              }
              if (state is UploadAadhaarNumberFailure) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      errorType: state.errorType, msg: state.errorMessage),
                );
                return;
              }
            },
          ),
        ],
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aadhaar Verification',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(5),
                    const Text(
                      'As per SEBI regulations, providing your Aadhar Card is necessary for KYC Verification.',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(20),
                    const LabelText(label: 'Aadhaar Card Number'),
                    TextFormField(
                      controller: _aadhaarNumberController,
                      onChanged: (value) {
                        setState(() {
                          errorMsg = '';
                        });

                        if (value.length == 12) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            errorMsg = null;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        hintText: '',
                        // suffixIcon: InkWell(
                        //   onTap: _ocrRead,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Assets.icons.idScan.svg(),
                        //   ),
                        // ),
                      ),
                    ),
                    const Gap(20),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// void _ocrRead() async {
//   File? imageFile = await Utils.pickImage(ImageSource.camera);
//   if (imageFile != null && await Utils.isValidFileSize(imageFile, 5)) {
//     if (!mounted) return;
//     context.read<OcrReadCubit>().ocrRead(file: imageFile, docType: DocumentType.aadhar);
//   } else {
//     Fluttertoast.showToast(msg: 'File size should be less than 5 MB');
//   }
// }
}
