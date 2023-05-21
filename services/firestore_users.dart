import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String? authID;

  UserStruct({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.contact,
    required this.address,
    required this.email,
    required this.type,
    required this.isAvailable,
    required this.workType,
    this.authID,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstname": firstName,
      "lastname": lastName,
      "username": username,
      "contact": contact,
      "email": email,
      "type": type,
      "address": address,
      "isAvailable": isAvailable,
      "work_type": workType,
      "authID": authID
    };
  }
}

Future<List<UserStruct>> getAllUsersFromFireStore(String getType) async {
  QuerySnapshot querySnapshot = await firebaseUser.get();

  List<UserStruct> users = querySnapshot.docs
      .map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserStruct(
          id: doc.id,
          firstName: data['firstname'],
          lastName: data['lastname'],
          username: data['username'],
          contact: data['contact'],
          email: data['email'],
          type: data['type'],
          address: data['address'],
          isAvailable: data['isAvailable'],
          workType: data['work_type'],
          authID: data['id'],
        );
      })
      .where((element) => element.type == getType)
      .toList();

  return users;
}

Future<UserStruct?> getUsersFromFirestore(String uid) async {
  QuerySnapshot snapshot = await firebaseUser.get();
  List<UserStruct> users = snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserStruct(
        id: doc.id,
        firstName: data['firstname'],
        lastName: data['lastname'],
        username: data['username'],
        contact: data['contact'],
        email: data['email'],
        type: data['type'],
        address: data['address'],
        isAvailable: data['isAvailable'],
        workType: data['work_type'],
        authID: data['authID']);
  }).toList();

  UserStruct? user = users.firstWhere((e) => e.authID == uid);
  return user;
}

Future<String> addUsersToFireStore(UserStruct user) async {
  DocumentReference docsRef = await firebaseUser.add(user.toMap());

  docsRef.printInfo();
  return docsRef.id;
}

Future<bool> deleteUserFromFireStore(String userId) async {
  try {
    await firebaseUser.doc(userId).delete();
    print('User with ID $userId deleted successfully!');

    return true;
  } catch (e) {
    print('Error deleting user: $e');

    return false;
  }
}

Future<bool> updateUserFromFireStore(String userId, UserStruct user) async {
  try {
    await firebaseUser.doc(userId).update(user.toMap());
    print('User with ID $userId updated successfully!');

    return true;
  } catch (e) {
    print('Error updating user: $e');

    return false;
  }
}

void signout() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("Error while logging out user: $e ");
  }
}
