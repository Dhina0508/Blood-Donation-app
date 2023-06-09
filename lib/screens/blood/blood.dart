import 'package:blood_donation/bottomnavigation_bar/bottomnavigationbar.dart';
import 'package:blood_donation/screens/blood/blood_profile.dart';
import 'package:blood_donation/screens/blood/blood_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class blood extends StatefulWidget {
  const blood({Key? key}) : super(key: key);

  @override
  State<blood> createState() => _profileState();
}

class _profileState extends State<blood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Requests'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Blood_Wait_list")
                .orderBy('Time')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    if (x['user'] == "user") {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(
                            Icons.bloodtype,
                            size: 40,
                            color: Colors.red,
                          ),
                          title: Text(
                            "Patient Name: " + x['Name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text("Ph.No: " + x['PhoneNumber']),
                          onTap: () => [
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bloodprof(
                                        value: snapshot.data!.docs[i])))
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => bloodreg()));
          }),
    );
  }
}
