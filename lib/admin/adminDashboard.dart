import 'package:blood_donation/admin/adminBloodProfile.dart';
import 'package:blood_donation/auth/signup.dart';
import 'package:blood_donation/firebase_helper/firebase_helper.dart';
import 'package:blood_donation/screens/blood/blood_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                service.signOut(context);
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
        title: Text('Welcome Admin'),
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
                    if (x['user'] == "admin") {
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
                                    builder: (context) => AdminBloodProfile(
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
    );
  }
}
