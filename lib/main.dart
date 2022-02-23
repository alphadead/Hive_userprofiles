import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp_project/model/userInfoModel.dart';
import 'package:temp_project/pages/mainPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  await Hive.openBox<UserInfo>('users');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profiles',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: JsonPage(),
    );
  }
}
