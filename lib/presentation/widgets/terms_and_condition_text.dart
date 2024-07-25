import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/api/api_constants.dart';
import '../../flavors.dart';
import '../routes/route_arguments.dart';
import '../routes/routes.dart';

class TermsAndConditionText extends StatelessWidget {
  const TermsAndConditionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By Proceeding further, you agree to our ',
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFFB0B0B0),
        ),
        children: [
          TextSpan(
            text: 'Terms &\nConditions',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  Routes.aboutWebView,
                  arguments: AboutWebViewArgs(
                    url: '${F.baseUrl}${ApiConstants.termsAndConditions}',
                    title: 'Terms and Conditions',
                  ),
                );
              },
            style: const TextStyle(
              color: Color(0xFF769DFB),
            ),
          ),
          const TextSpan(text: ' & '),
          TextSpan(
            text: 'Privacy Policy',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  Routes.aboutWebView,
                  arguments: const AboutWebViewArgs(
                    url:
                        'https://www.freeprivacypolicy.com/live/8c2b4969-4e11-4a73-afb1-843b2b5278f5',
                    title: 'Privacy Policy',
                  ),
                );
              },
            style: const TextStyle(
              color: Color(0xFF769DFB),
            ),
          ),
        ],
      ),
    );
  }
}
