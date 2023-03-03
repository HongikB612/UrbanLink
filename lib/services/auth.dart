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
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  //Sign In With Email & Password
  Future<MyUser?> signInWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      user = _userFromFirebaseUser(userCredential.user);
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //Sign In Anonymously
  Future<MyUser?> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      user = _userFromFirebaseUser(userCredential.user);
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      await _auth.signOut();
      user = null;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
