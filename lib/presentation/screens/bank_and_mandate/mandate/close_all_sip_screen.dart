import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user/mandate_sip_model.dart';
import '../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../cubits/account/delete_mandate_cubit/delete_mandate_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

import '../../../widgets/amount_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';

class CloseAllSipScreen extends StatelessWidget {
  const CloseAllSipScreen({
    super.key,
    required this.sips,
    required this.mandate,
  });

  final List<MandateSipModel> sips;
  final UserBankMandateModel mandate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All SIPs linked'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<DeleteMandateCubit, DeleteMandateState>(
            listener: (context, state) {
              if (state is DeleteMandateError) {
                Utils.showErrorAlert(
                  context,
                  state.error ?? 'An error occurred',
                );
              }
              if (state is DeleteMandateSuccess) {
                Navigator.pushNamed(
                  context,
                  Routes.verifyDeleteMandateScreen,
                  arguments: VerifyDeleteMandateScreenArgs(
                    deleteMandateRefId: state.deleteMandateModel.deleteId,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<DeleteMandateCubit>().deleteMandate(
                        closeAll: true,
                        mandateId: mandate.mandateId,
                      );
                },
                child: state is DeleteMandateLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Close All SIPs'),
              );
            },
          ),
        ),
      ),
      body: BasketCustomContainer(
        child: ListView.separated(
          itemCount: sips.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              leading: sips[index].planLogo != null
                  ? CachedNetworkImage(
                      imageUrl: sips[index].planLogo!,
                      width: 36,
                      height: 36,
                    )
                  : null,
              title: Text(
                sips[index].planName,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutral[400],
                ),
              ),
              trailing: AmountWidget(
                amount: sips[index].amount,
                isCompact: false,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
