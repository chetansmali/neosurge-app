import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../gen/assets.gen.dart';
import '../../cubits/mutual_funds/get_funds_by_investment_idea/get_funds_by_investment_idea_cubit.dart';
import '../../cubits/mutual_funds/get_investment_idea_filters/get_investment_idea_filters_cubit.dart';
import '../../theme/app_colors.dart';
import 'widgets/fund_listview_by_investment_idea.dart';

class FundsListByInvestmentIdeaScreen extends StatelessWidget {
  FundsListByInvestmentIdeaScreen({
    super.key,
    required this.investmentIdea,
  });

  final String investmentIdea;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top ${investmentIdea.substring(0, 1).toUpperCase()}${investmentIdea.substring(1).toLowerCase()}',
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<GetInvestmentIdeaFiltersCubit,
          GetInvestmentIdeaFiltersState>(
        listener: (context, state) {
          if (state is GetInvestmentIdeaFiltersLoaded) {
            context
                .read<GetFundsByInvestmentIdeaCubit>()
                .getFundsByInvestmentIdea(
                  filter: state.investmentIdeas.first,
                  viewKey: investmentIdea,
                );
          }
        },
        builder: (context, state) {
          if (state is GetInvestmentIdeaFiltersLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is GetInvestmentIdeaFiltersError) {
            return Center(
              child: Text(state.error ?? 'An error occurred'),
            );
          }

          if (state is GetInvestmentIdeaFiltersLoaded) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                _InvestmentIdeaIntro(
                  investmentIdea: investmentIdea,
                ),
                _InvestmentIdeaList(
                  ideas: state.investmentIdeas,
                  viewKey: investmentIdea,
                ),
                FundsListViewByInvestmentIdea(
                  investmentIdea: investmentIdea,
                  scrollController: _scrollController,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _InvestmentIdeaList extends StatefulWidget {
  const _InvestmentIdeaList({
    required this.ideas,
    required this.viewKey,
  });

  final List<String> ideas;
  final String viewKey;

  @override
  State<_InvestmentIdeaList> createState() => _InvestmentIdeaListState();
}

class _InvestmentIdeaListState extends State<_InvestmentIdeaList> {
  String _selectedIdea = '';

  @override
  void initState() {
    super.initState();
    _selectedIdea = widget.ideas.first;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 42,
        child: ListView.builder(
          itemCount: widget.ideas.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: _selectedIdea == widget.ideas[index]
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIdea = widget.ideas[index];
                  });

                  context
                      .read<GetFundsByInvestmentIdeaCubit>()
                      .getFundsByInvestmentIdea(
                        filter: widget.ideas[index],
                        viewKey: widget.viewKey,
                        page: 0,
                      );
                },
                child: Text(
                  widget.ideas[index],
                  style: TextStyle(
                    color: _selectedIdea == widget.ideas[index]
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InvestmentIdeaIntro extends StatelessWidget {
  const _InvestmentIdeaIntro({
    required this.investmentIdea,
  });

  final String investmentIdea;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  text: 'Explore ',
                  style: TextStyle(
                    color: AppColors.neutral[200],
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text:
                          ' top-performing ${investmentIdea.toLowerCase()}(s). ',
                      style: TextStyle(
                        color: AppColors.neutral[400],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text:
                          'From technology and healthcare to energy and consumer goods, explore opportunities for',
                      style: TextStyle(
                        color: AppColors.neutral[200],
                      ),
                    ),
                    TextSpan(
                      text: ' growth ',
                      style: TextStyle(
                        color: AppColors.neutral[400],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'and',
                      style: TextStyle(
                        color: AppColors.neutral[200],
                      ),
                    ),
                    TextSpan(
                      text: ' diversification.',
                      style: TextStyle(
                        color: AppColors.neutral[400],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Assets.svgs.topSector.svg(
              width: 44,
              height: 44,
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
