import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class ChangePass extends StatelessWidget {
  var email;
  ChangePass({this.email});
  CollectionReference users =
      FirebaseFirestore.instance.collection('User_Bio_Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Center(child: Text("Email does not exist"));
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
                          print(email);
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email)
                              .then((value) {
                            print('Email sent');
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Check in your mail box for spam messages"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ));
                          }).onError((error, stackTrace) {
                            print(error);
                          });
                        },
                        child: Text('Send update link')),
                  ],
                ),
              );
            }

            return Center(child: Text("loading"));
          },
        ));
  }
}
