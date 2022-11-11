import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  var email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Request List'),
        backgroundColor: Colors.red,
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
                    if (x['email'] == email) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(
                            Icons.bloodtype,
                            size: 40,
                            color: Colors.red,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                String id = x['id'];
                                print(id);
                                final docUser = FirebaseFirestore.instance
                                    .collection("Blood_Wait_list")
                                    .doc(id.toString());
                                docUser.delete();
                              },
                              icon: Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.red,
                              )),
                          title: Text(
                            "Patient Name: " + x['Name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Row(
                            children: [
                              Text("Status: " + x['Status']),
                              SizedBox(
                                width: 6,
                              ),
                              if (x['Status'] == "Pending")
                                Icon(
                                  Icons.done_rounded,
                                  color: Colors.orange,
                                )
                              else if (x['Status'] == "Accepted")
                                Icon(
                                  Icons.done_all_rounded,
                                  color: Colors.green,
                                )
                              else if (x['Status'] == "Rejected")
                                Icon(
                                  Icons.not_interested_rounded,
                                  size: 18,
                                  color: Colors.red,
                                )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
      ),
    );
  }
}
