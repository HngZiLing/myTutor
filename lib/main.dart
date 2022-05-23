import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytutor/view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTutor',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MySplashScreen(title: "MyTutor"),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);
  @override
  State<MySplashScreen> createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("MyTutor", style: TextStyle(color: Colors.white)),
              CircularProgressIndicator(backgroundColor: Colors.grey, valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
              Text("Version 0.1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
            ]
          ),
        ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
const Duration(seconds: 5),
      () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (content) => const LoginScreen()))
    );
  }
}