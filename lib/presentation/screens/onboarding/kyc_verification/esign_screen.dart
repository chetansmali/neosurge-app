import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/onboarding/e_sign_cubit/e_sign_cubit.dart';
import '../../../cubits/onboarding/non_kyc_create_account/non_kyc_create_account_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../kyc/widgets/account_creation_loading_widget.dart';
import '../../kyc/widgets/account_creations_success_widget.dart';

class ESignScreen extends StatelessWidget {
  const ESignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocListener<NonKycCreateAccountCubit, NonKycCreateAccountState>(
        listener: (_, state) {
          if (state is NonKycCreateAccountPartSuccess) {
            context.read<ESignCubit>().eSignSubmit();
          }
          if (state is NonKycCreateAccountLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: const Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    height: 300,
                    child: AccountCreationLoadingWidget(),
                  ),
                ),
              ),
            );
          }

          if (state is NonKycCreateAccountFailure) {
            Navigator.pop(context);
            Utils.showErrorAlert(
                context,
                Utils.getErrorMessage(
                    msg: state.errorMessage, errorType: state.appErrorType));
          }
          if (state is NonKycCreateAccountSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Center(
                      child: AccountCreationSuccessWidget(),
                    ),
                  ),
                ),
                (route) => false);
          }
        },
        child: BlocConsumer<ESignCubit, ESignState>(
          listener: (context, state) async {
            final eSignCubit = context.read<ESignCubit>();
            final nonKycCreateAccountCubit =
                context.read<NonKycCreateAccountCubit>();
            final authCubit = context.read<AuthCubit>();
            final navigator = Navigator.of(context);
            if (state is ESignLoadSuccess) {
              final res = await Navigator.pushNamed(
                  context, Routes.eSignSubmitWebView,
                  arguments: ESignSubmitWebViewArgs(url: state.eSignUrl));
              if (res == true) {
                eSignCubit.eSignSubmitSuccess();
                authCubit.updateUser(
                    authCubit.state.user!.copyWith(eSignSubmitDone: true));
                nonKycCreateAccountCubit
                    .createAccountSuccessFunc(authCubit.state.user!.retakeKyc);
              } else {
                navigator.pop();
                eSignCubit.eSignSubmitFailure();
              }
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ESign Submission",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(5),
                      const Text(
                        'Please submit your ESign to complete your account creation',
                        textAlign: TextAlign.center,
                      ),
                      Assets.svgs.esign.svg(height: 200),
                      if (state is ESignSubmitSuccess)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.withOpacity(0.8),
                          size: 100,
                        ),
                      if (state is ESignFailure)
                        Icon(
                          Icons.cancel,
                          color: Colors.red.withOpacity(0.8),
                          size: 100,
                        ),
                      const Gap(20),
                      // Text(
                      //     'Aadhaar E-Sign${state is ESignSubmitSuccess ? ' Successful' : state is ESignFailure ? ' Failed' : ''}',
                      //     style: Theme.of(context).textTheme.headline6),
                      const Gap(20),
                      Text(
                        state is ESignSubmitSuccess
                            ? 'Your E-Sign has been completed successfully'
                            : state is ESignFailure
                                ? state.errorMessage ?? ''
                                : 'You will be redirected to the ESign Web view where you need to digitally sign your Aadhaar details using your Aadhaar OTP that will be sent to your registered mobile number.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final user = context.read<AuthCubit>().state.user!;
                            state is! ESignSubmitSuccess
                                //TODO: get latitude and longitude from location servicew
                                ? context
                                    .read<NonKycCreateAccountCubit>()
                                    .createAccount(latitude: 10, longitude: 10)
                                : context
                                    .read<NonKycCreateAccountCubit>()
                                    .createAccountSuccessFunc(user.retakeKyc);
                          },
                          child: Text(state is! ESignSubmitSuccess
                              ? state is ESignFailure
                                  ? 'Retry'
                                  : 'Proceed to ESign'
                              : 'Continue'),
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
