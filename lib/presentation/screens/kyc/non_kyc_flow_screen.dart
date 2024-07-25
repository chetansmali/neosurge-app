import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../di/get_it.dart';

import '../../../data/models/user/kyc_last_route.dart';
import '../../cubits/onboarding/cheque_ocr_read/cheque_ocr_read_cubit.dart';
import '../../cubits/onboarding/confirm_pan/confirm_pan_cubit.dart';
import '../../cubits/onboarding/e_sign_cubit/e_sign_cubit.dart';
import '../../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../../cubits/onboarding/get_data_from_pincode/get_pincode_data_cubit.dart';
import '../../cubits/onboarding/get_decentro_address/get_decentro_address_cubit.dart';
import '../../cubits/onboarding/get_kyc_video_otp/get_kyc_video_otp_cubit.dart';
import '../../cubits/onboarding/non_kyc_create_account/non_kyc_create_account_cubit.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_address_details/upload_address_details_cubit.dart';
import '../../cubits/onboarding/upload_adhaar_number/upload_adhaar_number_cubit.dart';
import '../../cubits/onboarding/upload_bank_details/upload_bank_details_cubit.dart';
import '../../cubits/onboarding/upload_digital_signature/upload_digital_signature_cubit.dart';
import '../../cubits/onboarding/upload_fatca_details/upload_fatca_details_cubit.dart';
import '../../cubits/onboarding/upload_kyc_video/upload_kyc_video_cubit.dart';
import '../../cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart';
import '../../cubits/onboarding/upload_personal_details/upload_personal_details_cubit.dart';
import '../../cubits/onboarding/upload_proof_of_address/upload_proof_of_address_cubit.dart';
import '../../cubits/onboarding/upload_proof_of_identity/upload_proof_of_identity_cubit.dart';
import '../../cubits/util_cubits/loading_cubit.dart';
import '../../cubits/util_cubits/ocr_read_cubit.dart';
import '../onboarding/confirm_pan_details_screen.dart';
import '../onboarding/digital_signature/digital_signature_screen.dart';
import '../onboarding/fatca_details_screen.dart';
import '../onboarding/kyc_verification/aadhaar_verify_screen.dart';
import '../onboarding/kyc_verification/esign_screen.dart';
import '../onboarding/kyc_verification/upload_kyc_video_screen.dart';
import '../onboarding/kyc_verification/upload_proof_of_address_screen.dart';
import '../onboarding/kyc_verification/upload_proof_of_identity_screen.dart';
import '../onboarding/upload_address/upload_address_details_screen.dart';
import '../onboarding/upload_bank_details_screen.dart';
import '../onboarding/upload_nominee_screen.dart';
import '../onboarding/upload_personal_details_screen.dart';

typedef Screens = List<Widget>;

class NonKycFlowScreen extends StatefulWidget {
  const NonKycFlowScreen({
    Key? key,
    required this.panNumber,
    required this.fullName,
    required this.kycData,
  }) : super(key: key);

  final String panNumber;
  final String fullName;
  final KycLastRouteModel kycData;

  @override
  State<NonKycFlowScreen> createState() => _NonKycFlowScreenState();
}

class _NonKycFlowScreenState extends State<NonKycFlowScreen> {
  late final Screens _screens;
  late final PageController _pageController;
  final _screenLength = 14;

  // var isDirectionForward = true;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: context.read<OnboardingPageCubit>().state.pageIndex,
    );

    _screens = [
      BlocProvider(
        create: (_) => getIt<UploadProofOfIdentityCubit>(),
        child: const UploadProofOfIdentityScreen(),
      ),
      BlocProvider(
        create: (context) => getIt<ConfirmPanCubit>(),
        child: ConfirmPanDetailsScreen(
          isCompliant: false,
          fullName: widget.fullName,
          panNumber: widget.panNumber,
        ),
      ),
      BlocProvider(
        create: (context) => getIt<UploadPersonalDetailsCubit>(),
        child: const UploadPersonalDetailsScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<UploadProofOfAddressCubit>(),
        child: const UploadProofOfAddressScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadAddressDetailsCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<GetDecentroAddressCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<GetPinCodeDataCubit>(),
          ),
        ],
        child: UploadAddressDetailsScreen(
          fullName: widget.fullName,
          panNumber: widget.panNumber,
        ),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadBankDetailsCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<ChequeOcrReadCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<GetBankByIfscCubit>(),
          ),
        ],
        child: UploadBankDetailsScreen(
          fullName: widget.fullName,
        ),
      ),
      BlocProvider(
        create: (_) => getIt<UploadFatcaDetailsCubit>(),
        child: const FatcaDetailsScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<UploadNomineeDetailsCubit>(),
        child: const UploadNomineeScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadKycVideoCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<GetKycVideoOtpCubit>(),
          ),
        ],
        child: const UploadKycVideoScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadAadhaarNumberCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<OcrReadCubit>(),
          ),
        ],
        child: const AadhaarVerifyScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<ESignCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<NonKycCreateAccountCubit>(),
          ),
        ],
        child: const ESignScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadDigitalSignatureCubit>(),
          ),
        ],
        child: const DigitalSignatureScreen(isKycCompliant: false),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<LoadingCubit>().state) return false;
        final currentIndex =
            context.read<OnboardingPageCubit>().state.pageIndex;
        if (currentIndex == 0) {
          return true;
        } else {
          context.read<OnboardingPageCubit>().goToPreviousPage();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
            builder: (context, state) => Visibility(
              visible: context.read<OnboardingPageCubit>().state.pageIndex > 0,
              child: IconButton(
                onPressed: () {
                  if (context.read<LoadingCubit>().state) return;
                  context.read<OnboardingPageCubit>().goToPreviousPage();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
                builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _pageController.hasClients
                            ? '${(((_pageController.page! + 1) / (_screenLength - 1)) * 100).toInt()}%'
                            : '${(((state.pageIndex + 1) / (_screenLength - 1)) * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: LinearProgressIndicator(
                      color: const Color(0xFF1D242D), // active color
                      backgroundColor:
                          const Color(0xFFEBEBEB), // inactive color
                      minHeight: 6, // thickness of the bar
                      value: _pageController.hasClients
                          ? (_pageController.page! + 1) / (_screenLength - 1)
                          : (state.pageIndex + 1) / (_screenLength - 1),

                      // Progression value between 0 and 1
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const Gap(20),
                ],
              );
            }),
            BlocListener<OnboardingPageCubit, OnboardingPageState>(
              listener: (context, state) {
                if (state is OnboardingPageChanged) {
                  _pageController.animateToPage(
                    state.page,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) => _screens[index],
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _screens.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
