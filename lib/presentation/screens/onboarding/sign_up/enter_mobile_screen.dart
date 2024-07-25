import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/validators.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/authentication/mobile_otp_cubit/mobile_otp_cubit.dart';

import '../../../routes/route_arguments.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({
    Key? key,
    this.onSuccess,
  }) : super(key: key);

  final ValueChanged<MobileNumberArgs>? onSuccess;

  @override
  State<EnterMobileScreen> createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _mobileFocusNode;

  String? _mobileNumber;
  String? _mobileErrorMsg;

  @override
  void initState() {
    super.initState();
    _mobileFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.only(bottom: 20.0),
          child: BlocConsumer<MobileOtpCubit, MobileOtpState>(
            listener: (context, state) {
              if (state is MobileOtpGenerateSuccess) {
                widget.onSuccess?.call(
                  MobileNumberArgs(mobileNumber: _mobileNumber!),
                );
              } else if (state is MobileOtpGenerateFailure) {
                setState(() {
                  _mobileErrorMsg = state.errorMessage;
                });
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: _mobileErrorMsg == null
                    ? () {
                        if (state is MobileOtpGenerating) {
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context
                              .read<MobileOtpCubit>()
                              .generateMobileOtp(mobileNumber: _mobileNumber!);
                        } else {
                          setState(() {
                            _mobileErrorMsg =
                                Validators.validateMobileNumber(_mobileNumber);
                          });
                        }
                      }
                    : null,
                child: state is MobileOtpGenerating
                    ? Assets.animations.loading.lottie()
                    : const Text('Send OTP'),
              );
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter your mobile number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  const Text(
                    'An OTP will be sent on this mobile number for OTP\nverification.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(20),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: TextFormField(
                      validator: Validators.validateMobileNumber,
                      keyboardType: TextInputType.phone,
                      focusNode: _mobileFocusNode,
                      onChanged: (value) {
                        if (value.length == 10) {
                          _mobileFocusNode.unfocus();
                        }
                        setState(() {
                          _mobileErrorMsg =
                              Validators.validateMobileNumber(value);
                        });
                      },
                      autofocus: true,
                      onSaved: (value) => _mobileNumber = value,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                        fillColor: _mobileErrorMsg == null
                            ? AppColors.lightGrey
                            : AppColors.errorRed.withOpacity(0.08),
                        prefixText: '+91 ',
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (_mobileErrorMsg != null &&
                      _mobileErrorMsg!.isNotEmpty) ...[
                    ErrorInfoWidget(
                      otpErrorMsg: _mobileErrorMsg,
                    ),
                    const Gap(16),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
