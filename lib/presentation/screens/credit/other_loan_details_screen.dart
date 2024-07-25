import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../data/models/lamf/get_loan_data_response.dart';
import '../../../domain/entities/params/lamf/get_loan_data_params.dart';
import '../../cubits/lamf/get_loan_data/get_loan_data_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_error_widget.dart';
import 'widgets/loan_detail_expanded_tile.dart';
import 'widgets/loan_detail_paymenthistory_banner.dart';

class OtherLoanDetailsScreen extends StatelessWidget {
  const OtherLoanDetailsScreen({Key? key, required this.accountID})
      : super(key: key);
  final OtherLoanDetailScreenArgs accountID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLoanDataCubit, GetLoanDataState>(
      builder: (context, state) {
        if (state is GetLoanDataLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(
                  strokeCap: StrokeCap.round),
            ),
          );
        }
        if (state is GetLoanDataSuccess) {
          final GetLoanDataResponse loanData = state.getLoanDataResponse;

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      loanData.loanType ?? '--',
                      style: baseTextStyle14500.copyWith(
                          color: AppColors.neutral[500]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: AppColors.lightOrange,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      loanData.isSecured != null
                          ? loanData.isSecured!
                              ? 'Secured'
                              : 'Unsecured'
                          : '--',
                      style: baseTextStyle10600.copyWith(
                          color: AppColors.darkOrange),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColors.primary[50],
                      border:
                          Border.all(color: AppColors.primary[100]!, width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Loan Start Date',
                              style: baseTextStyle12400.copyWith(
                                  color: AppColors.primary[500]),
                            ),
                            Text(
                              loanData.accountNumber ?? '--',
                              style: baseTextStyle12500.copyWith(
                                  color: AppColors.primary[900]),
                            ),
                          ],
                        ),
                        const Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loanData.startDate ?? '--',
                              style: baseTextStyle14500.copyWith(
                                  color: AppColors.primary[900]),
                            ),
                            Text(
                              loanData.lenderName ?? '--',
                              style: baseTextStyle12500.copyWith(
                                  color: AppColors.primary[900]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(18),
                  LoanDetailExpandedTile(
                    tenure: loanData.tenure ?? 0,
                    sanctionedAmt: loanData.sanctionedAmount ?? 0.0,
                    outstandingAmt: loanData.outstanding ?? 0.0,
                    emi: loanData.emi ?? 0.0,
                    interest: loanData.interest ?? 0.0,
                  ),
                  const Gap(18),
                  Text('Payment History',
                      style: baseTextStyle16500.copyWith(
                          color: AppColors.neutral[500])),
                  const Gap(18),
                  LoanDetailPaymentHistoryBanner(
                    totalPayments: loanData.payments?.totalPayments ?? 0,
                    onTimePayments: loanData.payments?.ontimePayments ?? 0,
                    delayedPayments: loanData.payments?.delayedPayments ?? 0,
                  ),
                  const Gap(24),
                ],
              ),
            ),
          );
        }
        if (state is GetLoanDataFailure) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: AppErrorWidget(
                  errorType: state.appErrorType,
                  error: state.errorMessage,
                  onRetry: () => context.read<GetLoanDataCubit>().getLoanData(
                      GetLoanDataParams(accountID: accountID.accountID))),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
