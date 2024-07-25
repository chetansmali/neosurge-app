import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../common/common.dart';
import '../../../common/utils.dart';
import '../../../data/models/digital_gold/create_order_response_model.dart';
import '../../../data/models/digital_gold/razor_pay_error_response_model.dart';
import '../../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../../logger.dart';
import '../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../cubits/util_cubits/post_payment_cubit/post_payment_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

const String _h = 'digital_gold_payment_screen';

class DigitalGoldPaymentScreen extends StatefulWidget {
  final CreateOrderResponseModel createOrderResponseModel;
  final CreateOrderParams createOrderParams;
  final Duration timeOut;

  const DigitalGoldPaymentScreen({
    Key? key,
    required this.createOrderResponseModel,
    required this.createOrderParams,
    required this.timeOut,
  }) : super(key: key);

  @override
  State<DigitalGoldPaymentScreen> createState() =>
      _DigitalGoldPaymentScreenState();
}

class _DigitalGoldPaymentScreenState extends State<DigitalGoldPaymentScreen> {
  late final Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _initiateRazorPayPayment(widget.createOrderResponseModel);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PostPaymentCubit, PostPaymentState>(
          listener: (context, state) {
            if (state is PostPaymentLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => WillPopScope(
                  onWillPop: () async => false,
                  child: const Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomLoader(),
                          Gap(20),
                          Text('Processing payment. Please wait...'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state is PostPaymentSuccess) {
              context.read<GoldUserCubit>().loadGoldUser();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                Routes.digitalGoldTransactionStatus,
                arguments: DigitalGoldTransactionStatusArgs(
                  isSuccess: true,
                  transactionType: widget.createOrderParams.transactionType,
                  orderDetails: widget.createOrderParams,
                ),
              );
            }
            if (state is PostPaymentFailure) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: Utils.getErrorMessage(
                  errorType: state.appErrorType,
                  msg: state.errorMessage,
                ),
              );
            }
          },
          child: const Center(
            child: CustomLoader(),
          )),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<PostPaymentCubit>().processDigitalGoldPayment(
          orderId: response.orderId!,
          paymentId: response.paymentId!,
          status: 'success',
        );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    RazorPayErrorResponseModel? errorResponse;
    try {
      if (response.message != null) {
        errorResponse = RazorPayErrorResponseModel.fromJson(
            json.decode(response.message!)['error']);
      }
    } catch (e) {
      errorResponse = null;
    }
    Navigator.pushReplacementNamed(
      context,
      Routes.digitalGoldTransactionStatus,
      arguments: DigitalGoldTransactionStatusArgs(
        isSuccess: false,
        transactionType: widget.createOrderParams.transactionType,
        errorResponse: errorResponse,
        orderDetails: widget.createOrderParams,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    logInfo(_h, 'External wallet response: ${response.walletName}');
  }

  void _initiateRazorPayPayment(CreateOrderResponseModel order) async {
    var options = {
      'key': order.key,
      'amount': order.amount,
      'name': order.name,
      'order_id': order.orderId,
      'description': order.description,
      'currency': 'INR',
      //set timeout to 2 seconds less than the actual timeout as buffer.
      'timeout': widget.timeOut.inSeconds - 2,
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
