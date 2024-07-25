import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/mutual_funds/get_funds_by_investment_idea/get_funds_by_investment_idea_cubit.dart';
import 'all_funds_card.dart';

class FundsListViewByInvestmentIdea extends StatefulWidget {
  const FundsListViewByInvestmentIdea({
    super.key,
    required this.investmentIdea,
    required this.scrollController,
  });

  final String investmentIdea;
  final ScrollController scrollController;

  @override
  State<FundsListViewByInvestmentIdea> createState() =>
      _FundsListViewByInvestmentIdeaState();
}

class _FundsListViewByInvestmentIdeaState
    extends State<FundsListViewByInvestmentIdea> {
  bool _isLastPageFetched = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent -
                  widget.scrollController.position.pixels <=
              200 &&
          !_isLastPageFetched) {
        _handleFetchFund();
      }
    });
  }

  void _handleFetchFund({
    bool isFirstFetch = false,
    String sort = '_3Y,DESC',
  }) {
    context.read<GetFundsByInvestmentIdeaCubit>().getFundsByInvestmentIdea(
          viewKey: widget.investmentIdea,
          page: isFirstFetch ? 0 : null,
          sort: sort,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFundsByInvestmentIdeaCubit,
        GetFundsByInvestmentIdeaState>(
      listener: (context, state) {
        if (state is GetFundsByInvestmentIdeaLoaded) {
          _isLastPageFetched = state.isLastPage;
        }

        if (state is GetFundsByInvestmentIdeaLoading) {
          if (state.isFirstFetch) {
            _isLastPageFetched = false;
          }
        }
      },
      builder: (context, state) {
        final fundList = state.fundList ?? [];

        return SliverList.builder(
          itemCount: state is GetFundsByInvestmentIdeaLoading
              ? fundList.length + 1
              : fundList.length,
          itemBuilder: (context, index) {
            if (index > fundList.length - 1) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            return AllFundsCard(
              mutualFund: fundList[index],
            );
          },
        );
      },
    );
  }
}
