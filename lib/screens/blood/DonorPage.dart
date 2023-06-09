import 'package:blood_donation/screens/blood/MemberDonor.dart';
import 'package:blood_donation/screens/blood/OtherDonor.dart';
import 'package:blood_donation/screens/blood/blood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonorPage extends StatefulWidget {
  var email;
  var UnitNo;
  var gotReqNo;
  var GetingNo;
  var id;
  var val;
  var blood;
  DonorPage(
      {this.email,
      this.gotReqNo,
      this.blood,
      this.UnitNo,
      this.GetingNo,
      this.id,
      this.val});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  DeleteUser(@required id) {
    final docUser = FirebaseFirestore.instance
        .collection("Blood_Wait_list")
        .doc(id.toString());
    return docUser.delete().then((value) {
      Fluttertoast.showToast(
          msg: "Thanks For Your Effort",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var tap = "";
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Blood_Wait_list");
    var StoreMessage = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Details"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Member_Donor(
                                  GetingNo: widget.GetingNo,
                                  UnitNo: widget.UnitNo,
                                  email: widget.email,
                                  gotReqNo: widget.gotReqNo,
                                  id: widget.id,
                                  val: widget.val,
                                  blood: widget.blood,
                                ))));
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Donate From Our Members',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherDonor(
                                  GetingNo: widget.GetingNo,
                                  UnitNo: widget.UnitNo,
                                  email: widget.email,
                                  gotReqNo: widget.gotReqNo,
                                  id: widget.id,
                                  val: widget.val,
                                )));
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Donate From Other Members",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class post extends StatefulWidget {
  var email;
  var UnitNo;
  var gotReqNo;
  var GetingNo;
  var id;
  var val;
  var i;
  post(
      {this.email,
      this.gotReqNo,
      this.UnitNo,
      this.GetingNo,
      this.id,
      this.i,
      this.val});

  @override
  State<post> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<post> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _CollectionReference =
      FirebaseFirestore.instance.collection("Blood_Wait_list");
  var StoreMessage = FirebaseFirestore.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  DeleteUser(@required id) {
    final docUser = FirebaseFirestore.instance
        .collection("Blood_Wait_list")
        .doc(id.toString());
    return docUser.delete().then((value) {
      Fluttertoast.showToast(
          msg: "Thanks For Your Effort",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  RemoveRequest(@required id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Blood_Wait_list");
    return _CollectionReference.doc(id)
        .update({"Status": "Completed", "user": ""}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Thanks For Your Effort",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Donor Name',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Enter Donor Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _nameController,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Donor Phone Number",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Enter Donor Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _phoneController,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (_nameController.text != "" && _phoneController.text != "") {
                StoreMessage.collection("Donors")
                    .doc(widget.email)
                    .collection("Donors")
                    .doc("Donors ${widget.i + 1}")
                    .set({
                  "SI no": (widget.i + 1).toString(),
                  "Name": _nameController.text,
                  "PhNo": _phoneController.text,
                  "Time": DateTime.now()
                }).then((value) {
                  _nameController.clear();
                  _phoneController.clear();
                  if (widget.i + 1 == widget.UnitNo) {
                    RemoveRequest(widget.id);
                  } else if (widget.i ==
                      (widget.GetingNo - 1) + widget.gotReqNo) {
                    _CollectionReference.doc(widget.id).update(
                        {"GotUnits": widget.val.toString()}).then((value) {
                      Fluttertoast.showToast(
                          msg: "Thanks For Your Effort",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  }
                });
              } else {
                Fluttertoast.showToast(
                    msg: "Details cannot be Empty",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blueGrey,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text('Post ${widget.i + 1} Donors Details')),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
