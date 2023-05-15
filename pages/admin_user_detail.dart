import 'package:day35/services/firestore_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  _UserDetail createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _phone = "";

  void _saveForm() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      // TODO: Save the worker data to the database or API
      print("Name: $_name, Email: $_email, Phone: $_phone");
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserStruct Suser = ModalRoute.of(context)!.settings.arguments as UserStruct;

    return Scaffold(
      appBar: AppBar(
        title: Text("Users detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: "xxxx",
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  initialValue: "xxx@gmail.com",
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  initialValue: "7777",
                  decoration: InputDecoration(
                    labelText: "Phone",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value!;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Text("Update"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Delete the worker from the database or API
                        Navigator.of(context).pop();
                      },
                      child: Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
