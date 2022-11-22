import 'dart:math';

import 'package:blood_donation/admin/adminDashboard.dart';
import 'package:blood_donation/auth/forget_password/get_email.dart';
import 'package:blood_donation/auth/phone_number_verification.dart';
import 'package:blood_donation/auth/register.dart';
import 'package:blood_donation/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_helper/firebase_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String adminLog = "admin@email.com";
  bool _isHidden = true;
  var visible = "";

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    String AdminLogin = "admin@email.com";
    // print(
    //   "the current width is" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Stack(children: [
        Ink(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(210, 240, 23, 23),
              Color.fromARGB(210, 234, 161, 161),
              Color.fromARGB(210, 211, 199, 199),
              Color.fromARGB(210, 52, 47, 47),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 75 * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cinzel',
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          label: Text('Enter Login Id'),
                          hintText: 'something@gmail.com',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: passwordcontroller,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          suffixIcon: visible == ""
                              ? InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "1";
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    size: 25,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "";
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    size: 25,
                                  )),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.keyboard,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(100, 30),
                      ),

                      // color: Color.fromRGBO(205, 189, 223, 1),
                      onPressed: () async {
                        setState(() {});
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        if (emailcontroller.text.isNotEmpty &&
                            passwordcontroller.text.isNotEmpty) {
                          if (emailcontroller.text == adminLog) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: adminLog,
                                    password: passwordcontroller.text)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDashboard()));
                            }).onError((error, stackTrace) {
                              service.errorBox(context, "Invalid input");
                            });
                          } else {
                            service.loginUser(
                                context,
                                emailcontroller.text.trim(),
                                passwordcontroller.text);
                            pref.setString(
                                "email", emailcontroller.text.trim());
                          }
                        } else {
                          service.errorBox(context,
                              "Fields must not empty ,please provide valid email and password");
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10 / 2),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GetEmail()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ))),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 10 / 2),
                      //   child: Container(
                      //       alignment: Alignment.bottomRight,
                      //       child: TextButton(
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) => SignUp()));
                      //           },
                      //           child: Text(
                      //             "Don't have an Account?   ",
                      //             style: TextStyle(
                      //                 fontSize: 13, color: Colors.black),
                      //           ))),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
