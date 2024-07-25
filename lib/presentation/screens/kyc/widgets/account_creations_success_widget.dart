import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';

class AccountCreationSuccessWidget extends StatelessWidget {
  const AccountCreationSuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          LottieBuilder.network(
            'https://assets4.lottiefiles.com/datafiles/3RKIaYNZqu6RrV0/data.json',
            height: 300,
            width: 300,
            repeat: true,
          ),
          const Gap(20),
          Text(
            'Congratulations ${context.read<AuthCubit>().state.user?.userName ?? ''}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(20),
          Text(
            'Your investment account has been created successfully',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false),
            child: const Text('Let\'s get started'),
          ),
        ],
      ),
    );
  }
}
