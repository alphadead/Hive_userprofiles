import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/userInfoModel.dart';

class UserDialog extends StatefulWidget {
  final UserInfo? user;
  final int index;
  final Function(int id, String gender, String age) onClickedDone;

  const UserDialog({
    Key? key,
    required this.index,
    this.user,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _UserDialogState createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  String gender = 'Male';
  String age = '';

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      final user = widget.user!;
      genderController.text = user.gender;

      ageController.text = user.age;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Info'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildRadioButtons(),
              SizedBox(height: 8),
              buildage(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, widget.index),
      ],
    );
  }

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<String>(
            title: Text('Male'),
            value: 'Male',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value!),
          ),
          RadioListTile<String>(
            title: Text('Female'),
            value: 'Female',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value!),
          ),
          RadioListTile<String>(
            title: Text('Other'),
            value: 'Other',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value!),
          ),
        ],
      );

  Widget buildage() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Age',
        ),
        keyboardType: TextInputType.number,
        validator: (age) => age == null ? 'Cannot be empty' : null,
        controller: ageController,
        
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, int index) {
    return TextButton(
      child: Text('Save Info'),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();
        var age = ageController.text;
        print(age);
        print(gender);

        if (isValid) {
          widget.onClickedDone(widget.index, gender, age);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
