import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Members_Page extends StatefulWidget {
  var value;
  Members_Page({this.value});

  @override
  State<Members_Page> createState() => _MembersState();
}

class _MembersState extends State<Members_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value['Name']),
        backgroundColor: Colors.red,
      ),
      body: Stack(children: [
        Center(
            child: Image.asset(
          'images/hand1.png',
          color: Colors.white.withOpacity(0.1),
          colorBlendMode: BlendMode.modulate,
        )),
        SafeArea(child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Person Name : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['Name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Blood Group : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.value['Blood'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Contact No : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Text(widget.value['PhoneNumber'],
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            onTap: () {
                              final number = widget.value['PhoneNumber'];
                              launch('tel:$number');
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Sex : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['Sex'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Address : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['Address'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'DOB : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.value['DOB'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                final docUser = FirebaseFirestore.instance
                                    .collection("Members_Details")
                                    .doc(widget.value['id'].toString());
                                docUser.delete();
                                Navigator.of(context).pop();
                              },
                              child: Text('Remove Person')),
                          Spacer(),
                        ],
                      ),
                    ),
                  )));
        }))
      ]),
    );
  }
}
