import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../cubits/mutual_funds/systematic_plans/systematic_plans_cubit.dart';
import '../../../widgets/empty_portfolio_view.dart';
import '../../../widgets/widgets.dart';
import 'systematic_plan_card.dart';

class ActivePlansTabView extends HookWidget {
  const ActivePlansTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return BlocBuilder<ActiveSystematicPlansCubit, SystematicPlansState>(
      builder: (context, state) {
        if (state is SystematicPlansLoading) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state is SystematicPlansError) {
          return Center(
            child: AppErrorWidget(errorType: state.errorType, error: state.error),
          );
        }
        if (state is SystematicPlansLoaded) {
          if (state.plans.isEmpty) {
            return const Center(
                child: EmptyPortfolioView(
              message: 'No Active Plans found',
            ));
          }
          return ListView.builder(
            itemCount: state.plans.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return SystematicPlanCard(plan: state.plans[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
