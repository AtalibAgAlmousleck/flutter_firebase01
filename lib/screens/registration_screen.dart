// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registration01/model/user_model.dart';
import 'package:registration01/screens/home_screen.dart';
import 'package:registration01/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

   //our form key
  final _formKey = GlobalKey<FormState>();

  // firebase authentication
  final _auth = FirebaseAuth.instance;

  //editing controllers
  final TextEditingController firstNameEditingController = new TextEditingController();
  final TextEditingController lastNameEditingController = new TextEditingController();
  final TextEditingController emailEditingController = new TextEditingController();
  final TextEditingController passwordEditingController = new TextEditingController();
  final TextEditingController confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //firstname field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      //validator
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if(value!.isEmpty) {
          return ("Firstname cannot be empty");
        }
          if(!regExp.hasMatch(value)) {
            return ("Firstname min 4 Characters");
          }
          return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "FirstName",
        labelText: "First-name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );

    //last name field
    final lastnameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      //validator
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if(value!.isEmpty) {
          return ("Lastname cannot be empty");
        }
        if(!regExp.hasMatch(value)) {
          return ("Lastname min 4 Characters");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Lastname",
        labelText: "Last-name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailEditingController.text = value!;
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
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        labelText: "E-mail",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if(value!.isEmpty) {
          return ("Password is required");
        }
        if(!regExp.hasMatch(value)) {
          return ("Password min 6 Character");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        labelText: "P-assword",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      validator: (value) {
        if(confirmPasswordEditingController.text !=
           passwordEditingController.text) {
             return ("Confirm your password");
           }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        hintText: "Confirm Password",
        labelText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    //submit button
    final singUpButton = Material(
      elevation: 5,
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
        signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
        'SignUp', textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),    
    ),
        ),
  );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
            ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                child: Column(
                  key: _formKey,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/logos/photo.jpg'),
                        radius: 58,
                      ),
                    ),
                    firstNameField,
                    SizedBox(
                      height: 25,
                    ),
                    lastnameField,
                    SizedBox(
                      height: 20,
                    ),
                    emailField,
                    SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    SizedBox(
                      height: 20,
                    ),
                    confirmPasswordField,
                    SizedBox(
                      height: 20,
                    ),
                    singUpButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Have an account',
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
                            context, MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                        ),
                        );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                             color: Colors.blue
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }


  // signUp function
  void signUp(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailsToFirebasestore()
          }).catchError((e) {
            Fluttertoast.showToast(msg: e!.message);
          });
    }
  }

  // google firebasestore
  postDetailsToFirebasestore() async {
    // calling our firebasestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    // calling our user model
    UserModel userModel = UserModel();
    // writting all the logic
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = lastNameEditingController.text;
    //userModel.password = passwordEditingController.text;
    // sending these value to google firebase
    await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created");
    Navigator.pushAndRemoveUntil(
      (context), 
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false
      );
  }

}