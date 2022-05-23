import 'package:flutter/material.dart';
import 'package:mytutor/model/user.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required User user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  late double screenHeight, screenWidth;
  bool remember = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
      appBar: AppBar(
        title: const Text('MyTutor'),
      ));
  }
}