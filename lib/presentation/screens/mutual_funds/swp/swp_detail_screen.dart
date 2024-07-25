import 'package:cached_network_image/cached_network_image.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/mutual_funds/systematic_plan.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/cancel_systematic_plan/cancel_systematic_plan_cubit.dart';
import '../../../cubits/mutual_funds/systematic_plan_installments/systematic_plan_installments_cubit.dart';
import '../../../cubits/mutual_funds/systematic_plans/systematic_plans_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import '../../loading_screen.dart';

class SwpDetailScreen extends StatelessWidget {
  final SystematicPlan swp;

  const SwpDetailScreen({Key? key, required this.swp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: BlocListener<CancelSystematicPlanCubit, CancelSystematicPlanState>(
        listener: (context, state) {
          if (state is CancelSystematicPlanSuccess) {
            Navigator.pushReplacementNamed(context, Routes.cancelSipSuccess);
            context.read<SystematicPlansCubit>().cancelSystematicPlans(swp.id);
          }
          if (state is CancelSystematicPlanError) {
            Fluttertoast.showToast(msg: Utils.getErrorMessage(errorType: state.errorType, msg: state.errorMessage));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Swp Details'),
            actions: [
              if (swp.status == SystematicPlansStatus.activated)
                BlocBuilder<SystematicPlanInstallmentsCubit, SystematicPlanInstallmentsState>(
                  builder: (context, state) {
                    if (state is SystematicPlanInstallmentsLoaded) {
                      return TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text('This will cancel the SWP'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () => Navigator.pop(context, false),
                                        ),
                                        TextButton(
                                          child: const Text('Confirm'),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    )).then((value) {
                              if (value == true) {
                                context.read<CancelSystematicPlanCubit>().cancelSwp(userId: context.read<AuthCubit>().state.user!.id, swpId: swp.id);
                              }
                            });
                          },
                          child: const Text('Cancel SIP'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
            ],
          ),
          body: BlocBuilder<SystematicPlanInstallmentsCubit, SystematicPlanInstallmentsState>(
            builder: (context, state) {
              if (state is SystematicPlanInstallmentsLoading) {
                return const Center(child: CustomLoader());
              }
              if (state is SystematicPlanInstallmentsError) {
                return Center(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    error: state.error,
                    onRetry: () => context.read<SystematicPlanInstallmentsCubit>().fetchSwpInstallments(userId: context.read<AuthCubit>().state.user!.id, swpId: swp.orderId!),
                  ),
                );
              }
              if (state is SystematicPlanInstallmentsLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CachedNetworkImage(imageUrl: swp.imgUrl, width: 50, height: 50),
                              title: Text(
                                swp.plan,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            if (swp.status == SystematicPlansStatus.activated) ...[
                              const Divider(),
                              ListTile(
                                title: Text(
                                  'Next due on ${DateFormat('dd MMM yyyy').format(swp.nextInstallmentDate)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      NumberFormat.currency(locale: 'en_IN', symbol: '\u20b9', decimalDigits: 0).format(swp.amount),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ],
                        ),
                      ),
                      const Gap(20),
                      const Text('Transaction History'),
                      const Gap(20),
                      EnhanceStepper(
                        controlsBuilder: (_, __) => const SizedBox.shrink(),
                        currentStep: state.installments[0].succeededAt == null ? 0 : state.installments.length,
                        steps: state.installments[0].succeededAt == null
                            ? [
                                swp.status == SystematicPlansStatus.deactivated
                                    ? EnhanceStep(
                                        title: const Text('SWP Cancelled on'),
                                        icon: const Icon(
                                          Icons.close,
                                          color: AppColors.errorRed,
                                        ),
                                        content: const SizedBox.shrink(),
                                        subtitle: Text(DateFormat('dd MMM yyyy hh:mm a').format(swp.updatedAt.toLocal())),
                                      )
                                    : EnhanceStep(
                                        title: Text('${Utils.suffixText(1)} SWP in Progress'),
                                        icon: const Icon(
                                          Icons.schedule_outlined,
                                          color: AppColors.lightOrange,
                                        ),
                                        content: const SizedBox.shrink(),
                                      ),
                              ]
                            : List.generate(
                                state.installments.length + 1,
                                (index) {
                                  if (index == 0) {
                                    if (swp.status == SystematicPlansStatus.deactivated) {
                                      return EnhanceStep(
                                        title: const Text('SWP Cancelled on'),
                                        icon: const Icon(
                                          Icons.close,
                                          color: AppColors.errorRed,
                                        ),
                                        content: const SizedBox.shrink(),
                                        subtitle: Text(DateFormat('dd MMM yyyy hh:mm a').format(swp.updatedAt.toLocal())),
                                      );
                                    }

                                    return EnhanceStep(
                                      title: Text('${Utils.suffixText(state.installments.length + 1)} SWP due in'),
                                      icon: const Icon(
                                        Icons.schedule_outlined,
                                        color: AppColors.darkOrange,
                                      ),
                                      content: const SizedBox.shrink(),
                                      subtitle: Text('${swp.startDate.difference(DateTime.now()).inDays} days'),
                                    );
                                  }
                                  return EnhanceStep(
                                    title: Text('${Utils.suffixText(index)} SWP processed on'),
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.green,
                                    ),
                                    subtitle: Text(DateFormat('dd MMM yyyy hh:mm a').format(state.installments[index - 1].succeededAt!.toLocal())),
                                    content: const SizedBox.shrink(),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
