import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../data/models/kyc/verify_pan_response_model.dart';
import '../../routes/routes.dart';
import '../../widgets/error_info_widget.dart';

import '../../../common/validators.dart';
import '../../../data/models/user/user.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/onboarding/verify_pan/verify_pan_cubit.dart';

import '../../theme/app_colors.dart';

class VerifyPanScreen extends StatefulWidget {
  const VerifyPanScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPanScreen> createState() => _VerifyPanScreenState();
}

class _VerifyPanScreenState extends State<VerifyPanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _panController;
  late final FocusNode _panFocusNode;

  String? _panErrorMsg;

  TextInputType _keyboardType = TextInputType.text;

  @override
  void initState() {
    super.initState();
    _panController = TextEditingController();
    _panFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _panFocusNode.dispose();
    _panController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<VerifyPanCubit, VerifyPanState>(
          listener: (context, state) async {
            if (state is VerifyPanSuccess) {
              final User user = context.read<AuthCubit>().state.user!;

              if (user.panVerified == false) {
                context.read<AuthCubit>().updateUser(
                      user.copyWith(
                        maxStepCount: 0,
                        panVerified: true,
                      ),
                    );
              }

              if (state.verifyPanResponseModel.isCompliant) {
                Future.delayed(
                  const Duration(milliseconds: 1000),
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.dashboard,
                      (route) => false,
                    );
                  },
                );
              }
            }

            if (state is VerifyPanFailure) {
              setState(() {
                _panErrorMsg = state.errorMessage;
              });
            }
          },
          builder: (context, state) {
            if (state is VerifyPanSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!state.verifyPanResponseModel.isCompliant) ...[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kycRoutingScreen,
                          (route) => false,
                          arguments: VerifyPanResponseModel(
                            fullName: state.verifyPanResponseModel.fullName,
                            isCompliant:
                                state.verifyPanResponseModel.isCompliant,
                            panNumber: state.verifyPanResponseModel.panNumber,
                          ),
                        );
                      },
                      child: const Text('Complete KYC'),
                    ),
                    const Gap(16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.dashboard,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'I’ll do it later',
                        style: TextStyle(
                          color: AppColors.secondaryViolet,
                        ),
                      ),
                    ),
                  ]
                ],
              );
            }

            return ElevatedButton(
              onPressed: () {
                if (state is VerifyPanLoading) {
                  return;
                }

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<VerifyPanCubit>().verifyPan(
                        panNumber: _panController.text,
                      );
                } else {
                  setState(() {
                    _panErrorMsg = Validators.validatePanNumber(
                      _panController.text,
                    );
                  });
                }
              },
              child: state is VerifyPanLoading
                  ? Assets.animations.loading.lottie()
                  : const Text('Verify'),
            );
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter PAN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  const Text(
                    'As per SEBI regulations, providing your PAN is mandatory for investing in India.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(20),
                  Form(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: BlocBuilder<VerifyPanCubit, VerifyPanState>(
                        builder: (context, state) {
                      return TextFormField(
                        validator: Validators.validatePanNumber,
                        focusNode: _panFocusNode,
                        controller: _panController,
                        enabled: state is! VerifyPanSuccess,
                        keyboardType: _keyboardType,
                        textCapitalization: TextCapitalization.characters,
                        onChanged: (value) {
                          context.read<VerifyPanCubit>().fieldChanged();

                          if (value.length == 10) {
                            _panFocusNode.unfocus();
                          }

                          if ((value.length <= 4 || value.length >= 9)) {
                            if (_keyboardType != TextInputType.text) {
                              _keyboardType = TextInputType.text;
                              _panFocusNode.unfocus();
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () => _panFocusNode.requestFocus(),
                              );
                            }
                          } else {
                            if (_keyboardType != TextInputType.number) {
                              _keyboardType = TextInputType.number;
                              _panFocusNode.unfocus();
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () => _panFocusNode.requestFocus(),
                              );
                            }
                          }

                          setState(() {
                            _panErrorMsg = Validators.validatePanNumber(
                              _panController.text,
                            );
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\d]'),
                          ),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 0,
                          ),
                          fillColor: _panErrorMsg == null
                              ? AppColors.lightGrey
                              : AppColors.errorRed.withOpacity(0.08),
                        ),
                      );
                    }),
                  ),
                  const Gap(12),
                  BlocBuilder<VerifyPanCubit, VerifyPanState>(
                    builder: (context, state) {
                      if (state is VerifyPanSuccess) {
                        return state.verifyPanResponseModel.isCompliant
                            ? Row(
                                children: [
                                  Assets.svgs.verifiedPan.svg(),
                                  const Gap(8),
                                  const Text(
                                    'You are KYC Compliant!',
                                    style: TextStyle(
                                      color: AppColors.green,
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'You are not KYC Compliant!',
                                style: TextStyle(
                                  color: AppColors.textRed,
                                ),
                              );
                      }
                      if (state is VerifyPanLoading) {
                        return const Text(
                          'Please wait we are verifying your PAN',
                          style: TextStyle(
                            color: AppColors.yellowPrimary,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const Spacer(),
                  if (_panErrorMsg != null && _panErrorMsg!.isNotEmpty) ...[
                    ErrorInfoWidget(
                      otpErrorMsg: _panErrorMsg,
                    ),
                    const Gap(16),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
