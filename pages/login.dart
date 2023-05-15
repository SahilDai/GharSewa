import 'package:day35/helper/show_dialog.dart';
import 'package:day35/pages/admin_home.dart';
import 'package:day35/services/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:day35/pages/select_service.dart';
import 'package:flutter/material.dart';
import 'package:day35/pages/register.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool isLoggedIn;
  late String resMessage;
  int success = 1;
  String useremail = "";

  String _dropdownVal = "plumber";
  List<String> _dropdownItems = <String>[
    'plumber',
    'cleaner',
    'electrician',
    'painter',
    'carpenter',
    'gardener'
  ];

  void login() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        success = 2;
        useremail = user.email!;
      });
    } else {
      setState(() {
        success = 3;
      });
    }
  }

  void loginUser() async {
    final bool isUserValid = await validateIfUserExistOrNo(
        _emailController.text, _passwordController.text);

    if (isUserValid) {
      setState(() {
        isLoggedIn = true;
        useremail = _emailController.text;
        resMessage = "Successfully logged in";

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(resMessage)));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectService()));
      });
    } else {
      setState(() {
        isLoggedIn = false;
        resMessage = "Incorrect email and password";

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(resMessage)));
        showDialogLocal("Error", resMessage, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF96d3d3),

      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/loginbg.jpg'),
      //     fit: BoxFit.cover,
      //     colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
      //   ),
      // ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Ghar',
                      style: TextStyle(
                          color: Color(0xFFEDEEC9),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      'sewa',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              // padding: const EdgeInsets.only(top: 50),
              // padding: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.4),

              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: _emailController,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email/number",
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: const TextStyle(),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: (() => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Register()),
                                  ),
                                }),
                            child: Text(
                              "Forget password?",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
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
                                  (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
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

                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                loginUser();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fixedSize: const Size(200, 45),
                                elevation: 5.0,
                                backgroundColor: const Color(0xFFEDEEC9),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),

                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                print("NAVIGATE TO ADMIN LOGIN PAGE");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminWidget()));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fixedSize: const Size(200, 45),
                                elevation: 5.0,
                                backgroundColor: const Color(0xFFEDEEC9),
                              ),
                              child: const Text(
                                "Admin login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(6),
                        //   child: Text(
                        //     success == 1
                        //         ? ''
                        //         : (success == 2
                        //             ? 'Account created successfully$useremail'
                        //             : 'Login failed'),
                        //     style: const TextStyle(
                        //         color: Colors.green,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Sign in',
                        //       style: TextStyle(
                        //           fontSize: 27,
                        //           fontWeight: FontWeight.w700,
                        //           color: Colors.white),
                        //     ),
                        //     CircleAvatar(
                        //       radius: 30,
                        //       backgroundColor: const Color(0xff4c505b),
                        //       child: IconButton(
                        //           color: Colors.white,
                        //           onPressed: () async {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const MyApp()),
                        //             );
                        //           },
                        //           icon: const Icon(
                        //             Icons.arrow_forward,
                        //           )),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Create new account?"),
                            GestureDetector(
                              onTap: (() => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()),
                                    ),
                                  }),
                              child: Text(
                                "Register now",
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
