import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/lumpsum_purchase/initiate_lumpsum_purchase_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../loading_screen.dart';

class LumpsumOrderSummaryScreen extends HookWidget {
  final FundDetail fundDetail;
  final LumpsumPurchase lumpsumPurchase;

  const LumpsumOrderSummaryScreen(
      {Key? key, required this.fundDetail, required this.lumpsumPurchase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() =>
        NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2));
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title:
                const Text('Are you sure you want to cancel this transaction?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      child: LoadingScreen(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Order Summary'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Text(
                //   'Order Summary',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                // ),
                // const Gap(30),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: fundDetail.imgUrl,
                          height: 50,
                          width: 50,
                        ),
                        const Gap(10),
                        Expanded(child: Text(fundDetail.schemeNameUnique)),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                _TwoRowText('Amount(\u20b9)',
                    inrFormatter.format(lumpsumPurchase.amount)),
                const Gap(20),
                _TwoRowText('Purchase Type', lumpsumPurchase.type),
                const Gap(20),
                _TwoRowText('Folio No.', lumpsumPurchase.folioNumber ?? 'N/A'),
                const Spacer(),
                const Gap(20),
                Center(
                  child: BlocListener<InitiateLumpsumPurchaseCubit,
                      InitiateLumpsumPurchaseState>(
                    listener: (context, state) {
                      if (state is InitiateLumpsumPurchaseSuccess) {
                        Navigator.pushNamed(
                          context,
                          Routes.paymentWebView,
                          arguments: PaymentWebViewArgs(
                            url: state.response.paymentUrl,
                            transactionType: MFTransactionTypes.lumpsum,
                          ),
                        );
                      }
                      if (state is InitiateLumpsumPurchaseFailure) {
                        Utils.showErrorAlert(
                          context,
                          Utils.getErrorMessage(
                              errorType: state.errorType,
                              msg: state.errorMessage),
                        );
                      }
                    },
                    child: ElevatedButton(
                        onPressed: () {
                          final userId =
                              context.read<AuthCubit>().state.user!.id;
                          context
                              .read<InitiateLumpsumPurchaseCubit>()
                              .initiateLumpsumPurchase(
                                  userId: userId, mfId: lumpsumPurchase.id);
                        },
                        child: const Text('Proceed to Pay')),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TwoRowText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TwoRowText(this.title, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(),
            ),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
