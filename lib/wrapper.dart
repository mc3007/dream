import 'package:dream/home.dart';
import 'package:dream/login.dart';
import 'package:dream/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentState extends StatelessWidget {

  const CurrentState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var state=FirebaseAuth.instance.currentUser;
    return state!=null ? const HomePage() : const MainPage();
  }
}