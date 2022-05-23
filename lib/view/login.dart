import 'package:flutter/material.dart';
import 'package:mytutor/view/mainpage.dart';
import 'package:mytutor/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:mytutor/config.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if(screenWidth >= 800) {ctrwidth = screenWidth / 1.5;}
    if(screenWidth < 800) {ctrwidth = screenWidth;}
     
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(width: ctrwidth, 
            child: Form(key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 2.5,
                          width: screenWidth, 
                          child: Image.asset('assets/images/logo.png')
                        ),
                        const Text("User Login", style: TextStyle(fontSize:24),),

                        Padding(
                          padding:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller : emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if(value == null || value.isEmpty) {return 'Please enter valid email';}
                              bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                              ).hasMatch(value);

                              if(!emailValid) {return 'Please enter valid email';}
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Padding(
                          padding:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              )
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if(value == null || value.isEmpty) {return 'Please enter your password';}
                              if(value.length < 6) {return "Password must be at lease 6 characters";}
                              return null;
                            },
                          ),
                        ),
                        
                        Row(
                          children: [
                            Checkbox(
                              value: remember, 
                              onChanged: (bool? value) {
                                _onRememberMe(value!);
                              },
                            ),
                              const Flexible(
                                child: Text("Remember me", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold,)),
                            ), 
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            ElevatedButton(
                              onPressed: loginUser,
                              child: const Text('Login'),
                            ),
                          ]
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                    builder: (BuildContext context) => const RegisterPage()
                                  )
                                )
                              },
                              child: const Text(
                                "Create New Account", 
                                style: TextStyle(fontSize:16.0,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        )
      ),
    );
  }

  void _onRememberMe(bool value) {
    remember = value;
    setState(() {
      if(remember) {saveRemovePref(true);}
      else {saveRemovePref(false);}
    });
  }

  void loginUser() {
    String email = emailController.text;
    String password = passwordController.text;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    http.post(
      Uri.parse(Config.server + "../slumshop/mobile/php/login_user.php"),
      body: {"email": email, "password": password}).then(
        (response) {
          var data = jsonDecode(response.body);
          if (response.statusCode == 200 && data['status'] == 'success') {
            User user = User.fromJson(data['data']);
              
            Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainPage(
                  user: user,
                )
              )
            );
          } else {
            Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
            );
          }
        }
      );
    }

  void saveRemovePref(bool value) async {
    if (!formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String email = emailController.text;
      String password = passwordController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if(value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('remember', true);
        Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0
        );
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool("remember", false);
        emailController.text = "";
        passwordController.text = "";
        Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0
        );
      } 
    } else {
      Fluttertoast.showToast(
        msg: "Preference Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0
      );
      remember = false;
    }
  } 

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;

    if (remember) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
        remember = true;
      });
    }
  }
}