import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/authenticate.dart';
import 'package:dream/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);
  String name = "no name";
  int age = 00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DREAM"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellowAccent
                ),
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                  future: readData(),
                  builder: (context, snapshot){
                    return Column(
                      children: <Widget>[
                        const Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                        Text(name),
                        Text(age.toString())
                      ],
                    );
                    //return  const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:()async{
          bool condition = await signOut();
          if (condition) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return MainPage();
              }),
                  (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout),
        label: const Text("Logout"),
        tooltip: "Logout",
      ),
    );
  }
  readData() async{
    await ref.get().then((userData){
      name = userData['name'];
      age = userData['age'];
    });
  }

}