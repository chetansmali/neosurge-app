import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../cubits/mutual_funds/edit_cart/edit_cart_cubit.dart';
import '../../../../cubits/mutual_funds/lumpsum_cart/lumpsum_cart_cubit.dart';
import '../../../../cubits/mutual_funds/sip_cart/sip_cart_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/amount_widget.dart';
import '../../lumpsum/edit_cart_lumpsum_screen.dart';
import '../../sip/edit_cart_sip_screen.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.cartItemId,
    required this.image,
    required this.fundName,
    required this.amount,
    this.installmentDate,
    required this.investmentType,
    this.folioNumber,
    required this.onDelete,
  });

  final int cartItemId;
  final String image;
  final String fundName;
  final double amount;
  final String? installmentDate;
  final InvestmentType investmentType;
  final String? folioNumber;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://mutualfunds.neosurge.money/$image',
                width: 30,
                height: 30,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  fundName,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.neutral[400],
                  ),
                ),
              ),
            ],
          ),
          if (folioNumber != null) ...[
            const Gap(8),
            Text(
              'Folio no. $folioNumber',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.neutral[200],
              ),
            ),
          ],
          Divider(
            color: AppColors.neutral[50],
            thickness: 1,
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (investmentType == InvestmentType.lumpsum) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => getIt<EditCartCubit>(),
                            child: EditCartLumpsumScreen(
                              cartID: cartItemId,
                              initialAmount: amount,
                            ),
                          ),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => getIt<EditCartCubit>(),
                            child: EditCartSIPScreen(
                              cartID: cartItemId,
                              initialAmount: amount,
                            ),
                          ),
                        ));
                  }
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.neutral[200],
                ),
              ),
              const Gap(6.0),
              Expanded(
                child: AmountWidget(
                  amount: amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  isCompact: false,
                ),
              ),
              Builder(
                builder: (context) {
                  final lumpsumCubitState =
                      context.watch<LumpsumCartCubit>().state;
                  final sipCubitState = context.watch<SipCartCubit>().state;
                  if ((lumpsumCubitState is RemoveFundFromLumpsumCartLoading &&
                          lumpsumCubitState.cartItemId == cartItemId) ||
                      (sipCubitState is RemoveFundFromSipCartLoading &&
                          sipCubitState.cartItemId == cartItemId)) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  return GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      CupertinoIcons.trash,
                      color: AppColors.error[500],
                      size: 18,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
