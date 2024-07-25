import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../routes/routes.dart';

class ImportFundSuccessScreen extends StatelessWidget {
  const ImportFundSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/gifs/import_success.gif',
              height: 200,
            ),
            const Gap(24),
            const Text(
              'Your imported funds will appear\nin sometime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Routes.dashboard),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(214, 50),
                  maximumSize: const Size(214, 50),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
