import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../core/local_auth_api.dart';
import '../../../data/models/user/user.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Security'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () => Navigator.pushNamed(context, Routes.forgotMPinOtp),
                title: Text(
                  'Change MPIN',
                  style: baseTextStyle14400.copyWith(
                      color: AppColors.primaryColor),
                ),
              ),
              SwitchListTile.adaptive(
                value: user.isBiometricEnabled,
                activeColor: AppColors.primaryColor,
                enableFeedback: true,
                title: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Enable Biometric/Face ID',
                      style: baseTextStyle14400.copyWith(
                          color: AppColors.neutral[300]),
                    )),
                  ],
                ),
                onChanged: (value) {
                  if (!value) {
                    context
                        .read<AuthCubit>()
                        .updateUser(user.copyWith(isBiometricEnabled: value));
                  } else {
                    _authenticateViaBiometric(user);
                  }
                },
              ),
            ],
          ),
        ));
  }

  void _authenticateViaBiometric(User user) async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (!mounted) return;
    if (isAuthenticated) {
      context
          .read<AuthCubit>()
          .updateUser(user.copyWith(isBiometricEnabled: true));
    } else {
      Utils.showErrorAlert(context, 'Failed to authenticate');
    }
  }
}
