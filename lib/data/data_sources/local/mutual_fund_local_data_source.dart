import 'package:injectable/injectable.dart';

abstract class MutualFundLocalDataSource {}

@LazySingleton(as: MutualFundLocalDataSource)
class MutualFundLocalDataSourceImpl implements MutualFundLocalDataSource {}
