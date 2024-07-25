import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/meta_strings.dart';
import '../../models/user/user.dart';

abstract class AccountLocalDataSource {
  Future<void> cacheUser(User user);

  Future<User?> getCachedUser();
}

@LazySingleton(as: AccountLocalDataSource)
class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  @override
  Future<void> cacheUser(User user) async {
    final Box accountBox = await Hive.openBox(
      HiveBoxStrings.accountBox,
    );
    return await accountBox.put(HiveBoxStrings.user, user);
  }

  @override
  Future<User?> getCachedUser() async {
    final Box accountBox = await Hive.openBox(HiveBoxStrings.accountBox);
    return accountBox.get(HiveBoxStrings.user);
  }
}
