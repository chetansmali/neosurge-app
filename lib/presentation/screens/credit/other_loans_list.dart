import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/custom_styles.dart';
import '../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../theme/app_colors.dart';
import 'widgets/circular_count_indicator.dart';
import 'widgets/loan_object_card.dart';

class OtherLoansListWidget extends StatefulWidget {
  const OtherLoansListWidget({
    super.key,
    required this.loans,
  });
  final LAMFLoanListModel loans;

  @override
  State<OtherLoansListWidget> createState() => _OtherLoansListWidgetState();
}

class _OtherLoansListWidgetState extends State<OtherLoansListWidget> {
  bool isSecuredSelected = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Loan Details', style: baseTextStyle18500),
          ),
          const Gap(10),
          TabBar(
            splashFactory: NoSplash.splashFactory,
            splashBorderRadius: BorderRadius.circular(100),
            onTap: (value) => setState(() => isSecuredSelected = value == 0),
            labelColor: AppColors.primary[500],
            unselectedLabelColor: AppColors.neutral[200],
            indicatorColor: Colors.transparent,
            dividerHeight: 0.0,
            tabs: [
              Tab(
                child: _LoanSecUnsecButton(
                  title: 'Secured',
                  data: widget.loans.secured?.active != null
                      ? (widget.loans.secured!.active!.length +
                              widget.loans.secured!.closed!.length)
                          .toString()
                      : '0',
                  isSelected: isSecuredSelected,
                ),
              ),
              Tab(
                child: _LoanSecUnsecButton(
                  title: 'Unsecured',
                  data: widget.loans.unsecured?.active != null
                      ? (widget.loans.unsecured!.active!.length +
                              widget.loans.unsecured!.closed!.length)
                          .toString()
                      : '0',
                  isSelected: !isSecuredSelected,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                (widget.loans.secured != null)
                    ? _OtherLoanListView(loans: widget.loans.secured!)
                    : const Center(child: Text('No loans found')),
                (widget.loans.unsecured != null)
                    ? _OtherLoanListView(loans: widget.loans.unsecured!)
                    : const Center(child: Text('No loans found')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtherLoanListView extends StatelessWidget {
  const _OtherLoanListView({required this.loans});
  final LAMFSecUnsecLoanObjectModel loans;

  @override
  Widget build(BuildContext context) {
    if (loans.active!.isEmpty && loans.closed!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text('No loans found'),
        ),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        clipBehavior: Clip.none,
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (loans.active!.isNotEmpty) const Gap(24),
            if (loans.active!.isNotEmpty)
              Column(
                children: [
                  if (loans.active!.isNotEmpty) const Gap(10),
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
                  if (loans.active!.isNotEmpty) const Gap(16),
                  if (loans.active!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LoanObjectCard(
                          accountID: 'loans.active![index].accountID!',
                          title: 'loans.active![index].loanType!',
                          cardNumber:
                              loans.active![index].accountNumber!.substring(
                            loans.active![index].accountNumber!.length - 6,
                            loans.active![index].accountNumber!.length,
                          ),
                          bankName: 'loans.active![index].provider!',
                          status: "Active",
                          statusTextColor: AppColors.success[500]!,
                        ),
                      ),
                    ),
                ],
              ),
            if (loans.closed!.isNotEmpty) const Gap(24),
            if (loans.closed!.isNotEmpty)
              Column(
                children: [
                  if (loans.closed!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Closed Loans',
                            style: baseTextStyle16400.copyWith(
                                color: const Color(0XFF9EA0A3))),
                        const Gap(8),
                        CircularCountIndicator(
                          data: (loans.closed!.length).toString(),
                          bgColor: AppColors.success[50]!,
                          fgColor: AppColors.success[500]!,
                        ),
                      ],
                    ),
                  if (loans.closed!.isNotEmpty) const Gap(16),
                  if (loans.closed!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: loans.closed!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LoanObjectCard(
                          accountID: loans.closed![index].accountID!,
                          title: loans.closed![index].loanType!,
                          cardNumber:
                              loans.closed![index].accountNumber!.substring(
                            loans.closed![index].accountNumber!.length - 6,
                            loans.closed![index].accountNumber!.length,
                          ),
                          bankName: loans.closed![index].provider!,
                          status: "Closed",
                          statusTextColor: AppColors.darkOrange,
                        ),
                      ),
                    ),
                ],
              ),
            const Gap(24),
          ],
        ),
      );
    }
  }
}

class _LoanSecUnsecButton extends StatelessWidget {
  final String title, data;
  final bool isSelected;
  const _LoanSecUnsecButton({
    required this.title,
    required this.data,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? AppColors.primary[50] : null,
        border: Border.all(
            color:
                isSelected ? AppColors.primary[500]! : AppColors.neutral[100]!,
            width: isSelected ? 1.5 : 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: baseTextStyle12500.copyWith(
                    color: isSelected
                        ? AppColors.primary[500]
                        : AppColors.neutral[100]),
              ),
              const Gap(10),
              CircularCountIndicator(
                data: data,
                bgColor: AppColors.primary[100]!,
                fgColor: AppColors.primary[500]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// return SingleChildScrollView(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// clipBehavior: Clip.none,
// primary: false,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// if (loans.active!.isNotEmpty) const Gap(24),
// if (loans.active!.isNotEmpty)
// Column(
// children: [
// if (loans.active!.isNotEmpty)
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text('Active Loans',
// style: baseTextStyle16400.copyWith(
// color: const Color(0XFF9EA0A3))),
// const Gap(8),
// CircularCountIndicator(
// data: (loans.active!.length).toString(),
// bgColor: AppColors.error[50]!,
// fgColor: AppColors.error[500]!,
// ),
// ],
// ),
// if (loans.active!.isNotEmpty) const Gap(16),
// if (loans.active!.isNotEmpty)
// ListView.builder(
// shrinkWrap: true,
// itemCount: loans.active!.length,
// itemBuilder: (context, index) => Padding(
// padding: const EdgeInsets.only(bottom: 12.0),
// child: LoanObjectCard(
// accountID: loans.active![index].accountID!,
// title: loans.active![index].loanType!,
// cardNumber:
// loans.active![index].accountNumber!.substring(
// loans.active![index].accountNumber!.length - 6,
// loans.active![index].accountNumber!.length,
// ),
// bankName: loans.active![index].provider!,
// status: "Active",
// statusTextColor: AppColors.success[500]!,
// ),
// ),
// ),
// ],
// ),
// if (loans.closed!.isNotEmpty) const Gap(24),
// if (loans.closed!.isNotEmpty)
// Column(
// children: [
// if (loans.closed!.isNotEmpty)
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text('Closed Loans',
// style: baseTextStyle16400.copyWith(
// color: const Color(0XFF9EA0A3))),
// const Gap(8),
// CircularCountIndicator(
// data: (loans.closed!.length).toString(),
// bgColor: AppColors.success[50]!,
// fgColor: AppColors.success[500]!,
// ),
// ],
// ),
// if (loans.closed!.isNotEmpty) const Gap(16),
// if (loans.closed!.isNotEmpty)
// ListView.builder(
// shrinkWrap: true,
// itemCount: loans.closed!.length,
// itemBuilder: (context, index) => Padding(
// padding: const EdgeInsets.only(bottom: 12.0),
// child: LoanObjectCard(
// accountID: loans.closed![index].accountID!,
// title: loans.closed![index].loanType!,
// cardNumber:
// loans.closed![index].accountNumber!.substring(
// loans.closed![index].accountNumber!.length - 6,
// loans.closed![index].accountNumber!.length,
// ),
// bankName: loans.closed![index].provider!,
// status: "Closed",
// statusTextColor: AppColors.darkOrange,
// ),
// ),
// ),
// ],
// ),
// const Gap(24),
// ],
// ),
// );
