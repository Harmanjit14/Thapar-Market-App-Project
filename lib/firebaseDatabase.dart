import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  String name = "";
  String password = "";
  String email = "";
  String hostel = "none";
  String phone = "";
  String tempString = "";
  List<String> urls = [];

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
        phone = element.get("phone");
        hostel = element.get("hostel");
      }); //TODO: no error taking functionality

    } catch (e) {
      print(e);
    }
  }

  void logoutUser() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
  }

  void fireStorage() async {
    final obj = FirebaseStorage.instance.ref().child("/WhatsNew/market.png");
    var url = await obj.getDownloadURL();
    urls.add(url);
    //    StorageReference ref = FirebaseStorage.instance
    //           .ref()
    //           .child("images")
    //           .child("$currentdate.jpg");
    //       StorageUploadTask uploadTask = ref.putFile(imageFile);

    //       Uri downloadUrl = (await uploadTask.future).downloadUrl;
    //       addUser.downloadablelink = downloadUrl.toString();

    //       downloadableUrl = downloadUrl.toString();

//     final ref = FirebaseStorage.instance.ref().child('testimage');
// // no need of the file extension, the name will do fine.
// var url = await ref.getDownloadURL();
// print(url);
  }
}
