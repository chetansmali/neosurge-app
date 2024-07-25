import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user/mandate_sip_model.dart';
import '../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/delete_mandate_cubit/delete_mandate_cubit.dart';
import '../../../cubits/account/get_user_switchable_mandates_cubit/get_user_switchable_mandates_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/error_info_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';

class SwitchSipMandateScreen extends StatefulWidget {
  const SwitchSipMandateScreen({
    super.key,
    required this.sips,
    required this.mandate,
  });

  final List<MandateSipModel> sips;
  final UserBankMandateModel mandate;

  @override
  State<SwitchSipMandateScreen> createState() => _SwitchSipMandateScreenState();
}

class _SwitchSipMandateScreenState extends State<SwitchSipMandateScreen> {
  bool isMandateListVisible = false;

  int? selectedMandateId;

  String? _errorMsg;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_errorMsg != null) ...[
                ErrorInfoWidget(
                  otpErrorMsg: _errorMsg,
                ),
                const Gap(10),
              ],
              BlocConsumer<DeleteMandateCubit, DeleteMandateState>(
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
                      if (selectedMandateId == null) {
                        setState(() {
                          _errorMsg = 'Please select a mandate';
                        });
                        return;
                      }
                      context.read<DeleteMandateCubit>().deleteMandate(
                            mandateId: widget.mandate.mandateId,
                            alternateId: selectedMandateId,
                            closeAll: false,
                          );
                    },
                    child: state is DeleteMandateLoading
                        ? Assets.animations.loading.lottie()
                        : const Text('Move All SIPs'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Move To',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    isMandateListVisible = !isMandateListVisible;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Choose Mandate',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral[300],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.neutral[50]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.neutral[50]!,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.neutral[50]!,
                    ),
                  ),
                  suffixIcon: Icon(
                    isMandateListVisible
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 16,
                  ),
                ),
              ),
            ),
            const Gap(10),
            if (isMandateListVisible) _buildAllMandates(),
            const Gap(24),
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
            _buildCurrentSips(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllMandates() {
    return BlocBuilder<GetUserSwitchableMandatesCubit,
        GetUserSwitchableMandatesState>(
      builder: (context, state) {
        if (state is GetUserSwitchableMandatesLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is GetUserSwitchableMandatesError) {
          return Center(
            child: Text(state.errorMessage ?? 'An error occurred'),
          );
        }

        if (state is GetUserSwitchableMandatesLoaded) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.neutral[50]!,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: state.mandates.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.svgs.noTransaction.svg(
                        width: 100,
                        height: 100,
                      ),
                      const Gap(10),
                      const Text(
                        'No Mandates found',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: state.mandates.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedMandateId = state.mandates[index].mandateID;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${state.mandates[index].mandateID}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: state.mandates[index].mandateID ==
                                            selectedMandateId
                                        ? AppColors.primary[500]
                                        : AppColors.neutral[500],
                                  ),
                                ),
                                const Spacer(),
                                AmountWidget(
                                  isCompact: false,
                                  amount: state.mandates[index].mandateLimit,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: state.mandates[index].mandateID ==
                                            selectedMandateId
                                        ? AppColors.primary[500]
                                        : AppColors.neutral[500],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              state.mandates[index].bankName,
                              style: TextStyle(
                                fontSize: 12,
                                color: state.mandates[index].mandateID ==
                                        selectedMandateId
                                    ? AppColors.primary[500]
                                    : AppColors.neutral[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCurrentSips() {
    return BasketCustomContainer(
      child: ListView.separated(
        itemCount: widget.sips.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: widget.sips[index].planLogo != null
                ? CachedNetworkImage(
                    imageUrl: widget.sips[index].planLogo!,
                    width: 36,
                    height: 36,
                  )
                : null,
            title: Text(
              widget.sips[index].planName,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.neutral[400],
              ),
            ),
            trailing: AmountWidget(
              amount: widget.sips[index].amount,
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
    );
  }
}
