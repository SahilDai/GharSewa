import 'package:day35/helper/show_dialog.dart';
import 'package:day35/services/firebase_authentication.dart';
import 'package:day35/services/firestore_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:day35/pages/login.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

// maintain State of the class
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  late String isServiceProviderSelected = "";
  late bool success;
  late String useremail;
  late String resMessage;
  late bool _showAdditionalDropdown = false;

  String _dropdownVal = "users";
  List<String> _dropdownItems = <String>['users', "service provider"];

  String _dropdownWorker = "plumber";
  List<String> _dropdownWorkerItem = <String>[
    'plumber',
    'cleaner',
    'electrician',
    'painter',
    'carpenter',
    'gardener'
  ];

  void register() async {
    final Map<String, dynamic> res = await createNewUserWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    if (res["success"]) {
      UserStruct user = new UserStruct(
        id: res["uid"],
        firstName: _firstName.text,
        lastName: _lastName.text,
        username: _firstName.text + "@" + _lastName.text,
        contact: _contactController.text,
        address: _addressController.text,
        email: _emailController.text,
        type: _dropdownVal,
        isAvailable: true,
        workType: isServiceProviderSelected,
      );

      addUsersToFireStore(user);
      setState(() {
        success = res["success"];
        resMessage = "User is created successfully!!!";
        useremail = _emailController.text;
        showDialogLocal("Success", resMessage, context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyLogin()),
        );
      });
    } else {
      setState(() {
        success = res["success"];
        resMessage = "Error while creating user!!!";
        showDialogLocal("Error", resMessage, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xFFEDEEC9),
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _firstName,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _lastName,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Last Name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _addressController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _contactController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Contact',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _dropdownVal,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  underline: SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownVal = newValue!;

                      if (newValue == 'service provider') {
                        _showAdditionalDropdown = true;
                      } else {
                        _showAdditionalDropdown = false;
                      }
                    });
                  },
                  items: _dropdownItems.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(height: 20),
              _showAdditionalDropdown
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: _dropdownWorker,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.grey[700]),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        underline: SizedBox.shrink(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownWorker = newValue!;
                            isServiceProviderSelected = newValue;
                          });
                        },
                        items: _dropdownWorkerItem
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : SizedBox.shrink(),
              // Empty container when _showAdditionalDropdown is false
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  register();
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLogin()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// EXTRA
// final User? user = (await auth.createUserWithEmailAndPassword(
//             email: _emailController.text, password: _passwordController.text))
//         .user;

//     if (user != null) {
//       setState(() {
//         success = true;
//         useremail = user.email!;

//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const MyLogin()),
//         );
//       });
//     } else {
//       setState(() {
//         success = false;
//       });
//     }