import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/update_primary_bank_cubit/update_primary_bank_cubit.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_shimmer.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import '../../profile/widgets/list_icon.dart';
import 'confirm_primary_bottomsheet.dart';

const double _size = 32;

class BankInfoCard extends StatelessWidget {
  final int index;
  final UserBank bank;

  const BankInfoCard({Key? key, required this.index, required this.bank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<UserBankDetailsCubit>().selectBank(index);
        Navigator.pushNamed(context, Routes.detailedBankView,
            arguments: DetailedBankViewArgs(index: index, bank: bank));
      },
      child: BasketCustomContainer(
        // padding: const EdgeInsets.all(12.0),
        child: Row(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${bank.bankName} - ${bank.maskedBankAccountNumber}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Gap(10),
                      //3 dot menu
                      bank.isPrimaryAccount
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 28,
                              child: PopupMenuButton(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: const BorderSide(
                                    color: AppColors.primaryLightColor,
                                    width: 1,
                                  ),
                                ),
                                onSelected: (value) {
                                  if (value == 'make_primary') {
                                    showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const ConfirmPrimaryBottomSheet())
                                        .then(
                                      (value) => {
                                        if (value == true)
                                          {
                                            context
                                                .read<UpdatePrimaryBankCubit>()
                                                .updatePrimaryBankAccount(
                                                    index: index,
                                                    bankAccountId: bank.id)
                                          }
                                      },
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'make_primary',
                                    child: Text(
                                      'Make Primary',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                                icon: const Icon(Icons.more_vert, size: 20),
                              ),
                            ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      bank.isPrimaryAccount
                          ? Text(
                              'Primary Account',
                              style: TextStyle(
                                color: AppColors.primary[500],
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            const Icon(
              CupertinoIcons.arrowtriangle_right_fill,
              size: 16,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
