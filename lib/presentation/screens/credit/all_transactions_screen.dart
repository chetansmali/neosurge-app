import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/get_it.dart';
import '../../cubits/lamf/lamf_get_loan_data/lamf_get_loan_data_cubit.dart';
import '../../widgets/app_error_widget.dart';
import 'widgets/transaction_widgets.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return getIt<LamfGetLoanDataCubit>()..lamfGetLoanData();
        },
        child: BlocBuilder<LamfGetLoanDataCubit, LamfGetLoanDataState>(
          builder: (context, state) {
            if (state is LamfGetLoanDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LamfGetLoanDataFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () =>
                    context.read<LamfGetLoanDataCubit>().lamfGetLoanData(),
              );
            }
            if (state is LamfGetLoanDataSuccess) {
              final lamfLoanData = state.getLoanDataDetails;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      for (int i = 0; i < lamfLoanData.transactions.length; i++)
                        lamfLoanData.transactions[i].amount < 0
                            ? negativeTransaction(
                                lamfLoanData.transactions[i].description,
                                lamfLoanData.transactions[i].date,
                                lamfLoanData.transactions[i].amount)
                            : positiveTransaction(
                                lamfLoanData.transactions[i].description,
                                lamfLoanData.transactions[i].date,
                                lamfLoanData.transactions[i].amount),
                    ],
                  ),
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
