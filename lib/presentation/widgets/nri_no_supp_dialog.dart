import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../gen/assets.gen.dart';

class NriNoSuppDialog extends StatelessWidget {
  const NriNoSuppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Uh Oh! Sorry',
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(10),
                Assets.svgs.nriNoSupp.svg(height: 100),
                const Gap(10),
                const Text(
                  'At this time, we are not accepting non-resident members on our online platform. You can connect with us Offline.',
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                ElevatedButton(onPressed: () {}, child: const Text('Contact Us')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
