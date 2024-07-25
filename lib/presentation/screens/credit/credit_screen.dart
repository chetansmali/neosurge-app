import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/common.dart';
import '../../../di/get_it.dart';
import '../../cubits/lamf/lamf_get_user/lamf_get_user_cubit.dart';
import '../../cubits/lamf/get_lamf_landing_page/get_lamf_landing_page_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_error_widget.dart';
import 'other_loans_screen.dart';
import 'lamf_screen.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LamfGetUserCubit>()..lamfGetUser(),
        child: BlocBuilder<LamfGetUserCubit, LamfGetUserState>(
          builder: (context, state) {
            if (state is LamfGetUserLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is LamfGetUserFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () => context.read<LamfGetUserCubit>().lamfGetUser(),
              );
            }
            if (state is LamfGetUserSuccess) {
              final loanUser = state.getLoanUserDetails;

              return loanUser.loansImported != null
                  ? loanUser.loansImported!
                      ? DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: AppBar(
                              toolbarHeight: 0,
                              bottom: TabBar(
                                labelStyle: baseTextStyle12500,
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                labelColor: AppColors.primary[500],
                                unselectedLabelColor: AppColors.neutral[200],
                                indicatorColor: AppColors.primary[500],
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: const [
                                  Tab(text: 'Loan Against Mutual Funds'),
                                  Tab(text: 'Other Loans'),
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                BlocProvider.value(
                                  value: context.read<LamfGetUserCubit>(),
                                  child: LAMFScreen(loanUser: loanUser),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      getIt<GetLamfLandingPageCubit>()
                                        ..getLAMFLandingPage(),
                                  child: const OtherLoansScreen(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Scaffold(
                          body: BlocProvider.value(
                            value: context.read<LamfGetUserCubit>(),
                            child: LAMFScreen(loanUser: loanUser),
                          ),
                        )
                  : Scaffold(
                      body: BlocProvider.value(
                        value: context.read<LamfGetUserCubit>(),
                        child: LAMFScreen(loanUser: loanUser),
                      ),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
