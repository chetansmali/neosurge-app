import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/neobaskets/basket_details.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/neobaskets/basket_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../../../cubits/neobaskets/basket_lumpsum_order/basket_lumpsum_order_cubit.dart';
import '../../../cubits/neobaskets/basket_order_consent/basket_order_consent_cubit.dart';
import '../../../cubits/neobaskets/basket_sip_order/basket_sip_order_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../sip/no_mandate_dialog.dart';
import '../widgets/basket_custom_container.dart';

class BasketOrderSummaryScreen extends StatefulWidget {
  const BasketOrderSummaryScreen({
    super.key,
    required this.basketDetails,
    required this.investmentAmount,
    required this.investmentType,
    required this.investmentDate,
    required this.installments,
  });

  final BasketDetailsModel basketDetails;
  final int investmentAmount;
  final BasketInvestmentType investmentType;
  final int investmentDate;
  final int installments;

  @override
  State<BasketOrderSummaryScreen> createState() =>
      _BasketOrderSummaryScreenState();
}

class _BasketOrderSummaryScreenState extends State<BasketOrderSummaryScreen> {
  late final String _orderRef;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order Summary'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              if (widget.investmentType == BasketInvestmentType.lumpsum) {
                context
                    .read<BasketLumpsumOrderCubit>()
                    .initiateBasketLumpsumOrder(
                      BasketOrderParams(
                        amount: widget.investmentAmount,
                        basketId: widget.basketDetails.basketId ?? '',
                      ),
                    );
              } else {
                context.read<BasketSipOrderCubit>().initiateBasketSipOrder(
                      BasketOrderParams(
                        basketId: widget.basketDetails.basketId ?? '',
                        amount: widget.investmentAmount,
                        monthlyInvDate: widget.investmentDate.toString(),
                        installments: widget.installments,
                      ),
                    );
              }
            },
            child: Builder(
              builder: (context) {
                final lumpsumOrderState =
                    context.watch<BasketLumpsumOrderCubit>().state;
                final sipOrderState =
                    context.watch<BasketSipOrderCubit>().state;
                final createConsentState =
                    context.watch<BasketOrderConsentCubit>().state;

                return lumpsumOrderState is BasketLumpsumOrderLoading ||
                        sipOrderState is BasketSipOrderLoading ||
                        createConsentState is BasketOrderConsentCreating
                    ? Assets.animations.loading.lottie()
                    : const Text(
                        'Proceed to Payment',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      );
              },
            ),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BasketLumpsumOrderCubit, BasketLumpsumOrderState>(
            listener: (context, state) {
              if (state is BasketLumpsumOrderSuccess) {
                _orderRef = state.basketOrderResponse.orderRef;
                context
                    .read<BasketOrderConsentCubit>()
                    .createBasketOrderConsent();
              }
            },
          ),
          BlocListener<BasketSipOrderCubit, BasketSipOrderState>(
            listener: (context, state) {
              if (state is BasketSipOrderSuccess) {
                _orderRef = state.basketOrderResponse.orderRef;
                context
                    .read<BasketOrderConsentCubit>()
                    .createBasketOrderConsent();
              } else if (state is BasketSipOrderFailure &&
                  (state.errorMessage
                          ?.contains('User Mandate is not present') ??
                      false)) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => BlocProvider.value(
                    value: context.read<GetPrimaryBankCubit>(),
                    child: const Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: NoMandateDialog(),
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<BasketOrderConsentCubit, BasketOrderConsentState>(
            listener: (context, state) {
              if (state is BasketOrderConsentCreated) {
                Navigator.of(context).pushReplacementNamed(
                  Routes.buyBasketOtpScreen,
                  arguments: BasketOtpArgs(
                    basketInvestmentType: widget.investmentType,
                    orderRef: _orderRef,
                    consentId: state.consentModel.id.toString(),
                  ),
                );
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BasketCustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _SummaryDetailTile(
                    title: 'Basket',
                    value: widget.basketDetails.name,
                  ),
                  _SummaryDetailTile(
                    title: 'Order Type',
                    value: widget.investmentType.toString(),
                  ),
                  _SummaryDetailTile(
                    title: 'Amount',
                    value: '₹${widget.investmentAmount}',
                    valueColor: AppColors.secondaryViolet,
                  ),
                  if (widget.investmentType == BasketInvestmentType.sip)
                    _SummaryDetailTile(
                      title: 'Investment Date',
                      value:
                          '${widget.investmentDate == 1 ? '1st' : widget.investmentDate == 2 ? '2nd' : widget.investmentDate == 3 ? '3rd' : '${widget.investmentDate}th'} of every month',
                    ),
                ],
              ),
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                'Funds in this Basket',
                style: TextStyle(
                  color: Color(0xFF151A20),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(16),
            BasketCustomContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.basketDetails.basketFunds
                    .map(
                      (e) => Column(
                        children: [
                          _SummaryDetailTile(
                            title: e.fundName ?? '',
                            value:
                                '₹ ${((e.allocationPercentage ?? 0) * widget.investmentAmount / 100).toStringAsFixed(2)}',
                          ),
                          if (e != widget.basketDetails.basketFunds.last)
                            const Divider(),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryDetailTile extends StatelessWidget {
  const _SummaryDetailTile({
    Key? key,
    required this.title,
    required this.value,
    this.valueColor = const Color(0xFF000000),
  }) : super(key: key);

  final String title;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF47586E),
              ),
            ),
          ),
          const Gap(20),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
