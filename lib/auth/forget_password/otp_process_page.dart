import 'package:blood_donation/auth/forget_password/change_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class otp_Verificatioon extends StatelessWidget {
  var email;
  otp_Verificatioon({this.email});
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('User_Bio_Data');

    return Scaffold(
        appBar: AppBar(title: Text('Otp Page')),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              var PhoneNo = data['PhoneNumber'];

              return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePass(
                                  email: email,
                                )));
                  },
                  child: Text('Proceed'));
            }

            return Text("loading");
          },
        ));
  }
}
