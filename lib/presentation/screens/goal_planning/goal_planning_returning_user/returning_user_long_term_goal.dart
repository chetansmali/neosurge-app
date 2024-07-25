import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/goal_planning/get_goal_planning_dashboard_data_cubit.dart';
import 'bookmarkerd_goal_planning_card.dart';

class ReturningUserLongTermGoal extends StatefulWidget {
  final String refresh;
  const ReturningUserLongTermGoal({
    super.key,
    required this.refresh,
  });

  @override
  State<ReturningUserLongTermGoal> createState() =>
      _ReturningUserLongTermGoalState();
}

class _ReturningUserLongTermGoalState extends State<ReturningUserLongTermGoal> {
  final ScrollController _scrollController = ScrollController();
  bool _isLastPageFetched = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels <=
              200 &&
          !_isLastPageFetched) {
        _handleFetchFund();
      }
    });
  }

  void _handleFetchFund({
    bool isFirstFetch = false,
  }) {
    context.read<GetGoalPlanningDashboardDataCubit>().getDashboardData(
          goaltype: 'LONG_TERM',
          page: isFirstFetch ? 0 : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.refresh == 'true') {
      context.read<GetGoalPlanningDashboardDataCubit>().getDashboardData(
            goaltype: 'LONG_TERM',
            page: 0,
          );
    }
    return BlocBuilder<GetGoalPlanningDashboardDataCubit,
        GetGoalPlanningDashboardDataState>(
      builder: (context, state) {
        final fundList = state.fundList ?? [];

        if (state is GetGoalPlanningDashboardDataLoaded) {
          _isLastPageFetched = state.isLastPage;
        }

        if (state is GetGoalPlanningDashboardDataLoaded &&
            state is! GetGoalPlanningDashboardDataLoading &&
            fundList.isEmpty) {
          return Assets.svgs.noTransaction.svg();
        }

        return ListView.builder(
            controller: _scrollController,
            itemCount: state is GetGoalPlanningDashboardDataLoading
                ? fundList.length + 1
                : fundList.length,
            itemBuilder: (context, index) {
              if (index > fundList.length - 1) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              return BookmarkedGoalPlanningCard(
                icon: state.fundList?[index].goalIcon,
                title: state.fundList?[index].goalName ?? '',
                persentageValue:
                    state.fundList?[index].goalCompletionPercentage ?? 0,
                subtitle: state.fundList?[index].currentGoalAmount ?? 0,
                goalCompleted: state.fundList?[index].goalCompleted ?? false,
                id: state.fundList![index].id.toString(),
              );
            });

        return const SizedBox.shrink();
      },
    );
  }
}
