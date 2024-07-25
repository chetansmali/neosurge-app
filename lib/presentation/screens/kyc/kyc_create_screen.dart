import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/onboarding/kyc_create_account/kyc_create_account_cubit.dart';
import '../../widgets/app_error_widget.dart';
import 'widgets/account_creation_loading_widget.dart';
import 'widgets/account_creations_success_widget.dart';

class KycCreateScreen extends StatelessWidget {
  const KycCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<KycCreateAccountCubit, KycCreateAccountState>(
        listener: (context, state) {
          if (state is KycCreateAccountSuccess) {
            final user = context.read<AuthCubit>().state.user!;
            context.read<AuthCubit>().updateUser(user.copyWith(isOnBoardingCompleted: true));
          }
        },
        builder: (context, state) {
          if (state is KycCreateAccountLoading) {
            return WillPopScope(
              child: const AccountCreationLoadingWidget(),
              onWillPop: () async => false,
            );
          }
          if (state is KycCreateAccountFailure) {
            return Center(
              child: AppErrorWidget(
                errorType: state.appErrorType,
                error: state.errorMessage,
              ),
            );
          }
          if (state is KycCreateAccountSuccess) {
            return WillPopScope(
              onWillPop: () async => false,
              child: const AccountCreationSuccessWidget(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
