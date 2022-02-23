import 'package:hive/hive.dart';

part 'userInfoModel.g.dart';

@HiveType(typeId: 0)
class UserInfo extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String gender;

  @HiveField(2)
  late String age;
}
