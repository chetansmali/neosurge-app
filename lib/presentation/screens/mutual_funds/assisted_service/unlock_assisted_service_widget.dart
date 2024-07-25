import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/user/user.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import 'assisted_service_features_pageview.dart';

class UnlockAssistedServiceWidget extends StatelessWidget {
  const UnlockAssistedServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
      child: Column(
        children: [
          const Expanded(child: AssistedServiceFeaturesPageView()),
          const Gap(30),
          ElevatedButton(
            onPressed: () {
              if (!user.eSignSubmitDone && !user.isOnBoardingCompleted) {
                Fluttertoast.showToast(msg: 'Please complete your kyc to unlock assisted service');
                return;
              } else if (!user.isOnBoardingCompleted) {
                Fluttertoast.showToast(msg: 'Your kyc is under review. Once approved, you will be able to unlock assisted service');
                return;
              }
              //  Navigator.of(context).pushNamed(Routes.unlockAssistedServiceInfo);
              Navigator.of(context).pushNamed(Routes.assistedServiceOtp);
            },
            child: const Text('Unlock Now'),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
