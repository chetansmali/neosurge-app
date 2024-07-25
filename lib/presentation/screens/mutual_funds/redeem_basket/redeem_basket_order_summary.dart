import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/basket_order_consent/basket_order_consent_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../widgets/amount_widget.dart';
import '../widgets/basket_custom_container.dart';
import 'widgets/exit_load_bottom_sheet.dart';
import 'widgets/tax_implication_bottom_sheet.dart';

class RedeemBasketOrderSummary extends StatefulWidget {
  const RedeemBasketOrderSummary({
    super.key,
    required this.basketRedeemOrderResponse,
  });

  final BasketRedeemOrderResponse basketRedeemOrderResponse;

  @override
  State<RedeemBasketOrderSummary> createState() =>
      _RedeemBasketOrderSummaryState();
}

class _RedeemBasketOrderSummaryState extends State<RedeemBasketOrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Expected Transfer by ${DateFormat('dd MMM yyyy').format(DateTime.now().add(const Duration(days: 3)))}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF47586E),
                ),
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<BasketOrderConsentCubit>()
                      .createBasketOrderConsent();
                },
                child: BlocConsumer<BasketOrderConsentCubit,
                    BasketOrderConsentState>(listener: (context, state) {
                  if (state is BasketOrderConsentCreated) {
                    Navigator.of(context).pushReplacementNamed(
                      Routes.redeemBasketOtpVerify,
                      arguments: RedeemBasketOtpVerifyArgs(
                        consentId: state.consentModel.id.toString(),
                        orderRef:
                            widget.basketRedeemOrderResponse.redemptionRef,
                      ),
                    );
                  }
                }, builder: (context, state) {
                  return state is BasketOrderConsentCreating
                      ? Assets.animations.loading.lottie()
                      : const Text('Redeem');
                }),
              ),
            ],
          ),
        ),
      ),
      body: BasketCustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Redeeming',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF297DFD),
              ),
            ),
            const Gap(10),
            Text(
              widget.basketRedeemOrderResponse.name ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            _SummaryInfoTile(
              title: const Text(
                'Amount',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF47586E),
                ),
              ),
              value: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountWidget(
                    amount: widget.basketRedeemOrderResponse.amount ?? 0,
                    isCompact: false,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF050C1B),
                    ),
                  ),
                  // const Text(
                  //    '(${} units approx.)',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Color(0xFF47586E),
                  //   ),
                  // ),
                ],
              ),
            ),
            const Gap(12),
            _SummaryInfoTile(
              title: Row(
                children: [
                  const Text(
                    'Exit Load',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF47586E),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        builder: (context) {
                          return const ExitLoadBottomSheet();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                      color: Color(0xFFFFCF34),
                    ),
                  ),
                ],
              ),
              value: AmountWidget(
                amount: widget.basketRedeemOrderResponse.exitLoad ?? 0,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF47586E),
                ),
              ),
            ),
            _SummaryInfoTile(
              title: Row(
                children: [
                  const Text(
                    'Tax Implications',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF47586E),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        builder: (context) {
                          return const TaxImplicationBottomSheet();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.info,
                      color: Color(0xFFFFCF34),
                    ),
                  ),
                ],
              ),
              value: const Text(
                'NA',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF47586E),
                ),
              ),
            ),
            const Gap(12),
            _SummaryInfoTile(
              title: const Text.rich(
                TextSpan(
                  text: 'Redeemable Amount\n',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                  children: [
                    TextSpan(
                      text: '(After Tax and Exit Load)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF47586E),
                      ),
                    ),
                  ],
                ),
              ),
              value: AmountWidget(
                amount: widget.basketRedeemOrderResponse.redeemableAmount ?? 0,
                isCompact: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF43B649),
                ),
              ),
            ),
            const Divider(
              height: 32,
            ),
            const Text(
              'Transfer Amount to',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF000000),
              ),
            ),
            ListView.builder(
              itemCount: widget.basketRedeemOrderResponse.bankDetails.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RadioListTile.adaptive(
                  visualDensity: const VisualDensity(horizontal: -4),
                  value: true,
                  groupValue: true,
                  onChanged: (val) {},
                  title: Text(
                    '${widget.basketRedeemOrderResponse.bankDetails[index].bankName?.toUpperCase()} - *${widget.basketRedeemOrderResponse.bankDetails[index].accountNumber}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryInfoTile extends StatelessWidget {
  const _SummaryInfoTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final Widget title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title,
        value,
      ],
    );
  }
}
