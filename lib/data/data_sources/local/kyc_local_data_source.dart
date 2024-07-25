import 'package:injectable/injectable.dart';

abstract class KycLocalDataSource {}

@LazySingleton(as: KycLocalDataSource)
class KycLocalDataSourceImpl implements KycLocalDataSource {}
