import 'package:injectable/injectable.dart';

abstract class DigitalGoldLocalDataSource {}

@LazySingleton(as: DigitalGoldLocalDataSource)
class DigitalGoldLocalDataSourceImpl implements DigitalGoldLocalDataSource {}
