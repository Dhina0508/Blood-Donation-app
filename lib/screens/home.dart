import 'package:blood_donation/screens/chat_screens/chat_lobby.dart';
import 'package:blood_donation/screens/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_helper/firebase_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users =
      FirebaseFirestore.instance.collection("User_Bio_Data");

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(248, 68, 100, 300),
      backgroundColor: Color.fromARGB(255, 202, 191, 191),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Lobby()));
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Icon(Icons.message)),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // gradient: LinearGradient(colors: [
            //   Color.fromARGB(221, 241, 32, 32),
            //   Color.fromARGB(234, 219, 33, 219),
            //   Color.fromARGB(210, 52, 18, 175),
            //   Color.fromARGB(210, 52, 18, 175),
            // ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: Text(
            'BLOOD DONATION',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 194, 122, 117),
      ),

      drawer: FutureBuilder<DocumentSnapshot>(
          future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Center(child: Text("Document does not exist"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Drawer(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    otherAccountsPictures: <Widget>[
                      Icon(
                        Icons.brightness_2_rounded,
                        color: Colors.white,
                      ),
                    ],
                    accountName: GestureDetector(
                      child: Text(
                        "${data['Name']}",
                        style: TextStyle(fontSize: 18, fontFamily: 'Cinzel'),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('profile');
                      },
                    ),
                    accountEmail: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('profile');
                        },
                        child: Text("${data['Email']}")),
                    currentAccountPicture: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('profile');
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          "${data['img']}",
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 68, 100, 300),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      title: Text('Blood Donation'),
                      leading: Icon(
                        Icons.bloodtype,
                        color: Colors.red,
                      ),
                      onTap: () => [Navigator.of(context).pushNamed('blood')],
                    ),
                  ),
                ],
              ));
            }
            return Drawer();
          }),
    );
  }
}
