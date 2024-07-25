import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mpin/set_mpin/set_mpin_cubit.dart';
import '../../../widgets/error_info_widget.dart';

class CreateMPinScreen extends StatefulWidget {
  const CreateMPinScreen({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  final VoidCallback onSuccess;

  @override
  State<CreateMPinScreen> createState() => _CreateMPinScreenState();
}

class _CreateMPinScreenState extends State<CreateMPinScreen> {
  late final TextEditingController _pinController;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasError = false;
  String? _mPinErrorMsg = '';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 20.0),
          child: BlocConsumer<SetMPinCubit, SetMPinState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state is SetMPinLoading) {
                    return;
                  }

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
                    ? Assets.animations.loading.lottie()
                    : const Text('Continue'),
              );
            },
            listener: (context, state) {
              if (state is SetMPinSuccess) {
                context.read<AuthCubit>().updateUser(
                      context
                          .read<AuthCubit>()
                          .state
                          .user!
                          .copyWith(mPin: _pinController.text),
                    );

                widget.onSuccess.call();
              }
              if (state is SetMPinFailure) {
                setState(() {
                  _hasError = true;
                  _mPinErrorMsg = state.errorMessage;
                });
              }
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Create MPin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(4),
              const Text(
                'This pin will be used for quicker login next time you\nuse the app.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Gap(20),
              Pinput(
                obscureText: true,
                controller: _pinController,
                length: 4,
                validator: (String? value) {
                  String? error;
                  if (value!.isEmpty) {
                    error = 'Please enter a pin';
                  }
                  if (value.length != 4) {
                    error = 'Please enter a valid pin';
                  }

                  _mPinErrorMsg = error;
                  return error;
                },
                errorText: '',
                errorTextStyle: const TextStyle(
                  fontSize: 0,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                defaultPinTheme: CustomStyles.defaultPinTheme.copyWith(
                  width: 60,
                  height: 60,
                ),
                onChanged: (value) {
                  setState(() {
                    _hasError = false;
                  });
                },
                forceErrorState: _hasError,
                errorPinTheme: CustomStyles.errorPinTheme.copyWith(
                  width: 60,
                  height: 60,
                ),
                focusedPinTheme: CustomStyles.focusedPinTheme.copyWith(
                  width: 60,
                  height: 60,
                ),
                showCursor: false,
                autofocus: true,
                cursor: CustomStyles.pinPutCursor,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              const Spacer(),
              if (_mPinErrorMsg != null && _mPinErrorMsg!.isNotEmpty) ...[
                ErrorInfoWidget(otpErrorMsg: _mPinErrorMsg),
                const Gap(20),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
