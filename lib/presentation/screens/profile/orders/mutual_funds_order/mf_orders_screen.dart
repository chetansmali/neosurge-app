import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../../data/models/user/user.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/mutual_funds/mf_orders/mf_orders_cubit.dart';
import '../../../../cubits/mutual_funds/mf_orders_filter_sort/mf_orders_filter_sort_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/empty_portfolio_view.dart';
import '../../../../widgets/widgets.dart';
import 'mf_order_card.dart';
import 'mf_order_filter_screen.dart';

class MFOrdersScreen extends StatefulWidget {
  const MFOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MFOrdersScreen> createState() => _MFOrdersScreenState();
}

class _MFOrdersScreenState extends State<MFOrdersScreen> {
  late final ScrollController _scrollController;
  bool _isLastPage = false;
  bool _isLoadError = false;
  AppErrorType _errorType = AppErrorType.api;
  late User _user;
  late MfOrdersFilterSortCubit _filterSortCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _setupScrollController();
  }

  @override
  void didChangeDependencies() {
    _user = context.read<AuthCubit>().state.user!;
    _filterSortCubit = context.read<MfOrdersFilterSortCubit>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleMfOrderFetch(
      {bool isFirstFetch = false, MFOrderStatus? orderStatus}) {
    context.read<MfOrdersCubit>().fetchOrders(
          userId: _user.id,
          offset: isFirstFetch ? 0 : null,
          orderStatus: orderStatus,
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
          _handleMfOrderFetch();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Mutual Funds Orders',
            style: baseTextStyle14400.copyWith(color: AppColors.mainBlack),
          ),
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                BlocConsumer<MfOrdersFilterSortCubit, MfOrdersFilterSortState>(
              listener: (_, state) {
                if (state is MfOrdersFilterSortInitial) {
                  _handleMfOrderFetch(
                      isFirstFetch: true, orderStatus: state.orderStatus);
                }
              },
              builder: (_, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: _filterSortCubit,
                                child: const MFOrderFilterSortScreen(),
                              ),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primaryLightColor,
                        ),
                        child: const Text(
                          'FILTER',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    if (state.orderStatus != null) ...[
                      const Gap(4),
                      const Icon(
                        Icons.circle,
                        color: AppColors.primaryColor,
                        size: 12,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MfOrdersCubit, MfOrdersState>(
              builder: (_, state) {
                List<MfOrder> mfOrders = [];
                bool isLoading = false;
                _isLoadError = false;
                if (state is MfOrdersLoading && state.isFirstFetch) {
                  return const Center(child: CustomLoader());
                } else if (state is MfOrdersLoadError && state.isFirstFetch) {
                  return Center(
                    child: AppErrorWidget(
                        errorType: state.errorType,
                        error: state.errorMessage,
                        onRetry: () => _handleMfOrderFetch()),
                  );
                } else if (state is MfOrdersLoadError) {
                  mfOrders = state.oldOrders;
                  _isLoadError = true;
                  _errorType = state.errorType;
                  isLoading = false;
                } else if (state is MfOrdersLoading) {
                  mfOrders = state.oldOrders;
                  isLoading = true;
                } else if (state is MfOrdersLoaded) {
                  mfOrders = state.orders;
                  _isLastPage = state.isLastPage;
                  isLoading = false;
                }

                return mfOrders.isEmpty
                    ? Center(
                        child: EmptyPortfolioView(
                          message: _filterSortCubit.state.orderStatus != null
                              ? 'No orders found for the selected filter. Please change the filter and try again.'
                              : 'No orders yet. Start investing now to see your orders here.',
                          messageStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: mfOrders.length +
                            (isLoading || _isLoadError ? 1 : 0),
                        controller: _scrollController,
                        itemBuilder: (_, index) {
                          if (index < mfOrders.length) {
                            return MfOrderCard(order: mfOrders[index]);
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
        ],
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
              onPressed: () => _handleMfOrderFetch(),
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      );
}
