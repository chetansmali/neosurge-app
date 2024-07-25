import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../routes/routes.dart';

class MailSucessScreen extends StatelessWidget {
  const MailSucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.pngs.mailSuccess.image(
              height: 200,
              width: 200,
            ),
            const Text(
              'Your email has been received',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / (1.05),
                child: const Text(
                  'Our support team is working on assisting you and will get back to you within 24-48 hrs',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.contactUs);
          },
          child: const Text('Done'),
        ),
      ),
    );
  }
}
