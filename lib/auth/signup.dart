import 'package:blood_donation/auth/loginpage.dart';
import 'package:blood_donation/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isHidden = true;
  bool _ishidden1 = true;
  var visible = "";
  var visible1 = "";

  TextEditingController _Usernamecontroller = TextEditingController();

  TextEditingController _Emailcontroller = TextEditingController();

  TextEditingController _Passwordcontroller = TextEditingController();

  TextEditingController _RePasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Ink(
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
          child: SafeArea(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(210, 240, 23, 23),
                        Color.fromARGB(210, 234, 161, 161),
                        Color.fromARGB(210, 211, 199, 199),
                        Color.fromARGB(210, 52, 47, 47),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Text(
                      'BLOOD DONATION',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cinzel',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _Emailcontroller,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Enter New Login Id',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.person_add,
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
                    controller: _Passwordcontroller,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
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
                        filled: true,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _RePasswordcontroller,
                    obscureText: _ishidden1,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        suffixIcon: visible1 == ""
                            ? InkWell(
                                onTap: () {
                                  _togglePasswordView1();
                                  visible1 = "1";
                                },
                                child: Icon(
                                  Icons.visibility_off,
                                  size: 25,
                                ))
                            : InkWell(
                                onTap: () {
                                  _togglePasswordView1();
                                  visible1 = "";
                                },
                                child: Icon(
                                  Icons.visibility,
                                  size: 25,
                                )),
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(236, 13, 53, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(120, 50),
                    ),
                    onPressed: () {
                      if (_Passwordcontroller.text ==
                          _RePasswordcontroller.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _Emailcontroller.text.trim(),
                                password: _Passwordcontroller.text.trim())
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register())))
                            .onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("ERROR ${error.toString()}"),
                            behavior: SnackBarBehavior.floating,
                          ));
                          print("ERROR ${error.toString()}");
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("ERROR : Passwords should be same"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text('   Register   ')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Have an account?',
                        style: TextStyle(fontSize: 13, color: Colors.white)))
              ],
            )),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _togglePasswordView1() {
    setState(() {
      _ishidden1 = !_ishidden1;
    });
  }
}
