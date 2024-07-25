import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mpin/set_mpin/set_mpin_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_loader.dart';
import '../loading_screen.dart';

class ResetMPinScreen extends StatefulWidget {
  const ResetMPinScreen({Key? key}) : super(key: key);

  @override
  State<ResetMPinScreen> createState() => _ResetMPinScreenState();
}

class _ResetMPinScreenState extends State<ResetMPinScreen> {
  late final TextEditingController _pinController;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasError = false;

  final cursor = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: 21,
      height: 1,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(137, 146, 160, 1),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

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
        appBar: AppBar(title: const Text('Reset MPIN')),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter new MPIN',
                        style: baseTextStyle18500.copyWith(color: Colors.black),
                      ),
                      const Gap(4.0),
                      Text(
                        'This PIN will be used every time you login to the app',
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.neutral[300]),
                      ),
                      const Gap(20),
                      Align(
                        alignment: Alignment.center,
                        child: Pinput(
                          length: 4,
                          controller: _pinController,
                          obscureText: true,
                          errorBuilder: (errorText, pin) => const SizedBox(),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter a pin';
                            }
                            if (value.length != 4) {
                              return 'Please enter a valid pin';
                            }
                            return null;
                          },
                          defaultPinTheme: CustomStyles.defaultPinTheme,
                          errorPinTheme: CustomStyles.errorPinTheme,
                          focusedPinTheme: CustomStyles.focusedPinTheme,
                          followingPinTheme: CustomStyles.followingPinTheme,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          forceErrorState: _hasError,
                          showCursor: true,
                          cursor: cursor,
                          onChanged: (String value) =>
                              setState(() => _hasError = false),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(24.0),
          child: BlocConsumer<SetMPinCubit, SetMPinState>(
            listener: (context, state) async {
              final navigator = Navigator.of(context);

              if (state is SetMPinSuccess) {
                await context.read<AuthCubit>().updateUser(context
                    .read<AuthCubit>()
                    .state
                    .user!
                    .copyWith(
                        mPin: _pinController.text, isBiometricEnabled: false));

                Fluttertoast.showToast(msg: 'Pin updated successfully');
                navigator.pushNamedAndRemoveUntil(
                    Routes.mPinFpLogin, (route) => false);
              }
              if (state is SetMPinFailure) {
                if (context.mounted) {
                  Utils.showErrorAlert(
                    context,
                    Utils.getErrorMessage(
                        errorType: state.appErrorType, msg: state.errorMessage),
                  );
                }
              }
            },
            builder: (context, state) => ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SetMPinCubit>().setMPin(
                        email: context.read<AuthCubit>().state.user!.emailId,
                        mPin: _pinController.text,
                      );
                } else {
                  setState(() {
                    _hasError = true;
                  });
                }
              },
              child: state is SetMPinLoading
                  ? const CustomLoader(color: Colors.white)
                  : const Text('Continue'),
            ),
          ),
        ),
      ),
    );
  }
}
