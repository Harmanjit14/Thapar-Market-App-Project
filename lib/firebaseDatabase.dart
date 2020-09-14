import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  String name;
  String password;
  String email;
  String hostel = "none";
  String phone;
  String tempString;

  Future sendUserData() async {
    final obj = FirebaseFirestore.instance;
    try {
      if (name == null || phone == null || email == null || password == null) {
        throw "error";
      } else {
        obj.collection('users').add({
          'name': name,
          'phone': phone,
          'hostel': hostel,
          'email': email,
          'password': password
        });
      }
    } catch (e) {
      return e;
    }
  }

  Future registerUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var temp;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      temp = e;
    }
    return temp;
  }

  Future loginUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var temp;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      temp = e;
    }
    return temp;
  }
}
