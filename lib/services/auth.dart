import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanlink_project/models/user.dart';
import 'package:logger/logger.dart';
import 'package:urbanlink_project/database/user_database_service.dart';

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
            userId: user.uid,
            userName:
                user.displayName is String ? user.displayName as String : '',
            userEmail: user.email is String ? user.email as String : '',
            userExplanation: '',
          )
        : MyUser(
            userId: '0x00', userName: '', userEmail: '', userExplanation: '');
  }

  //Stream for FirbaseUser

  //Register With Email & Password
  Future<MyUser?> registerWithEmailAndPassword(
      String name, String email, String pass) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      user = _userFromFirebaseUser(userCredential.user);

      //Create a new document for the user with the uid
      await UserDatabaseService.createUser(
          uid: user!.userId, name: name, email: email, explanation: '');
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

  //Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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

  Future<void> updateUserName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }

  Future<void> updateUserPassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePassword(password);
  }

  Future<void> deleteUser() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }
}
