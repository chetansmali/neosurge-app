import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../common/validators.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/authentication/login_with_email/login_with_email_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/label_text.dart';
import '../../../widgets/error_info_widget.dart';

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({
    Key? key,
    this.onSuccess,
  }) : super(key: key);

  final ValueChanged<VerifyEmailParams>? onSuccess;

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  String? _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LoginWithEmailCubit _cubit;

  String? _emailErrorMsg;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginWithEmailCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LabelText(label: 'Email'),
                const Gap(8),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: BlocConsumer<LoginWithEmailCubit, LoginWithEmailState>(
                    listener: (context, state) {
                      if (state is LoginWithEmailOtpGenerated &&
                          !state.isResend) {
                        widget.onSuccess?.call(
                          VerifyEmailParams(
                            emailId: _email!,
                            loginWithEmailResponseModel: state.response,
                          ),
                        );
                      }
                      if (state is LoginWithEmailOtpGenerateError) {
                        Utils.showErrorAlert(
                          context,
                          Utils.getErrorMessage(
                            errorType: state.errorType,
                            msg: state.errorMessage,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextFormField(
                        initialValue:
                            context.read<AuthCubit>().state.user?.emailId ?? '',
                        validator: Validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? value) => _email = value,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          fillColor: _emailErrorMsg == null
                              ? AppColors.lightGrey
                              : AppColors.errorRed.withOpacity(0.08),
                          errorStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _emailErrorMsg = Validators.validateEmail(value);
                            _formKey.currentState!.validate();
                          });
                        },
                        onFieldSubmitted: (_) =>
                            _emailErrorMsg == null ? _submit() : null,
                      );
                    },
                  ),
                ),
                const Gap(20),
                const Spacer(),
                if (_emailErrorMsg != null && _emailErrorMsg!.isNotEmpty)
                  ErrorInfoWidget(otpErrorMsg: _emailErrorMsg),
                const Gap(16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    maximumSize: const Size(double.infinity, 56),
                  ),
                  onPressed: _emailErrorMsg == null ? _submit : null,
                  child: BlocBuilder<LoginWithEmailCubit, LoginWithEmailState>(
                    builder: (context, state) {
                      return state is LoginWithEmailLoading
                          ? Assets.animations.loading.lottie()
                          : const Text('Verify');
                    },
                  ),
                ),
                const Gap(20),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _cubit.loginWithEmail(email: _email!);
    } else {
      setState(() {
        _emailErrorMsg = Validators.validateEmail(_email);
      });
    }
  }
}
