import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHandler {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<UserCredential> createUser(
      String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> loginUser(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
