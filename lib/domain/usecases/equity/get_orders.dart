import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_order/equity_orders_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetOrders extends UseCase<List<EquityOrderModel>,EquityOrdersParams>{
  final EquityRespository equityRespository;

  GetOrders(this.equityRespository);
  @override
  Future<Either<AppError,List<EquityOrderModel>>> call(EquityOrdersParams params) =>
      equityRespository.getOrders(params.toJson());
}