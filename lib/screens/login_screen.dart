// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registration01/screens/home_screen.dart';
import 'package:registration01/screens/registration_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //edition controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validetor
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) {
        if(value!.isEmpty) {
          return ("Email is required");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
          return ("Enter valid email");
        }
        return null;
      },
      
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //validetor
      validator: (valid) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if(valid!.isEmpty) {
          return ("Password is required");
        }
        if(!regExp.hasMatch(valid)) {
          return ("Password min 6 Character");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
        signIn(emailController.text, passwordController.text);
        },
        child: Text(
          'Login', textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
      ),
    );
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Login To TAGAZTT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                    SizedBox(
                      height: 150,
                      child: CircleAvatar(
                        backgroundImage: 
                        AssetImage('assets/logos/photo.jpg'),
                        radius: 55,
                        )
                      ),
                    SizedBox(
                      height: 35,
                    ),
                    emailField,
                    SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    SizedBox(
                      height: 15,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                          ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => 
                              RegistrationScreen()
                              ),
                              );
                          },
                          child: Text(
                            'SingUp',
                            style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                             color: Colors.blue
                            ),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  // login function
  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
                 .then((ui) => {
                   Fluttertoast.showToast(msg: "Login success"),
                   Navigator.of(context)
                   .pushReplacement(MaterialPageRoute(
                     builder: (context) => HomeScreen()))
                 }).catchError((e) {
                   Fluttertoast.showToast(msg: "User not found");
                 });
    }
  }
}