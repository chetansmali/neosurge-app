import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/common.dart';
import '../../../di/get_it.dart';
import '../../cubits/lamf/lamf_pledged_funds/lamf_pledged_funds_cubit.dart';
import '../../widgets/widgets.dart';
import 'loan_closure_screen.dart';
import 'widgets/transaction_widgets.dart';

class PledgedMFsScreen extends StatelessWidget {
  const PledgedMFsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LamfPledgedFundsCubit>()..lamfGetPledgedFunds(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pledged MFs')),
        body: BlocBuilder<LamfPledgedFundsCubit, LamfPledgedFundsState>(
          builder: (context, state) {
            if (state is LamfPledgedFundsLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is LamfPledgedFundsFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () =>
                    context.read<LamfPledgedFundsCubit>().lamfGetPledgedFunds(),
              );
            }
            if (state is LamfPledgedFundsSuccess) {
              final pledgedFundsData = state.getPledgedFundsDetails;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < pledgedFundsData.pledgedHoldings.length;
                          i++)
                        pledgedMF(pledgedFundsData.pledgedHoldings[i].scripName,
                            pledgedFundsData.pledgedHoldings[i].creditLimit),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar:
            BlocBuilder<LamfPledgedFundsCubit, LamfPledgedFundsState>(
          builder: (context, state) {
            if (state is LamfPledgedFundsSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoanClosureScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            style: baseTextStyle14400.copyWith(
                                color: Colors.black),
                            children: const [
                              TextSpan(
                                text: 'Looking to close the loan? ',
                              ),
                              TextSpan(
                                text: 'Close now',
                                style: TextStyle(
                                    color: Color(
                                        0xFF2E8EFF)), // Specific style for 'Close now'
                              ),
                            ],
                          ),
                        ),
                      ),
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
