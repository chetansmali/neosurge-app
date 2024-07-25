import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../di/get_it.dart';
import '../../cubits/onboarding/cheque_ocr_read/cheque_ocr_read_cubit.dart';
import '../../cubits/onboarding/confirm_pan/confirm_pan_cubit.dart';
import '../../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../../cubits/onboarding/get_data_from_pincode/get_pincode_data_cubit.dart';
import '../../cubits/onboarding/get_decentro_address/get_decentro_address_cubit.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/upload_address_details/upload_address_details_cubit.dart';
import '../../cubits/onboarding/upload_bank_details/upload_bank_details_cubit.dart';
import '../../cubits/onboarding/upload_digital_signature/upload_digital_signature_cubit.dart';
import '../../cubits/onboarding/upload_fatca_details/upload_fatca_details_cubit.dart';
import '../../cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart';
import '../../cubits/onboarding/upload_personal_details/upload_personal_details_cubit.dart';
import '../../cubits/util_cubits/loading_cubit.dart';
import '../onboarding/confirm_pan_details_screen.dart';
import '../onboarding/digital_signature/digital_signature_screen.dart';
import '../onboarding/fatca_details_screen.dart';
import '../onboarding/upload_address/upload_address_details_screen.dart';
import '../onboarding/upload_bank_details_screen.dart';
import '../onboarding/upload_nominee_screen.dart';
import '../onboarding/upload_personal_details_screen.dart';

typedef Screens = List<Widget>;

class KycVerifiedFlowScreen extends StatefulWidget {
  const KycVerifiedFlowScreen({
    Key? key,
    required this.panNumber,
    required this.fullName,
  }) : super(key: key);

  final String panNumber;
  final String fullName;

  @override
  State<KycVerifiedFlowScreen> createState() => _KycVerifiedFlowScreenState();
}

class _KycVerifiedFlowScreenState extends State<KycVerifiedFlowScreen> {
  late final Screens _screens;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: context.read<OnboardingPageCubit>().state.pageIndex,
    );
    _pageController.addListener(_onPageViewScroll);

    _screens = [
      BlocProvider(
        create: (context) => getIt<ConfirmPanCubit>(),
        child: ConfirmPanDetailsScreen(
          isCompliant: true,
          fullName: widget.fullName,
          panNumber: widget.panNumber,
        ),
      ),
      BlocProvider(
        create: (_) => getIt<UploadPersonalDetailsCubit>(),
        child: const UploadPersonalDetailsScreen(),
      ),
      BlocProvider(
        create: (context) => getIt<UploadFatcaDetailsCubit>(),
        child: const FatcaDetailsScreen(),
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
      BlocProvider(
        create: (_) => getIt<UploadNomineeDetailsCubit>(),
        child: const UploadNomineeScreen(),
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
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<UploadDigitalSignatureCubit>(),
          ),
        ],
        child: const DigitalSignatureScreen(isKycCompliant: true),
      ),
    ];
  }

  _onPageViewScroll() {
    // Whenever the page view scrolls, this method will be called.
    // Triggering a rebuild using setState to reflect the changes.
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageViewScroll);
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
          leading: Visibility(
            visible: context.read<OnboardingPageCubit>().state.pageIndex > 0,
            child: IconButton(
              onPressed: () {
                if (context.read<LoadingCubit>().state) return;
                final currentIndex =
                    context.read<OnboardingPageCubit>().state.pageIndex;
                if (currentIndex == 0) {
                  Navigator.pop(context);
                } else {
                  context.read<OnboardingPageCubit>().goToPreviousPage();
                }
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        body: Column(
          children: [
            // const KycVerifiedFlowStepper(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _pageController.hasClients
                      ? '${(((_pageController.page! + 1) / 7) * 100).toInt()}%'
                      : '${(((context.read<OnboardingPageCubit>().state.pageIndex + 1) / 7) * 100).toInt()}%',
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
                backgroundColor: const Color(0xFFEBEBEB), // inactive color
                minHeight: 6, // thickness of the bar
                value: _pageController.hasClients
                    ? (_pageController.page! + 1) / 7
                    : (context.read<OnboardingPageCubit>().state.pageIndex +
                            1) /
                        7,

                // Progression value between 0 and 1
                // borderRadius: BorderRadius.circular(20),
              ),
            ),
            const Gap(20),
            BlocListener<OnboardingPageCubit, OnboardingPageState>(
              listener: (context, state) {
                if (state is OnboardingPageChanged) {
                  _pageController.animateToPage(
                    state.pageIndex,
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
