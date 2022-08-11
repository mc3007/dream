import 'package:dream/authenticate.dart';
import 'package:dream/main_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: ()async{
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
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
