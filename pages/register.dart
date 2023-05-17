import 'package:day35/helper/show_dialog.dart';
import 'package:day35/services/firebase_authentication.dart';
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
  final _fullname = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  late bool success;
  late String useremail;
  late String resMessage;

  String _dropdownVal = "users";
  List<String> _dropdownItems = <String>['users', "service provider"];

  void register() async {
    final bool? res = await createNewUserWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    print(res);

    if (res != null && res) {
      setState(() {
        success = res;
        resMessage = "User is created successfully!!!";
        useremail = _emailController.text;

        // success message won't show here!!!!
        showDialogLocal("Success", resMessage, context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyLogin()),
        );
      });
    } else {
      setState(() {
        success = res!;
        resMessage = "Error while creating user!!!";

        // error message is shown properly, no biggie...
        showDialogLocal("Error", resMessage, context);
      });
    }
  }

  // final controller = Get.put(SignUpController());
  // final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(
                    color: Color(0xFFEDEEC9),
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextField(
                              controller: _fullname,
                              style: const TextStyle(color: Colors.black),
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
                                  hintText: "Name",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              // controller: controller.email,
                              style: const TextStyle(color: Colors.black),
                              controller: _emailController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              // controller: controller.password,
                              style: const TextStyle(color: Colors.black),
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              // controller: controller.phoneno,
                              style: const TextStyle(color: Colors.black),
                              controller: _contactController,
                              obscureText: false,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "phone Number",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 161, 145, 145),
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
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey[700]),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                underline: SizedBox.shrink(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _dropdownVal = newValue!;
                                  });
                                },
                                items: _dropdownItems
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        register();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyLogin()),
                                    );
                                  },
                                  style: const ButtonStyle(),
                                  child: Text(
                                    'Already have account?',
                                    style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
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