import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:temp_project/boxes.dart';
import 'package:temp_project/model/userInfoModel.dart';

class UserInfoSeen extends StatefulWidget {
  String userName;
  int id;
  UserInfoSeen(this.userName, this.id);

  @override
  _UserInfoSeenState createState() => _UserInfoSeenState();
}

class _UserInfoSeenState extends State<UserInfoSeen> {
  final box = Hive.box<UserInfo>('users');
  String? msg;

  @override
  Widget build(BuildContext context) {
    String agePrint = '';
    String genderPrint = '';
    UserInfo user = UserInfo();

    print(box.get(widget.id)!.age);

    if (box.get(widget.id) != null) {
      user == box.get(widget.id);
      agePrint = box.get(widget.id)!.age;
      genderPrint = box.get(widget.id)!.gender;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User: ${widget.userName}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Age: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(
                      agePrint,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Gender: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(
                      genderPrint,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: GestureDetector(
                  onTap: () {
                    deleteUserInfo(user, widget.id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 110,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteUserInfo(UserInfo user, int id) {
    final box = Boxes.getUsers();
    box.delete(id);
    //user.delete();
  }
}
