import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../data/models/user/user_mandate_details_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class AutoMandateStatusScreen extends StatelessWidget {
  /// if [isCreate] is true then the mandate was created successfully
  /// else it means the mandate was activated successfully.
  final bool isCreate;
  final UserBank bank;
  final UserMandate? mandate;
  final bool isFailed;

  const AutoMandateStatusScreen({Key? key, this.isCreate = false, required this.bank, this.mandate, this.isFailed = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isFailed ? Icons.error_rounded : Icons.check_circle_outline,
                    color: isFailed ? AppColors.errorRed : AppColors.green,
                    size: 100,
                  ),
                  const Gap(20),
                  Text(
                    isFailed ? 'Oops!!' : 'Congratulations!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Gap(20),
                  isFailed
                      ? const Text(
                          'Your mandate authorisation failed due to some reason. Please go back and try again.',
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          isCreate
                              ? 'You have created your mandate successfully. You need to activate the mandate by going to your bank page and authorising the mandate.'
                              : 'You have successfully activated AutoMandate. Installments will get deducted automatically on date of SIP',
                          textAlign: TextAlign.center,
                        ),
                  const Divider(),
                  ListTile(
                    leading: bank.imageUrl == null
                        ? Assets.icons.bank.svg()
                        : CachedNetworkImage(
                            imageUrl: bank.imageUrl!,
                            width: 50,
                            height: 50,
                          ),
                    title: Text(bank.bankName),
                    subtitle: Text(bank.maskedBankAccountNumber),
                  ),
                  const Divider(),
                ],
              ),
            ),
            if (isCreate) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Authorise later')),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.authoriseMandateWebView, arguments: AuthoriseMandateArgs(mandate: mandate!, bank: bank));
                        },
                        child: const Text('Authorise now')),
                  ),
                ],
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Ok, Got It'),
              )
            ]
          ],
        ),
      ),
    );
  }
}
