import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../../../routes/routes.dart';

class FundNotImportedView extends StatelessWidget {
  const FundNotImportedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/gifs/import_fund.gif',
            height: 240,
          ),
          const Text(
            'Import your investments from other platforms\nso that you can manage and\ntrack them on Neosurge.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed(
                Routes.importExternalFundsPan,
              );

              if (!context.mounted) {
                return;
              }
              await context
                  .read<ImportHoldingDataCubit>()
                  .getImportedHoldingData(
                    userId: context.read<AuthCubit>().state.user!.id,
                  );
            },
            child: const Text('Import Funds'),
          ),
        ],
      ),
    );
  }
}
