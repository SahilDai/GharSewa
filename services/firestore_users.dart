import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final firebaseUser = FirebaseFirestore.instance.collection('users');

class UserStruct {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? contact;
  String? address;
  String? email;
  String? type;
  bool? isAvailable;
  String? workType;

  UserStruct({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.contact,
    required this.address,
    required this.email,
    required this.type,
    required this.isAvailable,
    required this.workType,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstname": firstName,
      "lastname": lastName,
      "username": username,
      "contact": contact,
      "email": email,
      "type": type,
      "address": address,
      "isAvailable": isAvailable,
      "work_type": workType
    };
  }
}

Future<List<UserStruct>> getAllUsersFromFireStore() async {
  QuerySnapshot querySnapshot = await firebaseUser.get();

  List<UserStruct> users = querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserStruct(
      firstName: data['firstname'],
      lastName: data['lastname'],
      username: data['username'],
      contact: data['contact'],
      email: data['email'],
      type: data['type'],
      address: data['address'],
      isAvailable: data['isAvailable'],
      workType: data['work_type'],
    );
  }).toList();

  return users;
}

void addUsersToFireStore(UserStruct user) async {
  DocumentReference docsRef = await firebaseUser.add(user.toMap());

  docsRef.printInfo();
  print('Added user with ID:>>> ${docsRef.id}');
}


void deleteUserFromFireStore(String userId) async {
  try {
    await firebaseUser.doc(userId).delete();
    print('User with ID $userId deleted successfully!');
  } catch (e) {
    print('Error deleting user: $e');
  }
}

void updateUserFromFireStore(String userId, UserStruct user) async {
  try {
    await firebaseUser.doc(userId).update(user.toMap());
    print('User with ID $userId updated successfully!');
  } catch (e) {
    print('Error updating user: $e');
  }
}
