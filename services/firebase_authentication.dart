import "package:day35/pages/login.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

final FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> createNewUserWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;
    print(user);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("Password is too short, write a BBC");
      return false;
    } else if (e.code == 'email-already-in-use') {
      print("Email address already in use, try forget password to reset");
      return false;
    }
  } catch (e) {
    return false;
  }

  return false;
}

Future<bool> validateIfUserExistOrNo(String email, String password) async {
  try {
    print("LOGGING-USER-TO-PAGE");
    UserCredential userCred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCred.user;
    print(user);
    print("SUCCESS");
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print("User not found....");
      return false;
    } else if (e.code == 'wrong-password') {
      print("wrong password");
      return false;
    }
  } catch (e) {
    return false;
  }
  return false;
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
