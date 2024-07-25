import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../data/models/user/user.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import 'assisted_service/analyse_assisted_service_screen.dart';
import 'assisted_service/start_assisted_service_screen.dart';
import 'assisted_service/unlock_assisted_service_widget.dart';

class AssistedServiceTabView extends HookWidget {
  const AssistedServiceTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    useAutomaticKeepAlive();

    if (user.assistedServiceUserDetails == null) {
      return const UnlockAssistedServiceWidget();
    }
    if (user.assistedServiceUserDetails!.isExpired) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Gap(20),
            Assets.svgs.kycRejectAndExpiry.svg(height: 200),
            const Gap(30),
            Text(
              'Your assisted service subscription has expired',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
            const Gap(20),
            Text(
              'Please renew your subscription to avail benefits of Assisted Services',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
            // const Expanded(child: AssistedServiceFeaturesPageView()),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.unlockAssistedServiceInfo),
              child: const Text('Renew Now'),
            ),
          ],
        ),
      );
    }
    if (!user.isRiskProfileTaken) {
      return const StartAssistedServiceScreen();
    }
    return const AnalyseAssistedServiceScreen();
  }
}
