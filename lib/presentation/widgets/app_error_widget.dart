import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/app_error.dart';
import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final String? error;

  final VoidCallback? onRetry;

  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.error,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        errorType == AppErrorType.network ? Assets.svgs.noNetwork.svg() : Assets.svgs.somethingWentWrong.svg(),
        const Gap(20),
        Text(
          errorType == AppErrorType.network ? 'Whoops !!' : 'Something is not right !!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            error != null && error!.isNotEmpty
                ? error!
                : (errorType == AppErrorType.network ? 'Please check your internet connection and try again.' : 'Oh no !! Something went wrong.\n Please try again after sometimes'),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(5),
        if (onRetry != null) IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh)),
      ],
    );
  }
}
