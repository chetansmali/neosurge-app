import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/initiate_cart_sip_purchase_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../../cubits/account/user_mandate_cubit/user_mandate_cubit.dart';
import '../../../cubits/mutual_funds/cart_lumpsum_purchase/cart_lumpsum_purchase_cubit.dart';
import '../../../cubits/mutual_funds/cart_sip_purchase/cart_sip_purchase_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/error_info_widget.dart';

class CartTransactionPaymentOptionScreen extends StatefulWidget {
  const CartTransactionPaymentOptionScreen({
    super.key,
    required this.transactionType,
    required this.cartValue,
  });

  final MFTransactionTypes transactionType;
  final double cartValue;

  @override
  State<CartTransactionPaymentOptionScreen> createState() =>
      _CartTransactionPaymentOptionScreenState();
}

class _CartTransactionPaymentOptionScreenState
    extends State<CartTransactionPaymentOptionScreen> {
  late final UserBank bankDetails;
  bool _hasMandateSelectionError = false;
  int? selectedBankMandate;

  void _navigateToVerifyOTP({required String orderRef}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamed(
        context,
        Routes.verifyCartTrasaction,
        arguments: VerifyCartPurchaseArgs(
          orderRef: orderRef,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Option'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16,
          ),
          child: Builder(
            builder: (context) {
              final lumpsumPurchaseState =
                  context.watch<CartLumpsumPurchaseCubit>().state;
              final sipPurchaseState =
                  context.watch<CartSipPurchaseCubit>().state;

              if (lumpsumPurchaseState is CartLumpsumPurchaseSuccess) {
                _navigateToVerifyOTP(
                  orderRef: lumpsumPurchaseState
                      .initiateCartLumpsumPurchaseResponse.cartPurchaseId,
                );
              }

              if (sipPurchaseState is CartSipPurchaseSuccess) {
                _navigateToVerifyOTP(
                  orderRef: sipPurchaseState
                      .initiateCartSipPurchaseResponse.cartPurchaseId,
                );
              }

              return ElevatedButton(
                onPressed: () {
                  if (widget.transactionType == MFTransactionTypes.sip) {
                    if (selectedBankMandate == null) {
                      setState(() {
                        _hasMandateSelectionError = true;
                      });
                      return;
                    }

                    context
                        .read<CartSipPurchaseCubit>()
                        .initiateCartSipPurchase(
                          params: InitiateCartSipPurchaseParams(
                            mandateId: selectedBankMandate!,
                          ),
                        );
                  } else {
                    context
                        .read<CartLumpsumPurchaseCubit>()
                        .initiateCartLumpsumPurchase();
                  }
                },
                child: lumpsumPurchaseState is CartLumpsumPurchaseLoading ||
                        sipPurchaseState is CartSipPurchaseLoading
                    ? Assets.animations.loading.lottie()
                    : AmountWidget(
                        amount: widget.cartValue,
                        preText: 'Pay ',
                        isCompact: false,
                        hasSpace: false,
                      ),
              );
            },
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomContainer(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Netbanking',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral[500],
                  ),
                ),
                const Divider(),
                BlocConsumer<GetPrimaryBankCubit, GetPrimaryBankState>(
                  listener: (context, state) {
                    if (state is GetPrimaryBankLoaded) {
                      bankDetails = state.bankDetails;
                      context.read<UserMandateCubit>().fetchUserMandates(
                            bankId: state.bankDetails.fpBankId!,
                          );
                    }
                  },
                  builder: (context, state) {
                    if (state is GetPrimaryBankLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (state is GetPrimaryBankLoaded) {
                      return RadioListTile.adaptive(
                        value: true,
                        groupValue: true,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {},
                        title: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.bankDetails.imageUrl ?? '',
                              width: 24,
                            ),
                            const Gap(10),
                            Text(
                              '${state.bankDetails.bankName} - ${state.bankDetails.maskedBankAccountNumber}',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.neutral[300]!,
                              ),
                            ),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                      );
                    }
                    return Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: AppColors.alert[50]!,
                        ),
                        const Gap(10),
                        Expanded(
                          child: Text(
                            'The amount will be credited to your primary bank account',
                            style: TextStyle(
                              color: AppColors.alert[500]!,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          if (widget.transactionType == MFTransactionTypes.sip) ...[
            const Gap(20),
            CustomContainer(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Automandate',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral[500],
                    ),
                  ),
                  const Divider(),
                  BlocBuilder<UserMandateCubit, UserMandateState>(
                    builder: (context, state) {
                      if (state is UserMandateLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      if (state is UserMandateLoaded) {
                        return Column(
                          children: [
                            ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.mandates.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return RadioListTile.adaptive(
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: bankDetails.imageUrl ?? '',
                                        width: 24,
                                      ),
                                      const Gap(10),
                                      Text(
                                        'Mandate ${state.mandates[index].mandateId}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.neutral[300]!,
                                        ),
                                      ),
                                    ],
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  value: state.mandates[index].mandateId,
                                  groupValue: selectedBankMandate,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedBankMandate = val as int;
                                    });
                                  },
                                );
                              },
                            ),
                            if (state.mandates.isNotEmpty) const Divider(),
                            const _CreateMandateWidget(),
                          ],
                        );
                      }

                      if (state is UserMandateLoadError) {
                        return const _CreateMandateWidget();
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            if (_hasMandateSelectionError) ...[
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ErrorInfoWidget(
                  otpErrorMsg: 'Select a mandate to proceed',
                ),
              ),
            ]
          ],
        ],
      ),
    );
  }
}

class _CreateMandateWidget extends StatelessWidget {
  const _CreateMandateWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.createAutoMandate);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.neutral[200]!,
            ),
            const Gap(10),
            Expanded(
              child: Text(
                'Add a new mandate',
                style: TextStyle(
                  color: AppColors.neutral[200]!,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
