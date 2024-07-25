import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_loader.dart';

class NoMandateDialog extends StatelessWidget {
  const NoMandateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPrimaryBankCubit, GetPrimaryBankState>(
      listener: (context, state) {
        if (state is GetPrimaryBankLoadError) {
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(
                errorType: state.errorType, msg: state.errorMessage),
          );
        }
        if (state is GetPrimaryBankLoaded) {
          Navigator.pushReplacementNamed(
            context,
            Routes.detailedBankView,
            arguments: DetailedBankViewArgs(
              index: 0,
              bank: state.bankDetails,
              isFromCreateMandatePopup: true,
            ),
          );
        }
      },
      builder: (context, state) => WillPopScope(
        onWillPop: () async => state is GetPrimaryBankLoading ? false : true,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () => state is GetPrimaryBankLoading
                      ? null
                      : Navigator.of(context).pop(),
                ),
              ),
              Text(
                'No Mandates Found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(20),
              Assets.svgs.nriNoSupp.svg(),
              const Gap(20),
              const Text(
                  'It seems like no mandate is created for the selected primary bank. You need to create mandate before creating an SIP Order.'),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  context.read<GetPrimaryBankCubit>().getPrimaryBank();
                },
                child: state is GetPrimaryBankLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CustomLoader(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Create Mandate'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
