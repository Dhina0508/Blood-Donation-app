import 'package:blood_donation/screens/members/members.dart';
import 'package:blood_donation/screens/members/register_member.dart';
import 'package:blood_donation/screens/members/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  AcceptRequest(@required id) async {
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Members_Details");
    return _CollectionReference.doc(id).update({"Status": "Not_Donated"});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Members',
          ),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterMembers()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            // construct the profile details widget here

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.redAccent,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "Not_Donated",
                    ),
                    Tab(
                      text: "Donated",
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Members_Details")
                              .orderBy('Time')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  if (x['admin'] ==
                                          FirebaseAuth
                                              .instance.currentUser!.email &&
                                      x['Status'] == "Not_Donated") {
                                    return Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              x['img'],
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          "Name: " + x['Name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        trailing: Text(
                                          x['Blood'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        subtitle: Text(
                                          "Ph.No: " + x['PhoneNumber'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        onTap: () => [
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Members_Page(
                                                          value: snapshot
                                                              .data!.docs[i])))
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          }),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Members_Details")
                              .orderBy('Time')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  if (x['Status'] == "Donated" &&
                                      x['admin'] ==
                                          FirebaseAuth
                                              .instance.currentUser!.email) {
                                    return Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              x['img'],
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          "Name: " + x['Name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  AcceptRequest(x['id']);
                                                },
                                                icon: Icon(
                                                  Icons.add_box_sharp,
                                                  color: Colors.green,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              x['Blood'],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          "Ph.No: " + x['PhoneNumber'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        onTap: () => [
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Members_Page(
                                                          value: snapshot
                                                              .data!.docs[i])))
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
