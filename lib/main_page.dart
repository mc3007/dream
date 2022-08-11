import 'package:dream/sign_up.dart';
import 'package:dream/login.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/Apple_Logo.png",width: 150,height: 150,),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignUp();
                      }));
                },
                child: const Text("Sign Up")),
            const Text("OR", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LogIn();
                      }));
                },
                child: const Text("Log In"))
          ],
        ),
      ),
    );
  }
}
