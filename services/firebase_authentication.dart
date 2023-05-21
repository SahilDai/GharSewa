import "package:day35/pages/login.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

final FirebaseAuth auth = FirebaseAuth.instance;
Future<Map<String, dynamic>> createNewUserWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    String? authID = user?.uid;
    return {'success': true, 'uid': authID};
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("Password is too short, write a BBC");
      return {'success': false, 'error': 'weak-password'};
    } else if (e.code == 'email-already-in-use') {
      print("Email address already in use, try forget password to reset");
      return {'success': false, 'error': 'email-already-in-use'};
    }
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }

  return {'success': false, 'error': 'Unknown error occurred'};
}

Future<Map<String, dynamic>> validateIfUserExistOrNo(
    String email, String password) async {
  try {
    UserCredential userCred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCred.user;
    return {'success': true, 'uid': user?.uid};
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return {'success': false, 'uid': Null};
    } else if (e.code == 'wrong-password') {
      return {'success': false, 'uid': Null};
    }
  } catch (e) {
    return {'success': false, 'uid': Null};
  }
  return {'success': false, 'uid': Null};
}

deleteUser(String uid) async {
  print(uid);
  print("USER IDDDD");
  User? user = auth.currentUser;
  if (user != null && user.uid == uid) {
    await user.delete();
    print('User account deleted successfully');
  } else {
    print('User not found or UID does not match');
  }
}

Widget checkIfUserLoggedIn(Widget childWidget) {
  return StreamBuilder(
    stream: auth.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // still loading
        return CircularProgressIndicator();
      } else if (snapshot.hasData) {
        // logged in user
        print("User is Logged-In");
        return childWidget;
      } else {
        print("User is Not logged-In");
        return MyLogin();
      }
    },
  );
}
