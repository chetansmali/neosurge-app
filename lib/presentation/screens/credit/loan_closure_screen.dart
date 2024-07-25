import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/lamf_banner.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../../../common/custom_styles.dart';
import '../../../di/get_it.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/lamf/lamf_avail_loans/lamf_avail_loan_cubit.dart';
import '../../cubits/lamf/lamf_loan_closure/lamf_loan_closure_cubit.dart';
import '../../widgets/app_error_widget.dart';
import 'loan_closure_req_submitted.dart';
import 'widgets/loan_closure_widgets.dart';

enum LoanCloserStatus { grey, yellow, green }

class LoanClosureScreen extends StatelessWidget {
  const LoanClosureScreen({Key? key}) : super(key: key);
  void configSDK() async {
    try {
      const config = ScLoanConfig(ScLoanEnvironment.PRODUCTION, 'bullsurge');
      await ScLoan.setup(config);
    } on ScLoanError {
      rethrow;
    }
  }

  void callRepaySDK(String token) async {
    configSDK();
    try {
      final loanInfo = ScLoanInfo(token);
      await ScLoan.pay(loanInfo);
    } on ScLoanError {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan closure')),
      body: BlocProvider(
        create: (context) => getIt<LamfLoanClosureCubit>()..lamfLoanClosure(),
        child: BlocBuilder<LamfLoanClosureCubit, LamfLoanClosureState>(
          builder: (context, state) {
            if (state is LamfLoanClosureLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LamfLoanClosureFailure) {
              return Center(
                child: AppErrorWidget(
                  errorType: state.errorType,
                  error: state.errorMessage,
                  onRetry: () =>
                      context.read<LamfLoanClosureCubit>().lamfLoanClosure(),
                ),
              );
            }
            if (state is LamfLoanClosureSuccess) {
              final loanCloser = state.loanClosureDetails;
              LoanCloserStatus loanCloserStatus = LoanCloserStatus.grey;

              if (loanCloser.amount == 0 &&
                  loanCloser.message == '' &&
                  loanCloser.status == 'SUCCESS') {
                //SCREEN 4
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoanClosureReqSubmitted()));
              } else if (loanCloser.status == 'FAILED') {
                loanCloserStatus = LoanCloserStatus.grey;
              } else if (loanCloser.message == 'PENDING') {
                loanCloserStatus = LoanCloserStatus.green;
              } else {
                loanCloserStatus = LoanCloserStatus.grey;
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LamfBanner(
                      title: 'Outstanding loan amount',
                      value: loanCloser.amount.toDouble(),
                      small: false,
                    ),
                    const Gap(24),
                    Center(
                      child: BlocProvider(
                        create: (context) => getIt<LamfAvailLoanCubit>(),
                        child:
                            BlocBuilder<LamfAvailLoanCubit, LamfAvailLoanState>(
                          builder: (context, state) {
                            if (state is LamfAvailLoanSuccess) {
                              final availLoanUser = state.availLoanDetails;
                              callRepaySDK(availLoanUser.interactionToken);
                              return SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      context
                                          .read<LamfAvailLoanCubit>()
                                          .availLoans();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.pngs.repay.path.toString(),
                                          height: 24,
                                          width: 24,
                                        ),
                                        const Gap(8.0),
                                        Text('Repay',
                                            style: baseTextStyle14500.copyWith(
                                                color: Colors.white))
                                      ],
                                    )),
                              );
                            }
                            return SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    context
                                        .read<LamfAvailLoanCubit>()
                                        .availLoans();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.pngs.repay.path.toString(),
                                        height: 24,
                                        width: 24,
                                      ),
                                      const Gap(8.0),
                                      Text('Repay',
                                          style: baseTextStyle14500.copyWith(
                                              color: Colors.white))
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    const Gap(40),
                    Text(
                      'Loan closure status',
                      style: baseTextStyle14500,
                    ),
                    const Gap(30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        selectImageAsset(loanCloserStatus),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              loanCloserStatusBanner(
                                  context,
                                  'Repay outstanding loan amount. This will take about 2-3 hrs to complete.',
                                  loanCloserStatus),
                              const Gap(24),
                              loanCloserStatusBannerConfirm(
                                  context,
                                  'Your pledged mutual funds will be released within the next 3 days.',
                                  loanCloserStatus)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
