import 'package:hive/hive.dart';
import 'package:temp_project/model/userInfoModel.dart';

class Boxes {
  static Box<UserInfo> getUsers() => Hive.box<UserInfo>('users');
}
