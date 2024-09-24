import 'package:bao_register/auth_implemetation/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String verificationId = "";

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String phone) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseFirestore.collection("users").get().then((event) => {
            for (var doc in event.docs)
              {
                if (phone.toString() == doc.data()["phone"].toString())
                  {print("This phone number is occupied.")}
                else
                  {
                    _firebaseFirestore
                        .collection("user")
                        .doc("uid")
                        .set({"email": email, "phone": phone})
                  }
              }
          });
    } on FirebaseAuthException catch (ex) {
      print("Something went wrong");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthService().fetchData();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (ex) {
      print("Something went wrong");
    }
    return null;
  }
}
