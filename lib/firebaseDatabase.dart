import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  String name="";
  String password="";
  String email="";
  String hostel = "none";
  String phone="";
  String tempString="";

  Future sendUserData() async {
    final obj = FirebaseFirestore.instance;
    try {
      if (name == "" || phone == "" || email == "" || password == "") {
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

  void getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = FirebaseFirestore.instance;
    var obj;
    try {
      obj = firebaseAuth.currentUser;
      email = obj.email;
      var x =
          await user.collection("users").where("email", isEqualTo: email).get();
      x.docs.forEach((element) {
        name = element.get("name");
        phone= element.get("phone");
        hostel = element.get("hostel");
      });//TODO: no error taking functionality
      
    } catch (e) {
      print(e);
    }
  }

  void logoutUser() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
  }
}
