import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user/mandate_sip_model.dart';
import '../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/delete_mandate_cubit/delete_mandate_cubit.dart';
import '../../../cubits/account/mandate_sips_cubit/mandate_sips_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import 'widgets/delete_mandate_bottom_sheet.dart';
import 'widgets/mandate_tile.dart';

class DetailedMandateViewScreen extends StatelessWidget {
  const DetailedMandateViewScreen({
    super.key,
    required this.mandate,
  });

  final UserBankMandateModel mandate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mandate Details',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Builder(
            builder: (context) {
              final mandateSipsState = context.watch<MandateSipsCubit>().state;
              final deleteMandateState =
                  context.watch<DeleteMandateCubit>().state;

              if (deleteMandateState is DeleteMandateError) {
                Utils.showErrorAlert(
                  context,
                  deleteMandateState.error ?? 'An error occurred',
                );
              }

              if (deleteMandateState is DeleteMandateSuccess) {
                Navigator.pushNamed(
                  context,
                  Routes.verifyDeleteMandateScreen,
                  arguments: VerifyDeleteMandateScreenArgs(
                    deleteMandateRefId:
                        deleteMandateState.deleteMandateModel.deleteId,
                  ),
                );
              }

              return mandateSipsState is MandateSipsSuccess
                  ? ElevatedButton(
                      onPressed: () {
                        if (mandateSipsState.mandateSips.isNotEmpty) {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            builder: (context) {
                              return DeleteMandateBottomSheet(
                                sips: mandateSipsState.mandateSips,
                                mandate: mandate,
                              );
                            },
                          );
                        } else {
                          context.read<DeleteMandateCubit>().deleteMandate(
                                mandateId: mandate.mandateId,
                                closeAll: false,
                              );
                        }
                      },
                      child: deleteMandateState is DeleteMandateLoading
                          ? Assets.animations.loading.lottie()
                          : const Text('Delete Mandate'),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MandateTile(
            mandate: mandate,
            onTap: null,
          ),
          const Gap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'All SIPs linked',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Gap(16),
          BlocBuilder<MandateSipsCubit, MandateSipsState>(
            builder: (context, state) {
              if (state is MandateSipsLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is MandateSipsSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.mandateSips.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return _SipListTile(
                        sip: state.mandateSips[index],
                      );
                    },
                  ),
                );
              } else if (state is MandateSipsFailure) {
                return Center(
                  child: Text(
                    state.error ?? 'An error occurred',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.error[500],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _SipListTile extends StatelessWidget {
  final MandateSipModel sip;

  const _SipListTile({
    required this.sip,
  });

  @override
  Widget build(BuildContext context) {
    return BasketCustomContainer(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (sip.planLogo != null)
                CachedNetworkImage(
                  imageUrl: sip.planLogo!,
                  width: 34,
                  height: 34,
                ),
              const Gap(4),
              Expanded(
                child: Text(
                  sip.planName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              const Gap(12),
              AmountWidget(
                amount: sip.amount,
                isCompact: false,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SIP',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.success[500],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${sip.installmentDay} of every month',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutral[200],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
