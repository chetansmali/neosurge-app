import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import '../../../../common/common.dart';
import '../../../../data/models/equity/login/get_transaction_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/equity/ligin/get_transaction.dart';
import '../../../../domain/entities/params/equity/ligin/smallcase_login.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../logger.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/equity/login/get_all_brokers_cubit.dart';
import '../../../cubits/equity/login/smallcase_login_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../cubits/equity/login/transactionid_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_error_widget.dart';
import 'equity_login_gridview.dart';

class EquityLogin extends StatefulWidget {
  const EquityLogin({super.key});

  @override
  State<EquityLogin> createState() => _EquityLoginState();
}

class _EquityLoginState extends State<EquityLogin> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool isSelected = false;
  bool _isChecked = false;
  late String recivedBrokerKey;
  late String brokerName;

  @override
  void initState() {
    super.initState();
    recivedBrokerKey = EquityBrokers.aliceblue.toString();
    brokerName = context.read<AuthCubit>().state.user!.equityBroker ?? '';

    if (brokerName.isNotEmpty) {
      _isChecked = true;
    }

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with your broker'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('skip'),
          )
        ],
      ),
      body: SizedBox(
        child: BlocBuilder<GetAllBrokersCubit, GetAllBrokersState>(
          builder: (context, brokerListState) {
            if (brokerListState is GetAllBrokersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (brokerListState is GetAllBrokersFailure) {
              return AppErrorWidget(
                errorType: brokerListState.errorType,
                error: brokerListState.errorMessage,
                onRetry: () =>
                    context.read<GetAllBrokersCubit>()..fetchBroker(),
              );
            }
            if (brokerListState is GetAllBrokersSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(40),
                  Expanded(
                    child: ImageGridView(
                      pageController: _pageController,
                      brokerList: brokerListState.brokersModel,
                      currentPage: _currentPage,
                      selectBrokerKey: _recivedBrokerKey,
                      selectBrokerName: _brokerName,
                      selectedBrokerKey: brokerName,
                    ),
                  ),
                  const Gap(25),
                  CheckboxListTile.adaptive(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    side: BorderSide(
                      color:
                          _isChecked == true ? Colors.blueAccent : Colors.black,
                    ),
                    checkColor: AppColors.primaryColor,
                    activeColor: Colors.blue[50],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Yes, I agree ',
                          style: baseTextStyle12400,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.equityTermsConditions),
                          child: Text(
                            'Terms and Conditions',
                            style: baseTextStyle12400,
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ElevatedButton(
                    onPressed: _isChecked
                        ? () {
                            context
                                .read<TransactionidCubit>()
                                .fetchTransactionId(
                                  TransactionParams(
                                    email: context
                                        .read<AuthCubit>()
                                        .state
                                        .user!
                                        .emailId,
                                    broker: brokerName.toUpperCase(),
                                  ),
                                );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isChecked ? null : Colors.transparent,
                      fixedSize: const Size(335, 56),
                    ),
                    child: Builder(builder: (context) {
                      var transactionidState =
                          context.watch<TransactionidCubit>().state;

                      var smallLoginState =
                          context.watch<SmallcaseLoginCubit>().state;

                      if (transactionidState is TransactionidLoading ||
                          smallLoginState is SmallcaseLoginLoading) {
                        return Assets.animations.loading.lottie();
                      }

                      if (smallLoginState is SmallcaseLoginSuccess) {
                        context
                            .read<AuthCubit>()
                            .updateUser(
                              context.read<AuthCubit>().state.user!.copyWith(
                                    smallcaseAuthToken: smallLoginState
                                        .smallCaseLoginModel.smallcaseAuthToken,
                                    equityBroker: brokerName,
                                  ),
                            )
                            .then(
                              (value) => Navigator.pop(context),
                            );

                        return const SizedBox.shrink();
                      }

                      if (smallLoginState is SmallcaseLoginFailure) {
                        Utils.showErrorAlert(
                          context,
                          smallLoginState.errorMessage ??
                              'Something went wrong, try again..! SmallcaseLoginFailure',
                        );

                        return const Text('Continue');
                      }

                      if (transactionidState is TransactionidSuccess) {
                        if (transactionidState.transactionModel.success) {
                          _smallcaseCall(transactionidState.transactionModel);
                        } else {
                          Utils.showErrorAlert(
                            context,
                            transactionidState.transactionModel.message ??
                                'Something went wrong, try again..!',
                          );
                        }
                      }

                      return const Text('Continue');
                    }),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Don\'t have a broker?',
                        style: baseTextStyle14400,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.equitySignup);
                        },
                        child: Text(
                          'Create a account',
                          style: baseTextStyle14400,
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _recivedBrokerKey(String brokerName) {
    recivedBrokerKey = brokerName.toLowerCase();
  }

  _brokerName(String name) {
    brokerName = name.toUpperCase();
  }

  Future<void> _smallcaseCall(TransactionModel state) async {
    await ScgatewayFlutterPlugin.setConfigEnvironment(
      GatewayEnvironment.PRODUCTION,
      'bullsurge',
      false,
      [recivedBrokerKey],
      isAmoenabled: true,
    );
    await ScgatewayFlutterPlugin.initGateway(state.smallcaseAuthToken!);

    final gatewayResponse =
        await ScgatewayFlutterPlugin.triggerGatewayTransaction(
      state.transactionId!,
    );

    Map<String, dynamic> jsonData = jsonDecode(gatewayResponse!);

    String? dataCollection = jsonData['data'];
    bool? success = jsonData['success'];

    if (dataCollection == null) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Utils.showErrorAlert(context, 'Something went wrong, try again..!');
    } else {
      Map<String, dynamic> data = jsonDecode(dataCollection);
      String? token = data['smallcaseAuthToken'];

      if (success != null && success) {
        if (!context.mounted) return;
        Utils.showSuccessAlert(context, 'Your account is verified');

        context.read<SmallcaseLoginCubit>().fetchSmallcaseLogin(
              SmallCaseLoginParams(
                profileType: "INVESTING",
                broker: brokerName,
                email: context.read<AuthCubit>().state.user!.emailId,
                smallcaseAuthToken: token,
              ),
            );
      } else {
        if (!context.mounted) return;
        Navigator.pop(context);
        Utils.showErrorAlert(context, 'Something went wrong, try again..!');
      }
    }
  }
}
