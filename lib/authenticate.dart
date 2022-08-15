import 'package:dream/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user! ;

  Future<void> googleLogIn(BuildContext context) async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      _user= googleUser;
    } else{
      final googleAuth= await googleUser.authentication ;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if(FirebaseAuth.instance.signInWithCredential(credential)!= null){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            }));
      }
      DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);

      await ref.set({
        "name": googleUser.displayName,
        "age": 00,
      });
      //print(FirebaseAuth.instance.signInWithCredential(credential));
    }
  }
}

Future<bool> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> signUpWithEmail(String email, String password, String name, int age) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);

    await ref.set({
      "name": name,
      "age": age,
    });
    return true;
  } on FirebaseAuthException catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> signOut() async {
  final googleSignIn = GoogleSignIn();
  try {
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    return false;
  }
}

