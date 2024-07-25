import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/debouncer.dart';
import '../../../../../../../data/models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../cubits/equity/equity_smart_watchlist/smart_watchlist_search_cubit.dart';
import '../../../../../../widgets/custom_loader.dart';
import '../smart_search_card.dart';

class SmartWatchlistSearchDelegate extends SearchDelegate {
  final SmartWatchlistSearchCubit searchFundCubit;
  final Debouncer debouncer;

  var _scrollController = ScrollController();
  bool _isLastPage = false;
  bool _loadError = false;

  SmartWatchlistSearchDelegate({
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
        const Text('Search for Top 500 stocks'),
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
        headline6: theme.textTheme.subtitle1?.copyWith(color: Colors.black),
      ),
    );
  }

  @override
  String? get searchFieldLabel => 'Search (min 3 letters)';

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      super.searchFieldDecorationTheme;

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

    return BlocBuilder<SmartWatchlistSearchCubit, SmartWatchlistSearchState>(
      bloc: searchFundCubit,
      builder: (context, state) => _buildResultsBasedOnState(context, state),
    );
  }

  Widget _buildResultsBasedOnState(context, state) {
    List<SmartWatchlistSearchModel> funds = [];
    var isLoading = false;
    _loadError = false;

    if (state is SmartWatchlistSearchLoading && state.isFirstFetch) {
      isLoading = true;

      return const Center(
        child: CustomLoader(),
      );
    }

    if (state is SmartWatchlistSearchLoading) {
      isLoading = true;
      funds = state.oldFunds;
    }

    if (state is SmartWatchlistSearchLoadError) {
      _loadError = true;
      isLoading = false;
      funds = state.oldFunds;
    }

    if (state is SmartWatchlistSearchLoaded) {
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
                return SmartSearchCard(
                  icon: funds[index].icon ?? '',
                  symbole: funds[index].symbol ?? '',
                  companyName: funds[index].companyName ?? '',
                  close: funds[index].close ?? 0,
                  change: funds[index].change ?? 0,
                  percentChange: funds[index].percentChange ?? 0,
                  qty: 0,
                );
              } else {
                return const CustomLoader();
              }
            },
          );
  }
}
