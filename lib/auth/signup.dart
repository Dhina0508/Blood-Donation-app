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
              Color.fromARGB(210, 223, 52, 52),
              Color.fromARGB(210, 234, 161, 161),
              Color.fromARGB(210, 234, 161, 161),
              Color.fromARGB(210, 223, 52, 52),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
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
                        Color.fromARGB(221, 241, 32, 32),
                        Color.fromARGB(234, 219, 33, 219),
                        Color.fromARGB(210, 52, 18, 175),
                        Color.fromARGB(210, 52, 18, 175),
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
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
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            Icons.visibility,
                            size: 25,
                          ),
                        ),
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
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            Icons.visibility,
                            size: 25,
                          ),
                        ),
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
}
