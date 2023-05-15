import 'package:day35/pages/admin_view_all_worker.dart';
import 'package:day35/services/firestore_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddWorkerWidget extends StatefulWidget {
  const AddWorkerWidget({Key? key}) : super(key: key);

  @override
  _AddWorkerState createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorkerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _contact = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();
  bool? _isLoading;

  String _dropdownVal = "plumber";
  List<String> _dropdownItems = <String>[
    'plumber',
    'cleaner',
    'electrician',
    'painter',
    'carpenter',
    'gardener'
  ];

  @override
  void initState() {
    super.initState();

    // Set up animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Set up animation
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void addNewWorker() async {
    UserStruct user = new UserStruct(
        firstName: _firstName.text,
        lastName: _lastName.text,
        contact: _contact.text,
        email: _email.text,
        address: _address.text,
        username: _firstName.text + "1" + _lastName.text + "W",
        type: "worker",
        isAvailable: true,
        workType: _dropdownVal.toLowerCase());

    addUsersToFireStore(user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF96d3d3),
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
                'Add workers',
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
                              controller: _firstName,
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
                                  hintText: "First Name",
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
                              controller: _lastName,
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
                                  hintText: "Last Name",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
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

                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              // controller: controller.password,
                              style: const TextStyle(color: Colors.black),
                              controller: _contact,
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
                                  hintText: "Contact Number",
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
                              controller: _email,
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
                                  hintText: "Email Address (Optional)",
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
                              controller: _address,
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
                                  hintText: "Current Living Location",
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
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  onPressed: () {
                                    print("Add worker here!!!");
                                    addNewWorker();
                                    // loginUser();
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
                                    "Add worker",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
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
                                              const ViewAllWorker()),
                                    );
                                  },
                                  style: const ButtonStyle(),
                                  child: Text(
                                    'View All Workers',
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
