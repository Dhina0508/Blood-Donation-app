import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetEmail extends StatefulWidget {
  GetEmail({super.key});

  @override
  State<GetEmail> createState() => _GetEmailState();
}

class _GetEmailState extends State<GetEmail> {
  TextEditingController _EmailController = new TextEditingController();
  var ShowOption = "";
  CollectionReference users =
      FirebaseFirestore.instance.collection('User_Bio_Data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Forgot password ? ',
              style: TextStyle(
                  fontFamily: 'JosefinSans', color: Colors.black, fontSize: 27),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please enter your Email Id and we 'll send you a link to get back into your account :",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail), hintText: 'Email Id'),
                controller: _EmailController,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ShowOption == ""
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(236, 13, 53, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(250, 50),
                    ),
                    onPressed: () {
                      if (_EmailController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please Enter a valid Email Id'),
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else {
                        setState(() {
                          ShowOption = "1";
                        });
                      }
                    },
                    child: Text('Verify Email Id'))
                : Container(),
            ShowOption != ""
                ? FutureBuilder<DocumentSnapshot>(
                    future: users.doc(_EmailController.text).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Center(
                            child: Text(
                          "Email does not exist",
                          style: TextStyle(fontSize: 20),
                        ));
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        var PhoneNo = data['PhoneNumber'];

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    print(_EmailController.text);
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _EmailController.text)
                                        .then((value) {
                                      print('Email sent');
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Check your mail box for spam messages"),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.green,
                                      ));
                                    }).onError((error, stackTrace) {
                                      print(error);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 18, 204, 136),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fixedSize: const Size(250, 50),
                                  ),
                                  child: Text('Send update link')),
                            ],
                          ),
                        );
                      }

                      return Center(child: Text("loading"));
                    },
                  )
                : Container()
          ],
        ),
      )),
    );
  }
}
