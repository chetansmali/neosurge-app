import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/user/user.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../cubits/account/user_mandate_cubit/user_mandate_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import '../../profile/widgets/list_icon.dart';
import 'edit_ifsc_bottomsheet.dart';
import '../mandate/widgets/mandate_tile.dart';

const double _size = 32;

class DetailedBankViewScreen extends StatelessWidget {
  final int index;

  const DetailedBankViewScreen({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBank bank =
        (context.watch<UserBankDetailsCubit>().state as UserBankDetailsLoaded)
            .bankList[index];
    final User user = context.watch<AuthCubit>().state.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Details'),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              if (!user.eSignSubmitDone && !user.isOnBoardingCompleted) {
                Fluttertoast.showToast(
                    msg: 'Please complete your kyc to setup auto mandate');
                return;
              } else if (!user.isOnBoardingCompleted) {
                Fluttertoast.showToast(
                    msg:
                        'Your kyc is under review. Once approved, you will be able to setup auto mandate');
                return;
              }
              Navigator.pushNamed(context, Routes.createAutoMandate);
            },
            child: const Text('Create AutoMandate'),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasketCustomContainer(
            child: _BankDetailsCard(bank: bank, index: index),
          ),
          const Gap(20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Automandates',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Gap(10),
          BlocBuilder<UserMandateCubit, UserMandateState>(
            builder: (context, state) {
              if (state is UserMandateLoading) {
                return const CustomLoader();
              }
              if (state is UserMandateLoadError) {
                return AppErrorWidget(
                  errorType: state.errorType,
                  error: state.errorMessage,
                );
              }

              if (state is UserMandateLoaded) {
                if (state.mandates.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(36),
                      Assets.svgs.noTransaction.svg(
                        height: 126,
                        width: 126,
                      ),
                      Text(
                        'You have no mandates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.neutral[300],
                        ),
                      )
                    ],
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.mandates.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return MandateTile(
                        mandate: state.mandates[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.mandateDetails,
                            arguments: DetailedMandateArgs(
                                userBankMandateModel: state.mandates[index]),
                          );
                        },
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _BankDetailsCard extends StatelessWidget {
  final UserBank bank;
  final int index;

  const _BankDetailsCard({Key? key, required this.bank, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bank.imageUrl == null
                ? ListIcon(
                    svgImage: Assets.icons.bank,
                  )
                : CachedNetworkImage(
                    imageUrl: bank.imageUrl!,
                    height: _size,
                    width: _size,
                    placeholder: (context, url) => CustomShimmer(
                      child: Container(
                        width: _size,
                        height: _size,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ListIcon(
                      svgImage: Assets.icons.bank,
                    ),
                  ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank.bankName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(2),
                  if (bank.isPrimaryAccount)
                    Text(
                      'Primary Account',
                      style: TextStyle(
                        color: AppColors.primary[500],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const Gap(30),
        _TwoRowText(
          'Status',
          bank.isBankVerified ? 'Verified' : 'Not Verified',
        ),
        const Gap(20),
        _TwoRowText(
          'Account Number',
          'XXXX${bank.accountNumber.substring(bank.accountNumber.length - 4)}',
        ),
        const Gap(20),
        _TwoRowText(
          'IFSC Code',
          bank.ifscCode,
          subtitleWidget: GestureDetector(
            onTap: () async {
              final res = await showModalBottomSheet(
                  context: context,
                  builder: (_) => const EditIFSCBottomSheet());
              if (res != null && (res as bool)) {
                //ignore:use_build_context_synchronously
                Navigator.pushNamed(
                  context,
                  Routes.editBankIfsc,
                  arguments: DetailedBankViewArgs(index: index, bank: bank),
                );
              }
            },
            child: const Icon(
              Icons.edit,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
        ),
        const Gap(20),
        _TwoRowText('Branch Name', bank.branchName),
      ],
    );
  }
}

class _TwoRowText extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? subtitleWidget;

  const _TwoRowText(this.title, this.subtitle, {Key? key, this.subtitleWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.neutral[400],
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitleWidget != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (subtitleWidget != null) ...[
                  const Gap(8),
                  subtitleWidget!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
