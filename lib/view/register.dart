import 'package:flutter/material.dart';
import 'package:mytutor/view/login.dart';
import 'package:mytutor/config.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}): super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double screenHeight, screenWidth, ctrwidth;
  String pathAsset = 'assets/images/camera.jpeg';
  var image;
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final TextEditingController nameRegController = TextEditingController();
  final TextEditingController emailRegController = TextEditingController();
  final TextEditingController pass1RegController = TextEditingController();
  final TextEditingController pass2RegController = TextEditingController();
  final TextEditingController phoneRegController = TextEditingController();
  final TextEditingController addressRegController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        content(context),
      ],
    );
  }
  
  void dispose() {
    print("dispose was called");
    nameRegController.dispose();
    emailRegController.dispose();
    pass1RegController.dispose();
    phoneRegController.dispose();
    addressRegController.dispose();
    super.dispose();
  }

  Widget content(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {ctrwidth = screenWidth / 1.5;}
    if (screenWidth < 800) {ctrwidth = screenWidth / 1.1;}

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
      ),

      body: SingleChildScrollView(
        child:Center(
          child:SizedBox(
            width:ctrwidth,
            child:Form(
              key: formKey,
              child:Column(
                children: [
                  const Text(
                    "Register New Account",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: GestureDetector(
                      onTap: () => {_takePictureDialog()},
                      child: SizedBox(
                        height: screenHeight / 2.5,
                        width: screenWidth,
                        child: image == null
                        ? Image.asset(pathAsset)
                        : Image.file(image,fit: BoxFit.cover,)
                      )
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  TextFormField(
                    textInputAction: TextInputAction.next, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus1);
                    },
                    controller: nameRegController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.person),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter valid username';}
                      return null;
                    },
                  ),

                  TextFormField(
                    textInputAction: 
                    TextInputAction.next, focusNode: focus1, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus2);
                    },
                    controller: emailRegController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.mail),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      )
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {return 'Please enter valid email';}
                      return null;
                    },
                  ),
                  
                  TextFormField(
                    textInputAction: 
                    TextInputAction.done, focusNode: focus2, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus3);
                    },
                    controller: pass1RegController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.key),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      ),
                    ),
                    obscureText: true,
                  ),

                  TextFormField(
                    textInputAction: 
                    TextInputAction.done, focusNode: focus3, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus4);
                    },
                    controller: pass2RegController,
                    decoration: const InputDecoration(
                      labelText: 'Re-enter Password',
                      icon: Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      )
                    ),
                    obscureText: true,
                    validator: (value) {
                      if(value == null || value.isEmpty) {return 'Please enter valid password';}
                      if(value.length < 6) {return "Password must be at lease 6 characters";}
                      bool passValid = RegExp(
                        pass1RegController.text
                      ).hasMatch(value);
                      if(!passValid) {return 'Please enter valid password';}
                      return null;
                    },
                  ),

                  TextFormField(
                    textInputAction: 
                    TextInputAction.done, focusNode: focus4, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus5);
                    },
                    controller: phoneRegController,
                    decoration: const InputDecoration(
                      labelText: 'Phone No.',
                      icon: Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter valid phone number';}
                      if(value.length > 13){return "Phone number must be less than 13 digit";}
                    return null;
                    },
                  ),

                  TextFormField(
                    textInputAction: 
                    TextInputAction.done, focusNode: focus5, onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus6);
                    },
                    controller: addressRegController,
                    decoration: const InputDecoration(
                      labelText: 'Home Address',
                      icon: Icon(Icons.home),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (width:2.0),
                      )
                    ),
                  ),
                  
                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        minWidth: 115,
                        height: 50,
                        child: const Text('Register'),
                        color: Colors.indigo,
                        elevation: 10,
                        onPressed: register,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already Regitser?",
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                        )
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (BuildContext context) => const LoginScreen()
                            ) 
                          )
                        },
                        child: const Text(
                          "Login here", 
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              )
            )
          )
        ),
      ),
    );
  }

  void register() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title: const Text("Register new Account", style: TextStyle(),),
          content: const Text("Are you sure?",),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select from",),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  _galleryPicker(),
                },
                icon: const Icon(Icons.browse_gallery),
                label: const Text("Gallery")
              ),
              TextButton.icon(
                onPressed: () => {Navigator.of(context).pop(), _cameraPicker()},
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera")
              ),
            ],
          )
        );
      },
    );
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      _cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square,],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );
    if (croppedFile != null) {
      image = croppedFile;
      setState(() {});
    }
  }

  void insertDialog() {
    if (formKey.currentState!.validate() && image != null) {
      formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            title: const Text("Add this product",style: TextStyle(),),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text("Yes", style: TextStyle(),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertProduct();
                },
              ),
              TextButton(
                child: const Text("No", style: TextStyle(),),
                onPressed: () {Navigator.of(context).pop();},
              ),
            ],
          );
        },
      );
    }
  }

  void _insertProduct() {
    String userName = nameRegController.text;
    String userEmail = emailRegController.text;
    String userPassword = pass1RegController.text;
    String userPhone = phoneRegController.text;
    String userAddress = addressRegController.text;
    String base64Image = base64Encode(image!.readAsBytesSync());
    http.post(
      Uri.parse(Config.server + "/slumshop/mobile/php/new_product.php"),
      body: {
        "user_name": userName,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_phone":userPhone,
        "user_address": userAddress,
        "image": base64Image,
      }
    ).then(
      (response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
          );
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
          );
        }
      }
    );
  }
}