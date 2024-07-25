import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/clear_cart_params.dart';
import '../../../../domain/entities/params/mutual_funds/remove_fund_from_cart_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/mutual_funds/clear_cart/clear_cart_cubit.dart';
import '../../../cubits/mutual_funds/lumpsum_cart/lumpsum_cart_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/app_error_widget.dart';
import 'widgets/cart_item_tile.dart';

class LumpsumCartTabView extends StatelessWidget {
  const LumpsumCartTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LumpsumCartCubit, LumpsumCartState>(
      builder: (context, cartState) {
        if (cartState is LumpsumCartFundsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (cartState is LumpsumCartFundsLoadError) {
          return AppErrorWidget(
            errorType: cartState.appErrorType,
            error: cartState.error,
          );
        }

        if (cartState is LumpsumCartFundsLoaded ||
            cartState is RemoveFundFromLumpsumCartLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: cartState.mutualFundCart!.cartMutualFunds.isEmpty
                ? [
                    Assets.svgs.noTransaction.svg(),
                    const Gap(20),
                    Center(
                      child: Text(
                        'No mutual funds added to cart',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.neutral[500]!,
                        ),
                      ),
                    ),
                  ]
                : [
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mutual fund(s) chosen',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.neutral[500],
                            ),
                          ),
                          BlocConsumer<ClearCartCubit, ClearCartState>(
                            listener: (context, state) {
                              if (state is ClearCartSuccess) {
                                context
                                    .read<LumpsumCartCubit>()
                                    .getCartLumpsumFunds();
                              }
                            },
                            builder: (context, state) {
                              return state is ClearCartLoading
                                  ? const CircularProgressIndicator.adaptive()
                                  : TextButton(
                                      onPressed: () {
                                        context
                                            .read<ClearCartCubit>()
                                            .clearCart(
                                              ClearCartParams(
                                                purchaseType:
                                                    InvestmentType.lumpsum,
                                              ),
                                            );
                                      },
                                      style: TextButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary[500]!,
                                        ),
                                      ),
                                      child: const Text('Clear all'),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            cartState.mutualFundCart!.cartMutualFunds.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return CartItemTile(
                            cartItemId: cartState
                                .mutualFundCart!.cartMutualFunds[index].cartId,
                            image: cartState.mutualFundCart!
                                .cartMutualFunds[index].schemeLogo,
                            fundName: cartState.mutualFundCart!
                                .cartMutualFunds[index].schemeName,
                            amount: cartState.mutualFundCart!
                                .cartMutualFunds[index].purchaseAmount,
                            installmentDate: cartState
                                .mutualFundCart!.cartMutualFunds[index].invDate,
                            investmentType: InvestmentType.lumpsum,
                            folioNumber: cartState.mutualFundCart!
                                .cartMutualFunds[index].folioNumber,
                            onDelete: () {
                              context
                                  .read<LumpsumCartCubit>()
                                  .removeFundFromCart(
                                    RemoveFundFromCartParams(
                                      fundCartId: cartState.mutualFundCart!
                                          .cartMutualFunds[index].cartId,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.selectCartPaymentOption,
                              arguments: SelectCartPaymentOptionArgs(
                                transactionType: MFTransactionTypes.lumpsum,
                                cartValue: cartState.mutualFundCart!.cartValue,
                              ),
                            );
                          },
                          child: AmountWidget(
                            amount: cartState.mutualFundCart!.cartValue,
                            preText: 'Pay ',
                            isCompact: false,
                            hasSpace: false,
                          ),
                        ),
                      ),
                    ),
                  ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
