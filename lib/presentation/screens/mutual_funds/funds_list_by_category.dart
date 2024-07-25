import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/mutual_funds/get_fund_by_subcategory/get_funds_by_subcategory_cubit.dart';
import 'widgets/all_funds_card.dart';

class FundsListByCategory extends StatefulWidget {
  const FundsListByCategory({
    super.key,
    required this.category,
    required this.subCategory,
  });

  final String category;
  final String subCategory;

  @override
  State<FundsListByCategory> createState() => _FundsListByCategoryState();
}

class _FundsListByCategoryState extends State<FundsListByCategory> {
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
    String sort = '_3Y,DESC',
  }) {
    context.read<GetFundBySubcategoryCubit>().getFundsBySubcategory(
          category: widget.category,
          subCategory: widget.subCategory,
          page: isFirstFetch ? 0 : null,
          sort: sort,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategory),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<GetFundBySubcategoryCubit, GetFundBySubcategoryState>(
            builder: (context, state) {
              final fundList = state.fundList ?? [];

              if (state is GetFundBySubcategoryLoaded) {
                _isLastPageFetched = state.isLastPage;
              }

              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state is GetFundBySubcategoryLoading
                      ? fundList.length + 1
                      : fundList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
