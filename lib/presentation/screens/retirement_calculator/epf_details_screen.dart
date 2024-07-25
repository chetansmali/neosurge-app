import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../common/custom_styles.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_passbook_params.dart';
import '../../cubits/retirement_calculator/retirement_passbook_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_container.dart';

class EPFDetailsScreen extends StatefulWidget {
  final String requestId;
  const EPFDetailsScreen({super.key, required this.requestId});

  @override
  State<EPFDetailsScreen> createState() => _EPFDetailsScreenState();
}

class _EPFDetailsScreenState extends State<EPFDetailsScreen> {
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
      body: BlocBuilder<RetirementPassbookCubit, RetirementPassbookState>(
        builder: (context, state) {
          if (state is RetirementPassbookLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is RetirementPassbookFailure) {
            return Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () => context.read<RetirementPassbookCubit>()
                  ..fetchEPFReport(RetirementPassbookParams(
                      requestId: widget.requestId, refreshNeeded: 'false')),
              ),
            );
          }
          if (state is RetirementPassbookLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Current Value',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.primaryWhite),
                              ),
                              Text(
                                'UAN: ${state.retirementPassbookModel.uan}',
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
                                amount: state.retirementPassbookModel.totalValue
                                        ?.toDouble() ??
                                    0,
                                isCompact: false,
                                style: baseTextStyle16500.copyWith(
                                    color: AppColors.primaryWhite),
                              ),
                              Text(
                                state.retirementPassbookModel.fullName ?? '',
                                style: baseTextStyle10600.copyWith(
                                    color: AppColors.primaryWhite),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Employers',
                    style: baseTextStyle16500.copyWith(
                        color: AppColors.textLightGrey),
                  ),
                  const Gap(16),
                  Text(
                    'Current Employer',
                    style:
                        baseTextStyle10400.copyWith(color: AppColors.textGrey),
                  ),
                  const Gap(4),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.retirementEPFTransactionDetails,
                        arguments: RetirementEPFTransactionDetailsArgs(
                            company:
                                state.retirementPassbookModel.companies![0],
                            name: state.retirementPassbookModel.fullName ?? '',
                            uan: state.retirementPassbookModel.uan ?? ''),
                      );
                    },
                    child: CustomContainer(
                      radius: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.retirementPassbookModel
                                          .currentCompany ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: baseTextStyle14500.copyWith(
                                      color: AppColors.textLightGrey),
                                ),
                              ),
                              AmountWidget(
                                amount: totalEPF(state, 0),
                                isCompact: false,
                                style: baseTextStyle16500.copyWith(
                                    color: AppColors.green),
                              ),
                            ],
                          ),
                          Text(
                            '${state.retirementPassbookModel.companies?[0].passbook[0].month} / ${state.retirementPassbookModel.companies?[0].passbook[0].year} - Present',
                            style: baseTextStyle10400.copyWith(
                                color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                  Text(
                    'Previous employers',
                    style:
                        baseTextStyle10400.copyWith(color: AppColors.textGrey),
                  ),
                  const Gap(4),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          state.retirementPassbookModel.companies?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.retirementEPFTransactionDetails,
                              arguments: RetirementEPFTransactionDetailsArgs(
                                  company: state.retirementPassbookModel
                                      .companies![index],
                                  name:
                                      state.retirementPassbookModel.fullName ??
                                          '',
                                  uan: state.retirementPassbookModel.uan ?? ''),
                            );
                          },
                          child: CustomContainer(
                            radius: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.retirementPassbookModel
                                                .companies?[0].companyName ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        style: baseTextStyle14500.copyWith(
                                            color: AppColors.textLightGrey),
                                      ),
                                    ),
                                    AmountWidget(
                                      amount: totalEPF(state, index),
                                      isCompact: false,
                                      style: baseTextStyle16500.copyWith(
                                          color: AppColors.green),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${state.retirementPassbookModel.companies?[index].passbook[0].month} / ${state.retirementPassbookModel.companies?[index].passbook[0].year}',
                                  style: baseTextStyle10400.copyWith(
                                      color: AppColors.textGrey),
                                ),
                              ],
                            ),
                          ),
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

  double totalEPF(RetirementPassbookLoaded state, int index) {
    double preemployeeShare =
        state.retirementPassbookModel.companies?[index].employeeTotal ?? 0.0;
    double preemployerShare =
        state.retirementPassbookModel.companies?[index].employerTotal ?? 0.0;
    double prepensionShare =
        state.retirementPassbookModel.companies?[index].pensionTotal ?? 0.0;
    double previousTotal =
        preemployeeShare + preemployerShare + prepensionShare;
    return previousTotal;
  }
}
