import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/digital_gold/create_order_response_model.dart';
import '../../../../data/models/digital_gold/razor_pay_error_response_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../../../logger.dart';
import '../../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../../cubits/util_cubits/post_payment_cubit/post_payment_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_loader.dart';

const String _h = 'delivery_payment_screen';

class DeliveryPaymentScreen extends StatefulWidget {
  final CreateOrderResponseModel createOrderResponseModel;
  final CreateDeliveryOrderParams createDeliveryOrderParams;

  const DeliveryPaymentScreen({
    Key? key,
    required this.createOrderResponseModel,
    required this.createDeliveryOrderParams,
  }) : super(key: key);

  @override
  State<DeliveryPaymentScreen> createState() => _DeliveryPaymentScreenState();
}

class _DeliveryPaymentScreenState extends State<DeliveryPaymentScreen> {
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
                                Text('Processing payment. Please wait... '),
                              ],
                            ),
                          ),
                        ),
                      ));
            }
            if (state is PostPaymentSuccess) {
              context.read<GoldUserCubit>().loadGoldUser();
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context,
                  Routes.digitalGoldTransactionStatus, (route) => route.isFirst,
                  arguments: DigitalGoldTransactionStatusArgs(
                    isSuccess: true,
                    transactionType:
                        widget.createDeliveryOrderParams.transactionType,
                    orderDetails: CreateOrderParams(
                      metalType: widget.createDeliveryOrderParams.metalType,
                      amount: 0.0,
                      blockId: '',
                      lockPrice: 0.0,
                      transactionType:
                          widget.createDeliveryOrderParams.transactionType,
                      metalWeight: 0.0,
                    ),
                  ));
            }
            if (state is PostPaymentFailure) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: Utils.getErrorMessage(
                      errorType: state.appErrorType, msg: state.errorMessage));
            }
          },
          child: const Center(
            child: CustomLoader(),
          )),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<PostPaymentCubit>().processDeliveryPayment(
          orderId: response.orderId!,
          paymentId: response.paymentId!,
          dOP: widget.createDeliveryOrderParams,
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
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.digitalGoldTransactionStatus, (route) => route.isFirst,
        arguments: DigitalGoldTransactionStatusArgs(
            isSuccess: false,
            transactionType: DGTransactionType.delivery,
            orderDetails: CreateOrderParams(
              metalType: widget.createDeliveryOrderParams.metalType,
              amount: 0.0,
              blockId: '',
              lockPrice: 0.0,
              transactionType: widget.createDeliveryOrderParams.transactionType,
              metalWeight: 0.0,
            ),
            errorResponse: errorResponse));
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
      //No timeout for delivery
      // //set timeout to 2 seconds less than the actual timeout as buffer.
      // 'timeout': widget.timeOut.inSeconds - 2,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': order.contact, 'email': order.email},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      logErrorObject(_h, e, 'Razorpay payment Initialization failed');
    }
  }
}
