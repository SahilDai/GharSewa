// import 'dart:async';

// import 'package:day35/pages/admin_add_worker.dart';
// import 'package:day35/pages/admin_view_all_users.dart';
// import 'package:day35/pages/admin_view_all_worker.dart';
// import 'package:day35/services/firestore_users.dart';
// import 'package:flutter/material.dart';

// class AdminWidget extends StatefulWidget {
//   const AdminWidget({Key? key}) : super(key: key);

//   @override
//   _AdminWidgetState createState() => _AdminWidgetState();
// }

// class _AdminWidgetState extends State<AdminWidget> {
//   bool _isLoading = false;

//   Future<void> _showLoading() async {
//     setState(() {
//       _isLoading = true;
//     });
//     await Future.delayed(Duration(milliseconds: 10)); // Wait for 1-2 seconds
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin's widget"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to Admin',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 UserStruct user = new UserStruct(
//                     firstName: "firstName",
//                     lastName: "lastName",
//                     username: "firstUser",
//                     email: "test124@gmail.com",
//                     contact: "123456",
//                     type: "admin",
//                     address: "Place where i live",
//                     isAvailable: false,
//                     workType: "");

//                 print("Navigating to add worker widget");
//                 await _showLoading(); // Show loading indicator
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const AddWorkerWidget()));
//                 // addUsersToFireStore(user);
//               },
//               child: const Text('Add worker'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 print("DO WHATEVER YOU WANT....");
//                 await _showLoading(); // Show loading indicator
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ViewAllUser()));
//               },
//               child: const Text('View all Users'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 print("DO WHATEVER YOU WANT....");
//                 await _showLoading(); // Show loading indicator
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ViewAllWorker()));
//               },
//               child: const Text('View all workers'),
//             ),
//             const SizedBox(height: 20),
//             if (_isLoading)
//               CircularProgressIndicator(), // Show loading indicator
//           ],
//         ),
//       ),
//     );
//   }
// }
