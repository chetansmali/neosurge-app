import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import '../../../../common/utils.dart';
import '../../../../domain/entities/params/retirement_calculator/generate_retirement_OTP_params.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/retirement_calculator/generate_retirement_otp_cubit.dart';
import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class RetirementBottomSheet extends StatefulWidget {
  final int monthlyIncome;
  final int retirementAge;
  final int existingSavings;
  final String investmentStyle;
  final int monthlyExpense;
  final String postRetirementStyle;
  const RetirementBottomSheet(
      {super.key,
      required this.monthlyIncome,
      required this.retirementAge,
      required this.existingSavings,
      required this.investmentStyle,
      required this.monthlyExpense,
      required this.postRetirementStyle});

  @override
  State<RetirementBottomSheet> createState() => _RetirementBottomSheetState();
}

class _RetirementBottomSheetState extends State<RetirementBottomSheet> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('We need your consent', style: baseTextStyle18500),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Assets.icons.crossIcon.image(height: 20, width: 24),
                ),
              ],
            ),
          ),
          const Gap(10),
          CheckboxListTile.adaptive(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
            side: BorderSide(
              color: _isChecked == true ? Colors.blueAccent : Colors.black,
            ),
            checkColor: AppColors.primaryColor,
            activeColor: Colors.blue[50],
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Yes, I agree to',
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.mainBlack),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: baseTextStyle12400.copyWith(
                        color: AppColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                  ),
                  TextSpan(
                    text:
                        ' and privacy policy of Decentro and Equifax. I hereby request a copy of my credit report and authorize Equifax to provide the same to Decentro Tech Private Limited and Bullsurge, on my behalf.',
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.mainBlack),
                  ),
                ],
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const Gap(40),
          ElevatedButton(
            onPressed: () {
              if (_isChecked) {
                context.read<GenerateRetirementOtpCubit>().getRetirementotp(
                    GenerateRetirementOTPParams(
                        mobileNumber: context
                            .read<AuthCubit>()
                            .state
                            .user!
                            .mobileNumber!));
              } else {
                Fluttertoast.showToast(
                    msg: 'Please agree to terms and conditions');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isChecked ? AppColors.primaryColor : AppColors.textGrey,
              fixedSize: const Size(300, 56),
            ),
            child: BlocConsumer<GenerateRetirementOtpCubit,
                GenerateRetirementOtpState>(
              listener: (_, state) {
                if (state is GenerateRetirementOtpSuccess) {
                  {
                    if (state.generateRetirementOTPModel.status == 'failure') {
                      Navigator.pop(context);
                      Utils.showErrorAlert(
                          context, state.generateRetirementOTPModel.message);
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.retirementOTPScreen,
                        arguments: RetirementCorpusArgs(
                          monthlyIncome: widget.monthlyExpense,
                          monthlyExpense: widget.monthlyExpense,
                          existingSavings: widget.existingSavings,
                          investmentStyle: widget.postRetirementStyle,
                          postRetirementStyle: widget.postRetirementStyle,
                          retirementAge: widget.retirementAge,
                          requestID:
                              state.generateRetirementOTPModel.requestId ?? '',
                        ),
                      );
                    }
                  }
                }
                if (state is GenerateRetirementOtpFailure) {
                  Utils.showWarningAlert(context, state.errorMessage ?? '');
                }
              },
              builder: (context, state) {
                return state is GenerateRetirementOtpLoading
                    ? Assets.animations.loading.lottie()
                    : const Text('Confirm');
              },
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
