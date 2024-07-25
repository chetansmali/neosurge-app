import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/assisted_service/verify_assisted_service_pin/verify_assisted_service_pin_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../loading_screen.dart';

class AssistedServicePinScreen extends StatefulWidget {
  const AssistedServicePinScreen({Key? key}) : super(key: key);

  @override
  State<AssistedServicePinScreen> createState() =>
      _AssistedServicePinScreenState();
}

class _AssistedServicePinScreenState extends State<AssistedServicePinScreen> {
  late final TextEditingController _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Assisted Service'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.svgs.securityCheck.svg(),
                    const Gap(20),
                    Text(
                      'Enter your Assisted Service Pin',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    BlocConsumer<VerifyAssistedServicePinCubit,
                        VerifyAssistedServicePinState>(
                      listener: (context, state) {
                        if (state is VerifyAssistedServicePinSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.startAssistedService,
                              (route) => route.isFirst);

                          // final user = context.read<AuthCubit>().state.user!;
                          // context.read<AuthCubit>().updateUser(user.copyWith(assistedServiceUserDetails: state.response.userDTO.assistedServiceUserDetailsId!));
                          //
                          // user.assistedServiceUserDetails != null
                          //     ? Navigator.popUntil(context, (route) => route.isFirst)
                          //     : Navigator.pushNamedAndRemoveUntil(context, Routes.startAssistedService, (route) => route.isFirst);
                        }
                        if (state is VerifyAssistedServicePinFailure) {
                          Utils.showErrorAlert(
                            context,
                            Utils.getErrorMessage(
                                errorType: state.errorType,
                                msg: state.errorMessage),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Pinput(
                          controller: _pinController,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          autofocus: true,
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          onCompleted: (String pin) {
                            context
                                .read<VerifyAssistedServicePinCubit>()
                                .verifyAssistedServicePin(
                                    userId: context
                                        .read<AuthCubit>()
                                        .state
                                        .user!
                                        .id,
                                    pin: pin);
                          },
                          defaultPinTheme: CustomStyles.defaultPinTheme,
                          errorText: state is VerifyAssistedServicePinFailure
                              ? Utils.getErrorMessage(
                                  errorType: state.errorType,
                                  msg: state.errorMessage)
                              : null,
                          errorBuilder: (context, error) {
                            if (state is! VerifyAssistedServicePinFailure) {
                              return const SizedBox.shrink();
                            }
                            var errorState = state;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Utils.getErrorMessage(
                                  errorType: errorState.errorType,
                                  msg: errorState.errorMessage,
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.errorRed,
                                ),
                              ),
                            );
                          },
                          errorPinTheme: CustomStyles.errorPinTheme,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Pin';
                            }
                            if (value.length != 6) {
                              return 'Please enter a valid Pin';
                            }
                            return null;
                          },
                          focusedPinTheme: CustomStyles.focusedPinTheme,
                          showCursor: true,
                          cursor: CustomStyles.pinPutCursor,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
