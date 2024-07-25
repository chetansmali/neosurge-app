import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../../constants/meta_strings.dart';
import '../../../../data/models/user/user.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../theme/app_colors.dart';

class DgDisclaimerSheet extends HookWidget {
  const DgDisclaimerSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final val = useState<bool>(false);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    'Disclaimer',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const Text(
                  AppStrings.digitalGoldDisclaimerText,
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 2,
                    letterSpacing: 0.25,
                  ),
                ),
                CheckboxListTile(
                    value: val.value,
                    onChanged: (value) {
                      val.value = value!;
                    },
                    title: const Text('Never Show this again'),
                    controlAffinity: ListTileControlAffinity.leading),
                ElevatedButton(
                    onPressed: () {
                      if (val.value) {
                        final User user = context.read<AuthCubit>().state.user!;
                        context.read<AuthCubit>().updateUser(
                            user.copyWith(showGoldDisclaimer: false));
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Ok, Got it!')),
                const Gap(20),
              ],
            ),
          )),
        ),
      ],
    );
  }
}
