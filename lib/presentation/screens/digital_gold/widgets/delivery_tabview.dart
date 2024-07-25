import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/utils.dart';
import '../../../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import 'dg_transaction_card.dart';

class DeliveryTabView extends StatefulWidget {
  const DeliveryTabView({
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryTabView> createState() => _DeliveryTabViewState();
}

class _DeliveryTabViewState extends State<DeliveryTabView>
    with AutomaticKeepAliveClientMixin {
  bool _isLastPage = false;
  bool _loadError = false;
  AppErrorType _appErrorType = AppErrorType.api;
  late final ScrollController _controller;
  bool? isGoldSelected;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _setupScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const Gap(20.0),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => isGoldSelected = null),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: isGoldSelected != null
                      ? isGoldSelected!
                          ? null
                          : null
                      : AppColors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'All',
                  style: baseTextStyle12500.copyWith(
                      color: isGoldSelected != null
                          ? isGoldSelected!
                              ? AppColors.neutral[500]
                              : AppColors.neutral[500]
                          : Colors.white),
                ),
              ),
            ),
            const Gap(8.0),
            GestureDetector(
              onTap: () => setState(() => isGoldSelected = true),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: isGoldSelected != null
                      ? isGoldSelected!
                          ? AppColors.primaryColor
                          : null
                      : null,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Gold',
                  style: baseTextStyle12500.copyWith(
                      color: isGoldSelected != null
                          ? isGoldSelected!
                              ? Colors.white
                              : AppColors.neutral[500]
                          : AppColors.neutral[500]),
                ),
              ),
            ),
            const Gap(8.0),
            GestureDetector(
              onTap: () => setState(() => isGoldSelected = false),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: isGoldSelected != null
                      ? isGoldSelected!
                          ? null
                          : AppColors.primaryColor
                      : null,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Silver',
                  style: baseTextStyle12500.copyWith(
                      color: isGoldSelected != null
                          ? isGoldSelected!
                              ? AppColors.neutral[500]
                              : Colors.white
                          : AppColors.neutral[500]),
                ),
              ),
            ),
          ],
        ),
        const Gap(20.0),
        Expanded(
          child: BlocBuilder<DgDeliveryTransactionCubit,
              DgDeliveryTransactionState>(
            builder: (context, state) {
              List<DgDeliveryTransactionResponseModel> transactions = [];
              bool isLoading = false;
              _loadError = false;
              if (state is DgDeliveryTransactionLoading && state.isFirstFetch) {
                return const Center(
                  child: CustomLoader(),
                );
              }
              if (state is DgDeliveryTransactionLoadError &&
                  state.isFirstFetch) {
                return AppErrorWidget(
                  errorType: state.appErrorType,
                  error: state.errorMessage,
                  onRetry: _handleTransactionFetch,
                );
              }
              if (state is DgDeliveryTransactionLoadError) {
                transactions = state.oldTransactionList;
                _loadError = true;
                isLoading = false;
                _appErrorType = state.appErrorType;
              } else if (state is DgDeliveryTransactionLoading) {
                transactions = state.oldTransactionList;
                isLoading = true;
              } else if (state is DgDeliveryTransactionLoaded) {
                transactions = state.transactionList;
                _isLastPage = state.isLastPage;
              }

              return transactions.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.svgs.emptyVector.svg(height: 200),
                          const Gap(20),
                          Text(
                            'No transactions yet',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _controller,
                      itemCount: transactions.length + (isLoading ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < transactions.length) {
                          if (isGoldSelected != null) {
                            if (isGoldSelected!) {
                              return transactions[index].isGoldExist
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: DgTransactionCard(
                                        transaction: DgTransactionModel(
                                          deliveryTransaction:
                                              transactions[index],
                                        ),
                                        transactionStatus:
                                            DgTransactionStatus.success,
                                      ),
                                    )
                                  : const SizedBox();
                            } else {
                              return transactions[index].isSilverExist
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: DgTransactionCard(
                                        transaction: DgTransactionModel(
                                          deliveryTransaction:
                                              transactions[index],
                                        ),
                                        transactionStatus:
                                            DgTransactionStatus.success,
                                      ),
                                    )
                                  : const SizedBox();
                            }
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DgTransactionCard(
                                transaction: DgTransactionModel(
                                  deliveryTransaction: transactions[index],
                                ),
                                transactionStatus: DgTransactionStatus.success,
                              ),
                            );
                          }
                        } else {
                          Timer(const Duration(milliseconds: 30), () {
                            _controller
                                .jumpTo(_controller.position.maxScrollExtent);
                          });
                          return _loadError
                              ? _errorWidget(_appErrorType, null)
                              : _loadingIndicator();
                        }
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _errorWidget(final AppErrorType appErrorType, final String? error) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Utils.getErrorMessage(errorType: appErrorType, msg: error),
            textAlign: TextAlign.center,
          ),
          IconButton(
              onPressed: () => _handleTransactionFetch(),
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      );

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CustomLoader(),
      ),
    );
  }

  void _setupScrollController() {
    _controller.addListener(() {
      //print(_controller.position.pixels);
      if (_controller.position.maxScrollExtent - _controller.position.pixels <=
          100) {
        if (_controller.position.pixels != 0 && !_isLastPage && !_loadError) {
          _handleTransactionFetch();
        }
      }
    });
  }

  void _handleTransactionFetch({bool isFirstFetch = false}) {
    context.read<DgDeliveryTransactionCubit>().fetchTransactions(
        transactionStatus: DgTransactionStatus.success,
        isFirstFetch: isFirstFetch);
  }

  @override
  bool get wantKeepAlive => true;
}
