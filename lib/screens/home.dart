import 'package:blood_donation/screens/blood/BloodDonators.dart';
import 'package:blood_donation/screens/blood/UserRequest.dart';
import 'package:blood_donation/screens/blood/blood.dart';
import 'package:blood_donation/screens/blood/blood_register.dart';
import 'package:blood_donation/screens/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

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
      backgroundColor: Color.fromARGB(255, 202, 191, 191),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
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
                fontSize: 23),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.bloodtype,
                  color: Colors.red,
                ),
                title: Text(
                  'Requested List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => blood()));
                },
              ),
            ),
          ),

          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  Icons.bloodtype_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  'Request Blood',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => bloodreg()));
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  Icons.handshake,
                  color: Colors.red,
                ),
                title: Text(
                  'My Request',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRequest()));
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: Text(
                  'My Donors',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BloodDonors()));
                },
              ),
            ),
          ),
          Spacer()

          //     child: Center(
          //   child: 'hello'.text.xl4.bold.make().shimmer(
          //       primaryColor: Vx.amber100, secondaryColor: Colors.green),
          // )
        ],
      ),
    );
  }
}
