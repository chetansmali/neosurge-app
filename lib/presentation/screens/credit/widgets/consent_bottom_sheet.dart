import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/lamf/lamf_get_credit_limit/lamf_get_credit_limit_cubit.dart';
import 'custom_checkbox.dart';

class ConsentBottomSheet extends StatefulWidget {
  const ConsentBottomSheet({Key? key}) : super(key: key);

  @override
  State<ConsentBottomSheet> createState() => _ConsentBottomSheetState();
}

class _ConsentBottomSheetState extends State<ConsentBottomSheet> {
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "We need your consent",
                style:
                    baseTextStyle18500.copyWith(color: const Color(0xff2C3137)),
              ),
              const Spacer(),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.close,
                  color: Color(0xff2C3137),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Gap(32),
          GestureDetector(
            onTap: () => setState(() => agreeToTerms = !agreeToTerms),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckBox(
                  value: agreeToTerms,
                  onChanged: (value) => setState(() => agreeToTerms = value),
                ),
                const Gap(8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: baseTextStyle12400.copyWith(color: Colors.black),
                      children: const [
                        TextSpan(text: "Yes, I agree to "),
                        // TextSpan(
                        //   text: "Terms and Conditions",
                        //   style: const TextStyle(
                        //     color: AppColors.primaryColor,
                        //   ),
                        //   recognizer: TapGestureRecognizer()
                        //     ..onTap = () =>
                        //         launchUrlString("https://decentro.tech/terms"),
                        // ),
                        TextSpan(
                          text:
                              "Terms and conditions, and privacy policy of Decentro and Equifax. I hereby request a copy of my credit report and authorize Equifax to provide the same to Decentro Tech Private Limited and Bullsurge, on my behalf.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(60),
          ElevatedButton(
            onPressed: agreeToTerms
                ? () =>
                    context.read<LamfGetCreditLimitCubit>().lamfGetCreditLimit()
                : null,
            child:
                BlocConsumer<LamfGetCreditLimitCubit, LamfGetCreditLimitState>(
              listener: (context, state) {
                if (state is LamfGetCreditLimitSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is LamfGetCreditLimitLoading
                    ? Assets.animations.loading.lottie()
                    : const Text("Confirm");
              },
            ),
          ),
        ],
      ),
    );
  }
}
