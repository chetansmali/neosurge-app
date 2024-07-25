import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/custom_styles.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import 'custom_checkbox.dart';

class ImportLoansConsentBottomSheet extends StatefulWidget {
  const ImportLoansConsentBottomSheet({Key? key}) : super(key: key);

  @override
  State<ImportLoansConsentBottomSheet> createState() =>
      _ConsentBottomSheetState();
}

class _ConsentBottomSheetState extends State<ImportLoansConsentBottomSheet> {
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      children: [
                        const TextSpan(text: "Yes, I agree to "),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                launchUrlString("https://decentro.tech/terms"),
                        ),
                        const TextSpan(
                          text:
                              "and privacy policy of Decentro and Equifax. I hereby request a copy of my credit report and authorize Equifax to provide the same to Decentro Tech Private Limited and Bullsurge, on my behalf.",
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
                ? () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.importLoanFormScreen);
                  }
                : null,
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
