import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:hive/hive.dart';
import 'package:temp_project/boxes.dart';
import 'package:temp_project/model/user.dart';
import 'package:temp_project/model/userInfoModel.dart';
import 'package:temp_project/pages/userInfoseen.dart';
import 'package:temp_project/widget/userinfo.dart';

class JsonPage extends StatefulWidget {
  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final box = Hive.box<UserInfo>('users');
  String check = 'not';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Users on this app"),
      ),
      body: Center(
        child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, snapshot) {
            var showData = snapshot.data as List<User>;
            final box = Hive.box<UserInfo>('users');

            return ListView.builder(
              itemCount: showData.length,
              itemBuilder: (BuildContext context, int index) {
                return newMethod(showData, index, box, context);
              },
            );
          },
          // future: DefaultAssetBundle.of(context)
          //     .loadString("assets/dummyJson.json"),
        ),
      ),
    );
  }

  Padding newMethod(
      List<User> showData, int index, Box<UserInfo> box, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  int id = int.parse(showData[index].id.toString());
                  check = box.get(id)?.age ?? 'empty';
                  if (check != 'empty') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoSeen(
                          showData[index].name.toString(),
                          int.parse(showData[index].id.toString()),
                        ),
                      ),
                    );
                  } else {
                    _key.currentState?.showSnackBar(
                      new SnackBar(
                        content: new Text('Sign In to Enter!'),
                      ),
                    );
                  }
                },
                child: Text(
                  showData[index].name.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => UserDialog(
                      onClickedDone: addUserInfo,
                      index: int.parse(showData[index].id ?? '1'),
                    ),
                  );
                },
                child: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      // Boxes.getUsers().getAt(index)?.age != null
                      //     ? Colors.orange
                      //     : Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Sign In!',
                      // Boxes.getUsers().getAt(index)?.age != null
                      //     ? 'Sign Out!'
                      //     : 'Sign In!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 1,
              width: double.maxFinite,
              color: Colors.grey[300],
            ),
          )
        ],
      ),
    );
  }

  Future<List<User>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/dummyJson.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => User.fromJson(e)).toList();
  }

  Future addUserInfo(int id, String gender, String age) async {
    final user = UserInfo()
      ..id = id
      ..gender = gender
      ..age = age;

    final box = Boxes.getUsers();
    box.put(id, user);
  }
}
