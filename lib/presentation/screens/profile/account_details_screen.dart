import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/common.dart';
import '../../../data/models/user/user.dart';
import '../../../di/get_it.dart';
import '../../cubits/account/update_profile_photo_cubit/update_profile_photo_cubit.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/label_text.dart';
import 'widgets/profile_image.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'profile_image',
              child: BlocProvider(
                create: (context) => getIt<UpdateProfilePhotoCubit>(),
                child: const ProfileImage(
                  size: 120,
                  isEdit: true,
                ),
              ),
            ),
            const Gap(20),
            const LabelText(label: 'Name'),
            TextFormField(
              readOnly: true,
              initialValue: user.userName,
            ),
            const Gap(20),
            const LabelText(label: 'Email'),
            TextFormField(
              readOnly: true,
              initialValue: user.emailId,
            ),
            const Gap(20),
            const LabelText(label: 'Phone'),
            TextFormField(
              readOnly: true,
              initialValue: user.mobileNumber,
            ),
            const Gap(20),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Background color
          ),
          child: const Text('Delete Account'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const _DeleteAccountPopup(),
            );
          },
        ),
      ),
    );
  }
}

class _DeleteAccountPopup extends StatelessWidget {
  const _DeleteAccountPopup();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      title: Text(
        'Delete Account',
        style: baseTextStyle16500.copyWith(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                final Uri uri =
                    Uri(path: 'support@bullsurge.in', scheme: 'mailto');
                await launchUrl(uri);
              },
              child: RichText(
                text: TextSpan(
                  style: baseTextStyle12400.copyWith(
                      color: AppColors.neutral[400]),
                  children: [
                    const TextSpan(
                      text:
                          'If you want to delete your Neosurge Account, you can reach out to our support team at ',
                    ),
                    TextSpan(
                      text: 'support@bullsurge.in',
                      style: baseTextStyle12400.copyWith(
                        color: AppColors.primary[500],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "\n1. Before initiating the closure, you need to stop any active SIPs and redeem the existing amount.",
              style: baseTextStyle12400.copyWith(color: AppColors.neutral[400]),
            ),
            const Gap(5),
            Text(
              "\n2. For further mutual fund transactions reach out to AMC, CAMS or KARVY.",
              style: baseTextStyle12400.copyWith(color: AppColors.neutral[400]),
            ),
            const Gap(5),
            Text(
              "\n3. The team will process complete account deletion after the user's request upon ensuring the customer has no active holding in mutual funds and gold.",
              style: baseTextStyle12400.copyWith(color: AppColors.neutral[400]),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Understood'),
        ),
      ],
    );
  }
}
