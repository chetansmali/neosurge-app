import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../common/utils.dart';
import '../../cubits/import_external_fund/transaction/transaction_cubit.dart';
import '../../routes/routes.dart';
import 'package:pinput/pinput.dart';

import '../../theme/app_colors.dart';
import '../loading_screen.dart';

class ImportExternalFundsVerifyOtpScreen extends StatefulWidget {
  const ImportExternalFundsVerifyOtpScreen({
    super.key,
    required this.userId,
    required this.phoneNumber,
    required this.panNumber,
    required this.transactionId,
  });

  final int userId;
  final String phoneNumber;
  final String panNumber;
  final String transactionId;

  @override
  State<ImportExternalFundsVerifyOtpScreen> createState() =>
      _ImportExternalFundsVerifyOtpScreenState();
}

class _ImportExternalFundsVerifyOtpScreenState
    extends State<ImportExternalFundsVerifyOtpScreen> {
  bool _isVerifyBtnEnabled = false;

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.mainBlack,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'OTP',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.mainBlack,
                  ),
                ),
                const Gap(2),
                const Text(
                  'Please enter the OTP sent to your mobile number',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
                const Gap(12),
                Pinput(
                  controller: _otpController,
                  onChanged: (value) {
                    setState(() {
                      _isVerifyBtnEnabled = value.length == 6;
                    });
                  },
                  length: 6,
                  separator: const Gap(16),
                  defaultPinTheme: PinTheme(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Spacer(),
                BlocListener<TransactionCubit, TransactionState>(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _isVerifyBtnEnabled
                          ? () async {
                              await context
                                  .read<TransactionCubit>()
                                  .validateTransaction(
                                    transactionID: widget.transactionId,
                                    panNumber: widget.panNumber,
                                    phoneNumber: widget.phoneNumber,
                                    userId: widget.userId,
                                    otp: _otpController.text,
                                  );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(214, 50),
                        maximumSize: const Size(214, 50),
                      ),
                      child: const Text('Verify'),
                    ),
                  ),
                  listener: (BuildContext context, Object? state) {
                    if (state is TransactionError) {
                      Utils.showErrorAlert(
                        context,
                        Utils.getErrorMessage(
                          errorType: state.appErrorType,
                          msg: state.errorMessage,
                        ),
                      );

                      return;
                    }

                    if (state is TransactionValidated) {
                      Navigator.of(context).pushReplacementNamed(
                        Routes.importFundSuccess,
                      );
                    }
                  },
                ),
                const Gap(16),
                const Center(
                  child: Text(
                    'Haven’t received the OTP yet?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
                const Gap(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Click here to ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<TransactionCubit>()
                            .initailiseImportTransaction(
                              userId: widget.userId,
                              panNumber: widget.panNumber,
                              phoneNumber: widget.phoneNumber,
                            );
                      },
                      child: const Text(
                        'Resend.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
