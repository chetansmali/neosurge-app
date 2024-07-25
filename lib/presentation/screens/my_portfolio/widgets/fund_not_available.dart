import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class FundNotAvailable extends StatelessWidget {
  const FundNotAvailable({
    super.key,
    required this.panNumber,
  });
  final String panNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/svgs/fund_not_found_alert.svg',
            height: 80,
          ),
          const Gap(8),
          const Text(
            'No investments found!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(4),
          Text(
            'No mutual fund investments found for\n+91 ${context.read<AuthCubit>().state.user!.mobileNumber} linked to PAN $panNumber.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.importExternalFundsPan,
              );
            },
            child: const Text('Continue with alternate mobile'),
          ),
          const Gap(18),
          const Text(
            'I’ll do it later',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
