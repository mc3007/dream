import 'package:dream/authenticate.dart';
import 'package:dream/home.dart';
import 'package:dream/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey=GlobalKey<FormState>();

  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  String nameError='Enter your Name';
  String ageError='Enter your Age';
  String emailError='Enter your Email';
  String emailInvalidError='Enter a valid email';
  String passwordError='Enter Password';

  void clearName(){
    name.clear();
  }
  void clearAge(){
    age.clear();
  }
  void clearText(){
    email.clear();
  }
  bool _obscureText= true;
  final GoogleSignInProvider signUp= GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
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
                    keyboardType: TextInputType.name,
                    controller: name,
                    // ignore: missing_return
                    validator: (String? value) {
                      if(value==null){
                        return nameError;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your Full Name',
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: clearName),
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
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    controller: age,
                    // ignore: missing_return
                    validator: (String? value) {
                      if(value==null){
                        return ageError;
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                        labelText: 'Age',
                        hintText: 'Enter your Age',
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: clearAge),
                        errorStyle: const TextStyle(
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)
                        )
                    ),
                  ),
                ),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0)
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
                ElevatedButton(
                  onPressed: () async{
                    bool condition=await signUpWithEmail(email.text, password.text, name.text, int.parse(age.text));
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
                  child: const Text("Sign Up"),
                ),
                ElevatedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: (){
                      signUp.googleLogIn(context);
                    },
                    icon: Image.asset('assets/google-logo.png', width: 30.0, height: 30.0,),
                    label: const Text("Google", style: TextStyle(color: Colors.black),)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an Account ? "),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LogIn();
                              }));
                        },
                        child: const Text("Log In",
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
