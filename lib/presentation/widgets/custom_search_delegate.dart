import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../common/common.dart';
import '../../data/models/mutual_funds/fund.dart';
import '../../gen/assets.gen.dart';
import '../cubits/mutual_funds/search_funds/search_fund_cubit.dart';
import '../screens/mutual_funds/widgets/mf_search_result_card.dart';
import 'custom_loader.dart';

//TODO: In future update the search delegate to custom search screen as the animation of current delegate is boring.

class CustomSearchDelegate extends SearchDelegate {
  final SearchFundCubit searchFundCubit;
  final Debouncer debouncer;

  var _scrollController = ScrollController();
  bool _isLastPage = false;
  bool _loadError = false;

  CustomSearchDelegate({
    required this.searchFundCubit,
    required this.debouncer,
  });

  final Widget _emptySearchWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.svgs.searchFund.svg(),
        const Gap(10),
        const Text('Search for Top Mutual Funds in Market'),
      ],
    ),
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        iconTheme: const IconThemeData(size: 18),
        titleSpacing: 0,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        border: const UnderlineInputBorder(),
        filled: false,
        isDense: true,
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: theme.textTheme.titleMedium?.copyWith(color: Colors.black),
      ),
    );
  }

  @override
  String? get searchFieldLabel => 'Search (min 3 letters)';


  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 14,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchFundsWithQuery(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchFundsWithQuery(query);
  }

  Widget _searchFundsWithQuery(String query) {
    if (query.length < 3) {
      searchFundCubit.resetSearch();
      return _emptySearchWidget;
    }
    debouncer.run(() {
      searchFundCubit.getMutualFundsWithQuery(
        query,
        offset: 0,
      );

      _scrollController.dispose();
      _scrollController = ScrollController();

      _scrollController.addListener(() {
        if (_scrollController.position.maxScrollExtent -
                _scrollController.position.pixels <=
            150) {
          if (_isLastPage ||
              _loadError ||
              _scrollController.position.pixels == 0) return;

          searchFundCubit.getMutualFundsWithQuery(
            query,
          );
        }
      });
    });

    return BlocBuilder<SearchFundCubit, SearchFundState>(
      bloc: searchFundCubit,
      builder: (context, state) => _buildResultsBasedOnState(context, state),
    );
  }

  Widget _buildResultsBasedOnState(context, state) {
    List<Fund> funds = [];
    var isLoading = false;
    _loadError = false;

    if (state is SearchFundLoading && state.isFirstFetch) {
      isLoading = true;

      return const Center(
        child: CustomLoader(),
      );
    }

    if (state is SearchFundLoading) {
      isLoading = true;
      funds = state.oldFunds;
    }

    if (state is SearchFundLoadError) {
      _loadError = true;
      isLoading = false;
      funds = state.oldFunds;
    }

    if (state is SearchFundLoaded) {
      isLoading = false;
      funds = state.funds;
      _isLastPage = state.isLastPage;
    }

    return funds.isEmpty
        ? const Center(
            child: Text("No results found"),
          )
        : ListView.builder(
            controller: _scrollController,
            itemCount: funds.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < funds.length) {
                return MFSearchResultCard(
                  fund: funds[index],
                );
              } else {
                return const CustomLoader();
              }
            },
          );
  }
}
