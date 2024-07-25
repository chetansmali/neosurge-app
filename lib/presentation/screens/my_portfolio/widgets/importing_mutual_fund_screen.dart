import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/import_external_fund/account_details/account_details_cubit.dart';
import '../../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';

class ImportingMutualFund extends StatelessWidget {
  const ImportingMutualFund({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svgs/hour_glass.svg',
          height: 80,
        ),
        const Gap(8),
        const Text(
          'Your imported funds will appear\nin sometime.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
        const Gap(24),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await Future.wait<void>([
                context.read<AccountDetailsCubit>().getAccountDetails(
                      userId: context.read<AuthCubit>().state.user!.id,
                    ),
                context.read<ImportHoldingDataCubit>().getImportedHoldingData(
                      userId: context.read<AuthCubit>().state.user!.id,
                    ),
              ]);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(214, 50),
              maximumSize: const Size(214, 50),
            ),
            child: const Text('Refresh Now'),
          ),
        ),
      ],
    );
  }
}
