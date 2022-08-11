import 'package:dream/sign_up.dart';
import 'package:dream/authenticate.dart';
import 'package:dream/home.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var formKey=GlobalKey<FormState>();

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  String emailError='Enter your Email';
  String emailInvalidError='Enter a valid email';
  String passwordError='Enter Password';

  void clearText(){
    email.clear();
  }
  bool _obscureText= true;
  final GoogleSignInProvider signIn= GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign In'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    // ignore: missing_return
                    validator: (String? value) {
                      if(value==null){
                        return emailError;
                      }else {
                        if(!value.contains("@")){
                          return emailInvalidError;
                        }
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: clearText),
                        errorStyle: const TextStyle(
                          fontSize: 15.0,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0))
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: password,
                    // ignore: missing_return
                    validator: (String? value) {
                      if(value==null){
                        return passwordError;
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        suffixIcon: IconButton(
                            icon: _obscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            onPressed: (){
                              setState(() =>_obscureText=!_obscureText);
                            }),
                        errorStyle: const TextStyle(
                          fontSize: 15.0,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0))
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: null,
                        child: const Text("*Forgot Password*",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    bool condition=await signInWithEmail(email.text,password.text);
                    if(formKey.currentState!.validate()) {
                      if(condition){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            }));
                      }
                    }
                  },
                  child: const Text("Log in"),
                ),
                ElevatedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: (){
                      signIn.googleLogIn(context);
                    },
                    icon: Image.asset('assets/google-logo.png', width: 30.0, height: 30.0,),
                    label: const Text("Google", style: TextStyle(color: Colors.black),)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an Account ? "),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const SignUp();
                              }));
                        },
                        child: const Text("Sign Up",
                          style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
