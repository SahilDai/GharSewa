import 'package:day35/pages/login.dart';
import 'package:day35/services/firebase_authentication.dart';
import 'package:day35/services/firestore_users.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final UserStruct IUsers;
  const UserDetails({required this.IUsers, Key? key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();

  late String _id = "";
  late String _username = "";
  late String _email = "";
  late String _phone = "";
  late String _firstName = "";
  late String _lastName = "";
  late String _workType = "";
  late String _address = "";
  late String _authID = "";

  void _saveForm() async {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      print("Name: $_username, Email: $_email, Phone: $_phone, ID: $_id");

      UserStruct user = UserStruct(
          firstName: _firstName,
          lastName: _lastName,
          username: _username,
          contact: _phone,
          address: _address,
          email: _email,
          type: "users",
          isAvailable: true,
          authID: _authID,
          workType: _workType);
      bool res = await updateUserFromFireStore(widget.IUsers.id!, user);

      if (res) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User has been updated")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Unable to update users")));
      }

      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _id = widget.IUsers.id!;
    _username = widget.IUsers.username!;
    _firstName = widget.IUsers.firstName!;
    _lastName = widget.IUsers.lastName!;
    _workType = widget.IUsers.workType!;
    _email = widget.IUsers.email!;
    _phone = widget.IUsers.contact!;
    _address = widget.IUsers.address!;
    _authID = widget.IUsers.authID!;
  }

  @override
  Widget build(BuildContext context) {
    final UserStruct user =
        ModalRoute.of(context)!.settings.arguments as UserStruct;

    return Scaffold(
      appBar: AppBar(
        title: Text("Users Detail"),
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
                  initialValue: _username,
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
                    _username = value!;
                  },
                ),
                TextFormField(
                  initialValue: _firstName,
                  decoration: InputDecoration(
                    labelText: "First Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an firstName";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
                TextFormField(
                  initialValue: _lastName,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Last Name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
                TextFormField(
                  initialValue: widget.IUsers.contact,
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
                TextFormField(
                  initialValue: _address,
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a addresss";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
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
                      onPressed: () async {
                        print(widget.IUsers.id);
                        if (widget.IUsers.id != null) {
                          bool res =
                              await deleteUserFromFireStore(widget.IUsers.id!);

                          if (res) {
                            // signout();
                            deleteUser(widget.IUsers.authID!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Successfully deleted account")));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLogin()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Error while deleting users")));
                          }

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
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
