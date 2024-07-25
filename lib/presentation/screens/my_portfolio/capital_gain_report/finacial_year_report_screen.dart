import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class FinacialYearReportScreen extends StatefulWidget {
  const FinacialYearReportScreen({super.key});

  @override
  State<FinacialYearReportScreen> createState() =>
      _FinacialYearReportScreenState();
}

class _FinacialYearReportScreenState extends State<FinacialYearReportScreen> {
  CapitalGainsReportSortType _capitalGainsReportSortType =
      CapitalGainsReportSortType.FY2023FY2024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capital Gains Report',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose Financial Year',
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.textGrey),
                  ),
                ),
                const Gap(16),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _capitalGainsReportSortType =
                          CapitalGainsReportSortType.FY2023FY2024;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      backgroundColor: _capitalGainsReportSortType ==
                              CapitalGainsReportSortType.FY2023FY2024
                          ? AppColors.mainBlack
                          : Colors.white,
                      maximumSize: const Size(335, 42),
                      minimumSize: const Size(335, 42),
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                      )),
                  child: Text(
                    'FY 2023 - FY 2024',
                    style: baseTextStyle12500.copyWith(
                        color: _capitalGainsReportSortType ==
                                CapitalGainsReportSortType.FY2023FY2024
                            ? AppColors.primaryWhite
                            : AppColors.textGrey),
                  ),
                ),
                const Gap(12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _capitalGainsReportSortType =
                          CapitalGainsReportSortType.FY2022FY2023;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      maximumSize: const Size(335, 42),
                      minimumSize: const Size(335, 42),
                      backgroundColor: _capitalGainsReportSortType ==
                              CapitalGainsReportSortType.FY2022FY2023
                          ? AppColors.mainBlack
                          : Colors.white,
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                      )),
                  child: Text(
                    'FY 2022 - FY 2023',
                    style: baseTextStyle12500.copyWith(
                        color: _capitalGainsReportSortType ==
                                CapitalGainsReportSortType.FY2022FY2023
                            ? AppColors.primaryWhite
                            : AppColors.textGrey),
                  ),
                ),
                const Gap(12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _capitalGainsReportSortType =
                          CapitalGainsReportSortType.FY2021FY2022;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      maximumSize: const Size(335, 42),
                      minimumSize: const Size(335, 42),
                      backgroundColor: _capitalGainsReportSortType ==
                              CapitalGainsReportSortType.FY2021FY2022
                          ? AppColors.mainBlack
                          : Colors.white,
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                      )),
                  child: Text(
                    'FY 2021 - FY 2022',
                    style: baseTextStyle12500.copyWith(
                        color: _capitalGainsReportSortType ==
                                CapitalGainsReportSortType.FY2021FY2022
                            ? AppColors.primaryWhite
                            : AppColors.textGrey),
                  ),
                ),
                const Gap(12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _capitalGainsReportSortType =
                          CapitalGainsReportSortType.FY2020FY2021;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      maximumSize: const Size(335, 42),
                      minimumSize: const Size(335, 42),
                      backgroundColor: _capitalGainsReportSortType ==
                              CapitalGainsReportSortType.FY2020FY2021
                          ? AppColors.mainBlack
                          : Colors.white,
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                      )),
                  child: Text(
                    'FY 2020 - FY 2021',
                    style: baseTextStyle12500.copyWith(
                        color: _capitalGainsReportSortType ==
                                CapitalGainsReportSortType.FY2020FY2021
                            ? AppColors.primaryWhite
                            : AppColors.textGrey),
                  ),
                ),
                const Gap(12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _capitalGainsReportSortType =
                          CapitalGainsReportSortType.FY2019FY2020;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      maximumSize: const Size(335, 42),
                      minimumSize: const Size(335, 42),
                      backgroundColor: _capitalGainsReportSortType ==
                              CapitalGainsReportSortType.FY2019FY2020
                          ? AppColors.mainBlack
                          : Colors.white,
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                      )),
                  child: Text(
                    'FY 2019 - FY 2020',
                    style: baseTextStyle12500.copyWith(
                        color: _capitalGainsReportSortType ==
                                CapitalGainsReportSortType.FY2019FY2020
                            ? AppColors.primaryWhite
                            : AppColors.textGrey),
                  ),
                ),
                const Gap(12),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.capitalGainDetails,
                    arguments: CapitalGainReportArgs(
                      financialYear:
                          _capitalGainsReportSortType.name.toString(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(335, 56),
                  minimumSize: const Size(335, 56),
                ),
                child: Text(
                  'Confirm',
                  style: baseTextStyle16500.copyWith(
                      color: AppColors.primaryWhite),
                )),
          ],
        ),
      ),
    );
  }
}
