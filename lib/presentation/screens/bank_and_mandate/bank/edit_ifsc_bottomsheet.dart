import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditIFSCBottomSheet extends StatelessWidget {
  const EditIFSCBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to update your IFSC Code?',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const Gap(20),
          const Text('Your account will be re-verified according to the new IFSC Code'),
          const Gap(20),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              )),
              const Gap(10),
              Expanded(
                  child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              )),
            ],
          )
        ],
      ),
    );
  }
}
