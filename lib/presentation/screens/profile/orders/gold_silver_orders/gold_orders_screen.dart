import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/empty_portfolio_view.dart';
import '../../../digital_gold/widgets/dg_transaction_card.dart';

class GoldOrdersScreen extends StatefulWidget {
  const GoldOrdersScreen({Key? key}) : super(key: key);

  @override
  State<GoldOrdersScreen> createState() => _GoldOrdersScreenState();
}

class _GoldOrdersScreenState extends State<GoldOrdersScreen> {
  late final ScrollController _scrollController;
  bool _isLastPage = false;
  bool _isLoadError = false;
  AppErrorType _errorType = AppErrorType.api;

  // late MfOrdersFilterSortCubit _filterSortCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _setupScrollController();
  }

  @override
  void didChangeDependencies() {
    // _filterSortCubit = context.read<MfOrdersFilterSortCubit>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleGoldOrderFetch({
    bool isFirstFetch = false,
  }) {
    context.read<DgTransactionCubit>().fetchTransactions(
          transactionStatus: DgTransactionStatus.all,
          isFirstFetch: isFirstFetch,
        );
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          100) {
        if (_scrollController.position.pixels != 0 &&
            !_isLastPage &&
            !_isLoadError) {
          _handleGoldOrderFetch();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gold Orders'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(24.0),
            Expanded(
              child: BlocBuilder<DgTransactionCubit, DgTransactionState>(
                builder: (context, state) {
                  List<DgTransactionResponseModel> transactions = [];
                  bool isLoading = false;
                  _isLoadError = false;
                  if (state is DgTransactionLoading && state.isFirstFetch) {
                    return const Center(child: CustomLoader());
                  } else if (state is DgTransactionLoadError &&
                      state.isFirstFetch) {
                    return Center(
                      child: AppErrorWidget(
                          errorType: state.appErrorType,
                          error: state.errorMessage,
                          onRetry: () => _handleGoldOrderFetch()),
                    );
                  } else if (state is DgTransactionLoadError) {
                    transactions = state.oldTransactionList;
                    _isLoadError = true;
                    _errorType = state.appErrorType;
                    isLoading = false;
                  } else if (state is DgTransactionLoading) {
                    transactions = state.oldTransactionList;
                    isLoading = true;
                  } else if (state is DgTransactionLoaded) {
                    transactions = state.transactionList;
                    _isLastPage = state.isLastPage;
                  }

                  return transactions.isEmpty
                      ? Center(
                          child: EmptyPortfolioView(
                            message:
                                'No orders yet. Start investing now to see your orders here.',
                            messageStyle:
                                Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: transactions.length +
                              (isLoading || _isLoadError ? 1 : 0),
                          controller: _scrollController,
                          itemBuilder: (_, index) {
                            if (index < transactions.length) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: DgTransactionCard(
                                  transaction: DgTransactionModel(
                                      transaction: transactions[index]),
                                  transactionStatus: transactions[index].status,
                                ),
                              );
                            } else {
                              Timer(const Duration(milliseconds: 30), () {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              });
                              return _isLoadError
                                  ? _errorWidget(_errorType)
                                  : _loadingIndicator();
                            }
                          },
                        );
                },
              ),
            ),
            const Gap(24.0),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CustomLoader(),
      ),
    );
  }

  Widget _errorWidget(final AppErrorType appErrorType) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appErrorType == AppErrorType.network
                ? 'No Internet Connection'
                : 'Something went wrong',
            textAlign: TextAlign.center,
          ),
          IconButton(
              onPressed: () => _handleGoldOrderFetch(),
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      );
}
