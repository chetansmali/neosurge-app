import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../theme/app_theme.dart';
import 'widgets/circular_count_indicator.dart';
import 'widgets/loan_object_card.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../cubits/lamf/get_lamf_landing_page/get_lamf_landing_page_cubit.dart';
import '../../theme/app_colors.dart';
import 'widgets/cibil_score_indicator.dart';
import 'widgets/lamf_core_data_container.dart';
import '../../../common/custom_styles.dart';
import '../../widgets/app_error_widget.dart';

class OtherLoansScreen extends StatefulWidget {
  const OtherLoansScreen({Key? key}) : super(key: key);

  @override
  State<OtherLoansScreen> createState() => _OtherLoansScreenState();
}

class _OtherLoansScreenState extends State<OtherLoansScreen> {
  bool secButtonSelected = true;
  bool isSecuredSelected = true;
  final ScrollController _scrollController = ScrollController();
  String _isSecured = 'secured';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLamfLandingPageCubit, GetLamfLandingPageState>(
      builder: (context, state) {
        if (state is GetLamfLandingPageLoading) {
          return const Center(
            child:
                CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
          );
        }
        if (state is GetLamfLandingPageFailure) {
          return AppErrorWidget(
              errorType: state.appErrorType,
              error: state.errorMessage,
              onRetry: () =>
                  context.read<GetLamfLandingPageCubit>().getLAMFLandingPage());
        }
        if (state is GetLamfLandingPageSuccess) {
          final landingPageData = state.getImportLandingPageResponse;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const Gap(30),
                      if (landingPageData.cibilScore != null)
                        CIBILScoreIndicator(
                          score: (landingPageData.cibilScore!.toDouble()),
                        ),
                      if (landingPageData.cibilScore != null) const Gap(12),
                      if (landingPageData.refreshAvailable ?? false)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: AppColors.primary[50],
                            border: Border.all(
                                color: AppColors.primary[100]!, width: 1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CIBIL Score has not been refreshed for over 30 days',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.error[500]),
                              ),
                              InkWell(
                                onTap: () => context
                                    .read<GetLamfLandingPageCubit>()
                                    .getCibilRefresh(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6.0, right: 6.0, left: 6.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Refresh now',
                                        style: baseTextStyle12500.copyWith(
                                            color: AppColors.primary[500]),
                                      ),
                                      const Gap(8),
                                      Icon(
                                        Icons.sync_rounded,
                                        size: 18,
                                        color: AppColors.primary[500],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: LAMFCoreDataContainer(
                                  title: 'Loan Sanctioned',
                                  amount: landingPageData.loanSanctioned ?? 0,
                                  color: AppColors.success[500]!,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: LAMFCoreDataContainer(
                                  title: 'Amount Pending',
                                  amount: landingPageData.amountPending ?? 0,
                                  color: AppColors.error[500]!,
                                ),
                              )
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Expanded(
                                child: LAMFCoreDataContainer(
                                  title: 'Total EMI',
                                  amount: landingPageData.totalEMI ?? 0,
                                  color: AppColors.primary[900]!,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: LAMFCoreDataContainer(
                                  title: 'Active Loans',
                                  data: landingPageData.activeLoans.toString(),
                                  color: AppColors.primary[900]!,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Gap(24),
                    ],
                  ),
                ),
              ),
              SliverPinnedHeader(
                child: Container(
                  color: AppTheme.lightTheme(context).scaffoldBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSecured = 'secured';
                          });
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 36,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: _isSecured == 'secured'
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : Colors.white70,
                            border: Border.all(
                              width: _isSecured == 'secured' ? 1.5 : 1,
                              color: _isSecured == 'secured'
                                  ? AppColors.primaryColor
                                  : AppColors.borderColorGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Secured',
                                style: baseTextStyle12400.copyWith(
                                    color: _isSecured == 'secured'
                                        ? AppColors.primaryColor
                                        : AppColors.textGrey),
                              ),
                              const Gap(10),
                              CircularCountIndicator(
                                data: landingPageData.loans?.secured?.active !=
                                        null
                                    ? (landingPageData.loans!.secured!.active!
                                                .length +
                                            landingPageData
                                                .loans!.secured!.closed!.length)
                                        .toString()
                                    : '0',
                                bgColor:
                                    AppColors.primaryColor.withOpacity(0.3),
                                fgColor: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSecured = 'unsecured';
                          });
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 36,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: _isSecured == 'unsecured'
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : Colors.white70,
                            border: Border.all(
                              width: _isSecured == 'unsecured' ? 1.5 : 1,
                              color: _isSecured == 'unsecured'
                                  ? AppColors.primaryColor
                                  : AppColors.lightGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'unsecured',
                                style: baseTextStyle12400.copyWith(
                                    color: _isSecured == 'unsecured'
                                        ? AppColors.primaryColor
                                        : AppColors.textGrey),
                              ),
                              const Gap(10),
                              CircularCountIndicator(
                                data:
                                    landingPageData.loans?.unsecured?.active !=
                                            null
                                        ? (landingPageData.loans!.unsecured!
                                                    .active!.length +
                                                landingPageData.loans!
                                                    .unsecured!.closed!.length)
                                            .toString()
                                        : '0',
                                bgColor:
                                    AppColors.primaryColor.withOpacity(0.3),
                                fgColor: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return landingPageData.loans!.secured == null ||
                            landingPageData.loans!.unsecured == null
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(
                              child: Text('No loans found'),
                            ),
                          )
                        : OthersLoanCustomListView(
                            loans: _isSecured == 'secured'
                                ? landingPageData.loans!.secured!
                                : landingPageData.loans!.unsecured!);
                  },
                  childCount: 1,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class OthersLoanCustomListView extends StatelessWidget {
  const OthersLoanCustomListView({required this.loans});
  final LAMFSecUnsecLoanObjectModel loans;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: loans.active!.isEmpty && loans.closed!.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text('No loans found'),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Active Loans',
                        style: baseTextStyle16400.copyWith(
                            color: const Color(0XFF9EA0A3))),
                    const Gap(8),
                    CircularCountIndicator(
                      data: (loans.active!.length).toString(),
                      bgColor: AppColors.error[50]!,
                      fgColor: AppColors.error[500]!,
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: loans.active!.length,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return LoanObjectCard(
                      accountID: loans.active![index].accountID!,
                      title: loans.active![index].loanType!,
                      cardNumber: loans.active![index].accountNumber!.substring(
                        loans.active![index].accountNumber!.length - 6,
                        loans.active![index].accountNumber!.length,
                      ),
                      bankName: loans.active![index].provider!,
                      status: "Active",
                      statusTextColor: AppColors.success[500]!,
                    );
                  },
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Closed Loans',
                        style: baseTextStyle16400.copyWith(
                            color: const Color(0XFF9EA0A3))),
                    const Gap(8),
                    CircularCountIndicator(
                      data: 4.toString(),
                      bgColor: AppColors.success[50]!,
                      fgColor: AppColors.success[500]!,
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: loans.closed!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LoanObjectCard(
                      accountID: loans.closed![index].accountID!,
                      title: loans.closed![index].loanType!,
                      cardNumber: loans.closed![index].accountNumber!.substring(
                        loans.closed![index].accountNumber!.length - 6,
                        loans.closed![index].accountNumber!.length,
                      ),
                      bankName: loans.closed![index].provider!,
                      status: "Closed",
                      statusTextColor: AppColors.darkOrange,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
