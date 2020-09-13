import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  String username;
  String password;
  String userId;
  String email;
  String message;
  String tempPhone;
  String tempString;
  void setName(String uname) {
    username = uname;
  }

  void setEmail(String uname) {
    email = uname;
  }

  void setUserId(String uname) {
    userId = uname;
  }

  void setPass(String uname) {
    password = uname;
  }

  void conPrint() {
    print(email);
    print(password);
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
