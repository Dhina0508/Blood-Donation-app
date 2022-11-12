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
  DonorPage(
      {this.email,
      this.gotReqNo,
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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Blood_Wait_list");
    var StoreMessage = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Details"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text('Donor Name'),
                  TextField(
                    controller: _nameController,
                  ),
                  Text("Donor PhNo"),
                  TextField(
                    controller: _phoneController,
                  ),
                  for (int i = widget.gotReqNo;
                      i <= (widget.GetingNo - 1) + widget.gotReqNo;
                      i++)
                    ElevatedButton(
                        onPressed: () {
                          if (_nameController.text != "" &&
                              _phoneController.text != "") {
                            StoreMessage.collection("Donors")
                                .doc(widget.email)
                                .collection("Donors")
                                .doc(_nameController.text)
                                .set({
                              "SI no": (i + 1).toString(),
                              "Name": _nameController.text,
                              "PhNo": _phoneController.text
                            }).then((value) {
                              _nameController.clear();
                              _phoneController.clear();
                              if (i + 1 == widget.UnitNo) {
                                DeleteUser(widget.id);
                              } else if (i ==
                                  (widget.GetingNo - 1) + widget.gotReqNo) {
                                _CollectionReference.doc(widget.id).update({
                                  "GotUnits": widget.val.toString()
                                }).then((value) {
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
                        child: Text('post Donors ${i + 1} details')),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
