import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../common/common.dart';
import '../../../../domain/entities/params/mutual_funds/capital_gain_report_params.dart';
import '../../../../domain/entities/params/mutual_funds/generate_capital_gain_file.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/mutual_funds/Capital_gain_report/generate_capital_gains_file_cubit.dart';
import '../../../cubits/mutual_funds/Capital_gain_report/get_capital_gain_report_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import 'capital_gain_portfolio_card.dart';

class CapitalGainDetails extends StatefulWidget {
  final String financialYear;

  const CapitalGainDetails({super.key, required this.financialYear});

  @override
  State<CapitalGainDetails> createState() => _CapitalGainDetailsState();
}

class _CapitalGainDetailsState extends State<CapitalGainDetails> {
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
      body: BlocBuilder<GetCapitalGainReportCubit, GetCapitalGainReportState>(
        builder: (context, state) {
          if (state is GetCapitalGainReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetCapitalGainReportFailure) {
            return AppErrorWidget(
              errorType: state.appErrorType,
              error: state.errorMessage,
              onRetry: () => context.read<GetCapitalGainReportCubit>()
                ..fetchCapitalGainReport(CapitalGainReportParams(
                    financialYear: widget.financialYear)),
            );
          }
          if (state is GetCapitalGainReportLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Showing results for the Financial year',
                            style: baseTextStyle12400.copyWith(
                                color: AppColors.textGrey),
                          ),
                          const Gap(5),
                          Text(
                            state.capitalGainReportModel.financialYear,
                            style: baseTextStyle18500,
                          ),
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          context
                              .read<GenerateCapitalGainsFileCubit>()
                              .fetchCapitalGainFiles(
                                GenerateCapitalGainFileParams(
                                    financialYear: widget.financialYear),
                              );
                        },
                        splashColor: Colors.transparent,
                        child: BlocConsumer<GenerateCapitalGainsFileCubit,
                            GenerateCapitalGainsFileState>(
                          listener: (context, state) {
                            if (state is GenerateCapitalGainsFileSuccess) {
                              Utils.showSuccessAlert(context,
                                  'File has shared successfully to your Email');
                            }
                          },
                          builder: (context, state) {
                            return state is GenerateCapitalGainsFileLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.file_download_outlined,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Text(
                    'Short Term Capital Gains',
                    style:
                        baseTextStyle16500.copyWith(color: AppColors.mainBlack),
                  ),
                  const Gap(16),
                  CapitalGainPortFolioCard(
                      absolutegain: state
                          .capitalGainReportModel.shortTermGains.absoluteGains,
                      capitalgain: state
                          .capitalGainReportModel.shortTermGains.capitalGains,
                      taxablegain: state
                          .capitalGainReportModel.shortTermGains.taxableGains,
                      term: 'Short Term Capital Gains'),
                  const Gap(24),
                  Text(
                    'Long Term Capital Gains',
                    style:
                        baseTextStyle16500.copyWith(color: AppColors.mainBlack),
                  ),
                  const Gap(16),
                  CapitalGainPortFolioCard(
                      absolutegain: state
                          .capitalGainReportModel.longTermGains.absoluteGains,
                      capitalgain: state
                          .capitalGainReportModel.longTermGains.capitalGains,
                      taxablegain: state
                          .capitalGainReportModel.longTermGains.taxableGains,
                      term: 'Long Term Capital Gains'),
                  const Gap(16),
                  Text(
                    'Disclaimer:',
                    style:
                        baseTextStyle14400.copyWith(color: AppColors.mainBlack),
                  ),
                  const Gap(16),
                  Text(
                    '\u2022 The gains/loss report is provided at your request  and should not be considered as the basis for computing your tax liability\n\n \u2022 As required by regulation, NAV as on 31st Jan 2018 is used to calculate LTCG and LTCG Taxes for units\n bought before Jan 2018.\n\n \u2022 You are advised to consult a tax advisor to verify the correctness and appropriateness of this statement and Neosurge will not be liable for determining your tax liability or any loss or damage arising out of any decisions/actions arising out of this statement.',
                    textAlign: TextAlign.left,
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.textGrey),
                  ),
                  const Gap(32),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<GenerateCapitalGainsFileCubit>()
                          .fetchCapitalGainFiles(
                            GenerateCapitalGainFileParams(
                                financialYear: widget.financialYear),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(335, 56),
                      maximumSize: const Size(335, 56),
                    ),
                    child: BlocConsumer<GenerateCapitalGainsFileCubit,
                        GenerateCapitalGainsFileState>(
                      listener: (context, state) {
                        if (state is GenerateCapitalGainsFileSuccess) {
                          Utils.showSuccessAlert(context,
                              'File has been shared to your registered email');
                        }
                      },
                      builder: (context, state) {
                        return state is GenerateCapitalGainsFileLoading
                            ? Assets.animations.loading.lottie()
                            : Text(
                                'Download Report',
                                style: baseTextStyle16500.copyWith(
                                    color: AppColors.primaryWhite),
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
