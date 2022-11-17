import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonors extends StatefulWidget {
  const BloodDonors({super.key});

  @override
  State<BloodDonors> createState() => _BloodDonorsState();
}

DeleteDonors() {
  final docUser = FirebaseFirestore.instance
      .collection("Donors")
      .doc(FirebaseAuth.instance.currentUser?.email);
  return docUser.delete().then((value) {
    Fluttertoast.showToast(
        msg: "List has been cleared",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  });
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
            .orderBy("Time")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          try {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _DocumentSnapshot = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red[100]),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.call, color: Colors.green),
                            onPressed: () {
                              final number = _DocumentSnapshot["PhNo"];
                              launch('tel:$number');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("Donors")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("Donors")
                                  .doc(_DocumentSnapshot.id)
                                  .delete();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } catch (e) {
            print('error');
          }
          return Container();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Icon(Icons.restore_from_trash_sharp),
      ),
    );
  }
}
