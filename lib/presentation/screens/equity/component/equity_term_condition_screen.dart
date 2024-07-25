import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../routes/routes.dart';

import '../../../../common/common.dart';
import '../../../theme/app_colors.dart';

class EquityTermCondition extends StatelessWidget {
  const EquityTermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and conditions for NeoSurge',
          style: baseTextStyle16500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ResponsiveText('Acceptance of Terms',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                'By integrating your Equities Broker with NeoSurge, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not proceed with the integration.',
                baseTextStyle12500.copyWith(color: Colors.black54),
                true,
              ),
              ResponsiveText('Equities Broker Integration',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  ' NeoSurge facilitates the integration of Equities Brokers onto its platform, allowing users to access and manage their equity investments.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText('User Authorization',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  'Users authorizing the integration of their Equities Broker account with NeoSurge are solely responsible for any actions and transactions conducted through the integrated platform.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText(
                  'NeoSurge assumes no liability for the accuracy, completeness, or security of information provided by the Equities Broker or the user.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText('Security',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  'NeoSurge employs reasonable security measures to protect the integrity of the Equities Broker integration. However, we cannot guarantee the absolute security of user data.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText(
                  'Equities Brokers are responsible for implementing their own security measures to safeguard user information during the integration process.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText('Data Usage and Privacy',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  'NeoSurge will access and process data from the integrated Equities Broker accounts as necessary for the provision of services.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText(
                  'Equities Brokers and users consent to the use of their data as outlined in NeoSurge\'s Privacy Policy.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText('Liability',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  'NeoSurge shall not be liable for any losses, damages, or disruptions arising from the integration with Equities Brokers, including but not limited to system failures, data breaches, or unauthorized access.',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              ResponsiveText('Contact Information',
                  baseTextStyle14500.copyWith(color: Colors.black87), false),
              ResponsiveText(
                  'If you have any questions or concerns about the Equities Broker Integration Terms and Conditions, please contact us at support@bullsurge.in',
                  baseTextStyle12500.copyWith(color: Colors.black54),
                  true),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(335, 56),
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have a broker?",
                    style: baseTextStyle12400,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.equitySignup);
                    },
                    child: Text(
                      'Create an account',
                      style: baseTextStyle12400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool isRequied;

  const ResponsiveText(this.text, this.style, this.isRequied, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isRequied ? '\u2022 ' : '', // Bullet point character
              style: const TextStyle(color: AppColors.mainBlack),
            ),
            TextSpan(
              text: text,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
