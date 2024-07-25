import 'package:injectable/injectable.dart';

abstract class DropdownLocalDataSource {}

@LazySingleton(as: DropdownLocalDataSource)
class DropdownLocalDataSourceImpl extends DropdownLocalDataSource {}
