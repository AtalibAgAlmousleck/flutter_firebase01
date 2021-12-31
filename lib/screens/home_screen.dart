// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:registration01/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/photo.jpg'),
                  radius: 65,
                ),
              ),
              Text(
                'Welcome Home',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
                ),
              ),
              ActionChip(
                elevation: 5,
                label: Text('Logout'), 
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => LoginScreen()
                      ),
                   );
                }
                ),
            ],
          ),
        ),
    ),
    );
  }
}