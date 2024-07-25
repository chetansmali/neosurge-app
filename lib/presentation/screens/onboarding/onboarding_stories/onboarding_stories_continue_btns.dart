import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class OnboardingStoriesContinueBtn extends StatelessWidget {
  const OnboardingStoriesContinueBtn({
    super.key,
    required int currentPageIndex,
  }) : _currentPageIndex = currentPageIndex;

  final int _currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: _currentPageIndex == 3
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.home,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    MediaQuery.of(context).size.width,
                    56,
                  ),
                  maximumSize: Size(
                    MediaQuery.of(context).size.width,
                    56,
                  ),
                ),
                child: const Text('Get Started'),
              ),
            )
          : TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.home,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: const Text('Skip'),
            ),
    );
  }
}
