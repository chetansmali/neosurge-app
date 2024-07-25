import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/kyc_steps_constants.dart';
import '../../../data/models/kyc/verify_pan_response_model.dart';
import '../../cubits/account/get_kyc_last_route_cubit/get_kyc_last_route_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_loader.dart';

class KycRoutingScreen extends StatelessWidget {
  const KycRoutingScreen({
    Key? key,
    required this.verifyPanResponseModel,
  }) : super(key: key);

  final VerifyPanResponseModel verifyPanResponseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GetKycLastRouteCubit, GetKycLastRouteState>(
        listener: (context, state) {
          if (state is GetKycLastRouteLoaded) {
            var kycData = state.kycLastRouteModel;

            if (kycData.kycCompliant) {
              // kycData = _updateTheMaxStepCount(kycData);
              // log('kycData.maxStepCount ${kycData.maxStepCount} kycData.stepCount ${kycData.stepCount} kycData.lastRoute ${kycData.lastRoute}');
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.kycVerifiedFlowScreen,
                (route) => false,
                arguments: KycFlowArgs(
                  kycData: kycData.copyWith(
                    maxStepCount: KycCompliantStepsRoutes.values
                        .firstWhere((val) => val.name == kycData.lastRoute)
                        .value,

                    stepCount: KycCompliantStepsRoutes.values
                            .firstWhere((val) => val.name == kycData.lastRoute)
                            .value +
                        1,

                    // NOTE: Uncomment these lines to test the kyc flow from the manual state
                    // stepCount: 0,
                    // lastRoute: KycCompliantStepsRoutes.confirmPan.name,
                  ),
                  fullName: verifyPanResponseModel.fullName ?? '',
                  panNumber: verifyPanResponseModel.panNumber,
                ),
              );

              return;
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.nonKycFlowScreen,
                (route) => false,
                arguments: KycFlowArgs(
                  kycData: kycData.copyWith(
                    maxStepCount: NonKycFlowRoutes.values
                        .firstWhere((val) => val.name == kycData.lastRoute)
                        .value,
                    stepCount: NonKycFlowRoutes.values
                            .firstWhere((val) => val.name == kycData.lastRoute)
                            .value +
                        1,
                    // NOTE: Uncomment these lines to test the kyc flow from the manual state
                    // stepCount: 0,
                    // lastRoute: NonKycFlowRoutes.checkPanStatus.name,
                  ),
                  fullName: verifyPanResponseModel.fullName ?? '',
                  panNumber: verifyPanResponseModel.panNumber,
                ),
              );
              return;
            }
          }
        },
        builder: (context, state) {
          return const Center(
            child: CustomLoader(),
          );
        },
      ),
    );
  }
}
