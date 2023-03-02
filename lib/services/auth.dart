import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? user;
  static final AuthService instance = AuthService._internal();

  factory AuthService() {
    return instance;
  }
  AuthService._internal();

  //Extract needed information
  MyUser _userFromFirebaseUser(User? user) {
    return user != null
        ? MyUser(
            id: user.uid,
            name: user.displayName,
            email: user.email,
          )
        : MyUser(id: '0x00', name: '');
  }

  //Stream for FirbaseUser

  //Register With Email & Password
  Future<MyUser?> registerWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      user = _userFromFirebaseUser(userCredential.user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.i('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.i('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  //Sign In With Email & Password
  Future<MyUser?> signInWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      user = _userFromFirebaseUser(userCredential.user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.i('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.i('Wrong password provided for that user.');
      }
      return null;
    }
  }

  //Sign In Anonymously
  Future<MyUser?> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      user = _userFromFirebaseUser(userCredential.user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.i('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.i('Wrong password provided for that user.');
      }
      return null;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      await _auth.signOut();
      user = null;
    } on FirebaseAuthException catch (e) {
      logger.e("Something went wrong in SignOut");
    }
  }
}
