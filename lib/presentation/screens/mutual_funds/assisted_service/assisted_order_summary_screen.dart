import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/extensions.dart';
import '../../../../data/models/assisted_service/invest_suggested_funds_response.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/assisted_service/initiate_suggested_funds_payment_cubit/initiate_suggested_funds_payment_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../loading_screen.dart';

class AssistedOrderSummaryScreen extends StatelessWidget {
  final InvestSuggestedFundsResponse result;
  final double totalAmount;

  const AssistedOrderSummaryScreen(
      {Key? key, required this.result, required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to cancel this transaction?'),
                actions: <Widget>[
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
              );
            });
        return res ?? false;
      },
      child: LoadingScreen(
        child: Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(20),
                Text(
                  'You are about to invest in the assisted service funds worth ${totalAmount.toCurrencyWithSymbol()}',
                  textAlign: TextAlign.center,
                ),
                const Gap(5),
                const Spacer(),
                BlocListener<InitiateSuggestedFundsPaymentCubit,
                    InitiateSuggestedFundsPaymentState>(
                  listener: (context, state) {
                    if (state is InitiateSuggestedFundsPaymentSuccess) {
                      Navigator.pushNamed(context, Routes.paymentWebView,
                          arguments: PaymentWebViewArgs(
                              url: state.response.paymentUrl,
                              transactionType:
                                  MFTransactionTypes.assistedService));
                    }
                    if (state is InitiateSuggestedFundsPaymentFailure) {
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
                      context
                          .read<InitiateSuggestedFundsPaymentCubit>()
                          .initiatePayment(
                              transactionIds: result.ids,
                              userId: context.read<AuthCubit>().state.user!.id);
                    },
                    child: const Text('Proceed to Pay'),
                  ),
                ),
                const Gap(20),
              ],
            )),
      ),
    );
  }
}
