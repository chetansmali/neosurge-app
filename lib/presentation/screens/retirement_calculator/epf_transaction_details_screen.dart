import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/models/retirement_calculator/retirement_passbook_model.dart';
import '../../widgets/custom_container.dart';
import 'widget/retirement_sorting_bottom_sheet.dart';
import '../../../common/custom_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';

class EPFTransactionDetails extends StatefulWidget {
  final Company company;
  final String name;
  final String uan;

  const EPFTransactionDetails(
      {super.key,
      required this.company,
      required this.name,
      required this.uan});

  @override
  State<EPFTransactionDetails> createState() => _EPFTransactionDetailsState();
}

class _EPFTransactionDetailsState extends State<EPFTransactionDetails> {
  String _isEmployee = 'Employee';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EPF Details',
          style: baseTextStyle16500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF133C6B), Color(0xFF09213d)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Value',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.primaryWhite),
                        ),
                        Text(
                          'UAN: ${widget.uan}',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.primaryWhite),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AmountWidget(
                          amount: maintotal(),
                          isCompact: false,
                          style: baseTextStyle16500.copyWith(
                              color: AppColors.primaryWhite),
                        ),
                        Text(
                          widget.name,
                          style: baseTextStyle10600.copyWith(
                              color: AppColors.primaryWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            CustomContainer(
              radius: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EPF Contribution',
                    style: baseTextStyle12500,
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: AppColors.lightOrange.withOpacity(0.2)),
                        child: Center(
                          child: Text(
                            'Employer: ₹${widget.company.employerTotal}',
                            style: baseTextStyle12500.copyWith(
                                color: AppColors.darkOrange),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: AppColors.lightOrange.withOpacity(0.5)),
                        child: Center(
                          child: Text(
                            'Employee: ₹${widget.company.employeeTotal}',
                            style: baseTextStyle12500.copyWith(
                                color: AppColors.darkOrange),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: baseTextStyle16500,
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext _) {
                        return const RetirementSortBottomSheet();
                      },
                    );
                  },
                  icon: const Icon(Icons.sort_rounded),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isEmployee = 'Employee';
                    });
                  },
                  child: Container(
                    height: 42,
                    width: 86,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: _isEmployee == 'Employee'
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        'Employee',
                        style: baseTextStyle14400.copyWith(
                            color: _isEmployee == 'Employee'
                                ? AppColors.primaryColor
                                : AppColors.textGrey),
                      ),
                    ),
                  ),
                ),
                const Gap(21),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isEmployee = 'Employer';
                    });
                  },
                  child: Container(
                    height: 42,
                    width: 86,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: _isEmployee == 'Employer'
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        'Employer',
                        style: baseTextStyle14400.copyWith(
                            color: _isEmployee == 'Employer'
                                ? AppColors.primaryColor
                                : AppColors.textGrey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(22),
            Expanded(
              child: ListView.builder(
                itemCount: widget.company.passbook.length,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    radius: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.green.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Assets.svgs.retirementTransactionDetails
                                    .svg(height: 20, width: 20),
                              ),
                            ),
                            const Gap(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.company.passbook[index].description ??
                                      '',
                                  style: baseTextStyle12500.copyWith(
                                      color: AppColors.textLightGrey),
                                ),
                                Text(
                                  '${widget.company.passbook[index].month} / ${widget.company.passbook[index].year}',
                                  style: baseTextStyle12400.copyWith(
                                      color: AppColors.textGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        AmountWidget(
                          amount: _isEmployee == 'Employer'
                              ? widget.company.passbook[index].employerShare
                                      ?.toDouble() ??
                                  0
                              : widget.company.passbook[index].employeeShare
                                      ?.toDouble() ??
                                  0,
                          isCompact: false,
                          style: baseTextStyle14500,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double maintotal() {
    double employeetotal = widget.company.employeeTotal?.toDouble() ?? 0;
    double employerTotal = widget.company.employerTotal?.toDouble() ?? 0;
    double pensionTotal = widget.company.pensionTotal?.toDouble() ?? 0;
    double maintotal = employerTotal + pensionTotal + employeetotal;
    return maintotal;
  }
}
