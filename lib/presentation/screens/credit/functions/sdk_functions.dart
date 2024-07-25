import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

Future<void> configSDK() async {
  try {
    const config = ScLoanConfig(ScLoanEnvironment.PRODUCTION, 'bullsurge');
    await ScLoan.setup(config);
  } on ScLoanError {
    rethrow;
  }
}

Future<String?> callApplySDK(String token) async {
  await configSDK();

  try {
    final loanInfo = ScLoanInfo(token);
    final ScLoanSuccess response = await ScLoan.apply(loanInfo);

    return response.data;
  } on ScLoanError {
    rethrow;
  }
}

Future<String?> callRepaySDK(String token) async {
  await configSDK();

  try {
    final loanInfo = ScLoanInfo(token);
    final ScLoanSuccess response = await ScLoan.pay(loanInfo);
    if (response.isSuccess) {
      return response.data;
    } else {
      throw 'Something went wrong';
    }
  } on ScLoanError {
    rethrow;
  }
}

Future<String?> callWithdrawSDK(String token) async {
  await configSDK();

  try {
    final loanInfo = ScLoanInfo(token);
    final ScLoanSuccess response = await ScLoan.withdraw(loanInfo);
    if (response.isSuccess) {
      return response.data;
    } else {
      throw 'Something went wrong';
    }
  } on ScLoanError catch (e) {
    throw e.message;
  }
}
