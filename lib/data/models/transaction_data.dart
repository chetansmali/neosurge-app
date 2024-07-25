import '../../domain/entities/enums.dart';
import 'mutual_funds/fund.dart';
import 'user/user_bank_details_model.dart';

/// Used to show the transaction data upon successful transaction in mutual funds
/// (Lumpsum,SIP,Switch,Redeem,SWP,STP)

class TransactionData {
  Fund? fund;

  /// This value will be not null if the transaction is Stp or Switch
  Fund? switchStpFund;
  MFTransactionTypes? transactionType;
  String? amount;
  String? units;
  bool? status;
  UserBank? bank;

  void clearData() {
    fund = null;
    switchStpFund = null;
    transactionType = null;
    amount = null;
    units = null;
    status = null;
    bank = null;
  }
}

final transactionData = TransactionData();
