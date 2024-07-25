import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/banner_container.dart';

class AssistedServiceExpiryBanner extends StatelessWidget {
  const AssistedServiceExpiryBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assistedServiceDetails =
        context.watch<AuthCubit>().state.user!.assistedServiceUserDetails;
    if (assistedServiceDetails != null) {
      if (assistedServiceDetails.isExpired) {
        return Container(
          color: Colors.red,
          child: const Center(
            child: Text('Your assisted service has expired'),
          ),
        );
      }
      //Check if the expiry is in the next 15 days: if so show this banner
      final daysLeft =
          assistedServiceDetails.expiresOn.difference(DateTime.now()).inDays;
      if (daysLeft < 15) {
        return BannerContainer(
          image: Assets.svgs.kycRejectAndExpiry.svg(),
          title: 'Your subscription is about to expire',
          subtitle:
              'Hey,Your subscription ${_getExpiryDay(daysLeft)}. Please renew to avail benefits of Assisted Services',
          buttonText: 'Renew Now',
          onTap: () =>
              Navigator.pushNamed(context, Routes.unlockAssistedServiceInfo),
        );
      }
    }
    return const SizedBox.shrink();
  }

  String _getExpiryDay(int daysLeft) {
    if (daysLeft == 0) {
      return 'will expire today';
    }
    if (daysLeft == 1) {
      return 'will expire in 1 more day';
    }
    return 'is about to expire in $daysLeft more days';
  }
}
