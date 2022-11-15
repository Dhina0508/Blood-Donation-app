import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonors extends StatefulWidget {
  const BloodDonors({super.key});

  @override
  State<BloodDonors> createState() => _BloodDonorsState();
}

class _BloodDonorsState extends State<BloodDonors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor List'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Donors")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("Donors")
            .orderBy("SI no")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          try {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _DocumentSnapshot = snapshot.data!.docs[index];
                return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text("Donor Name: " + _DocumentSnapshot["Name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      subtitle: Text("Phone No : " + _DocumentSnapshot["PhNo"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      leading: Text(
                        _DocumentSnapshot["SI no"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.call, color: Colors.green),
                        onPressed: () {
                          final number = _DocumentSnapshot["PhNo"];
                          launch('tel:$number');
                        },
                      ),
                    ));
              },
            );
          } catch (e) {
            print('error');
          }
          return Container();
        },
      )),
    );
  }
}
