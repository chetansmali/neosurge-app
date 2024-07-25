
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../../domain/entities/params/kyc/get_decentro_address_params.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/onboarding/get_decentro_address/get_decentro_address_cubit.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../widgets/custom_loader.dart';
import 'enter_address_screen.dart';
import 'select_existing_address_screen.dart';

class UploadAddressDetailsScreen extends StatefulWidget {
  const UploadAddressDetailsScreen({
    Key? key,
    required this.fullName,
    required this.panNumber,
  }) : super(key: key);

  final String fullName;
  final String panNumber;

  @override
  State<UploadAddressDetailsScreen> createState() =>
      _UploadAddressDetailsScreenState();
}

class _UploadAddressDetailsScreenState
    extends State<UploadAddressDetailsScreen> {
  bool _isAddingNewAddress = false;
  bool _isExistingUser = false;
  @override
  void initState() {
    super.initState();
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;

    _isExistingUser =
        (maxCompletedStep >= KycCompliantStepsRoutes.addressDetails.value &&
                isKycCompliant) ||
            (maxCompletedStep >= NonKycFlowRoutes.addressDetails.value &&
                !isKycCompliant);

    // log(' $maxCompletedStep ${KycCompliantSteps.addressDetailsCompleted} $isKycCompliant');
    if (!_isExistingUser) {
      context.read<GetDecentroAddressCubit>().getDecentroAddress(
            GetDecentroAddressParams(
              name: widget.fullName,
              mobile: context.read<AuthCubit>().state.user!.mobileNumber ?? '',
              documentType: 'PAN',
              idValue: widget.panNumber,
              // name: 'Pon Raj Kumar Rajendran',
              // mobile: '9626337896',
              // documentType: 'PAN',
              // idValue: 'DIMPP9316P',
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isAddingNewAddress || _isExistingUser
        ? EnterAddressScreen(
            fullName: widget.fullName,
            panNumber: widget.panNumber,
          )
        : BlocBuilder<GetDecentroAddressCubit, GetDecentroAddressState>(
            builder: (context, state) {
              if (state is GetDecentroAddressLoading) {
                return const Center(
                  child: CustomLoader(),
                );
              }

              if (state is GetDecentroAddressFailure) {
                return EnterAddressScreen(
                  fullName: widget.fullName,
                  panNumber: widget.panNumber,
                );
              }

              if (state is GetDecentroAddressSuccess) {
                return state.decentroAddressList.isNotEmpty
                    ? SelectExistingAddress(
                        decentroAddressList: state.decentroAddressList,
                        onAddNewAddress: () {
                          setState(() {
                            _isAddingNewAddress = true;
                          });
                        },
                      )
                    : EnterAddressScreen(
                        fullName: widget.fullName,
                        panNumber: widget.panNumber,
                      );
              }

              return const SizedBox.shrink();
            },
          );
  }
}
