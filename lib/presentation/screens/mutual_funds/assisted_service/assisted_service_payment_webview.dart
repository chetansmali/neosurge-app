import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../data/models/assisted_service/unlock_assisted_service_response.dart';
import '../../../../logger.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/util_cubits/post_payment_cubit/post_payment_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

const String _h = 'assisted_service_payment_webview';

class AssistedServicePaymentWebView extends StatefulWidget {
  final UnlockAssistedServiceResponse response;

  const AssistedServicePaymentWebView({Key? key, required this.response})
      : super(key: key);

  @override
  State<AssistedServicePaymentWebView> createState() =>
      _AssistedServicePaymentWebViewState();
}

class _AssistedServicePaymentWebViewState
    extends State<AssistedServicePaymentWebView> {
  late final Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _initiateRazorPayPayment(widget.response);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<PostPaymentCubit, PostPaymentState>(
          listener: (context, state) {
            if (state is PostPaymentSuccess) {
              context.read<AuthCubit>().updateUser(state.user!);
            }
          },
          builder: (context, state) {
            if (state is PostPaymentLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is PostPaymentFailure) {
              return Center(
                child: AppErrorWidget(
                    errorType: state.appErrorType, error: state.errorMessage),
              );
            }
            if (state is PostPaymentSuccess) {
              final user = context.read<AuthCubit>().state.user!;
              context.read<AuthCubit>().updateUser(user.copyWith(
                  assistedServiceUserDetails:
                      state.user!.assistedServiceUserDetails));
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Payment Successful'),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        user.assistedServiceUserDetails != null
                            ? Navigator.popUntil(
                                context, (route) => route.isFirst)
                            : Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.startAssistedService,
                                (route) => route.isFirst);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<PostPaymentCubit>().processAssistedServicePayment(
        orderId: response.orderId!,
        paymentId: response.paymentId!,
        status: 'success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {
    logInfo(_h, 'External wallet response: ${response.walletName}');
  }

  void _initiateRazorPayPayment(UnlockAssistedServiceResponse order) async {
    var options = {
      'key': order.key,
      'amount': order.amount,
      'name': order.name,
      'order_id': order.orderId,
      'description': order.description,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': order.contact, 'email': order.email},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      logErrorObject(_h, e, 'Razorpay payment Initialization failed');
    }
  }
}
