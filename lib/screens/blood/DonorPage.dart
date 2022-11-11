import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonorPage extends StatefulWidget {
  var email;
  var UnitNo;
  var gotReqNo;
  var GetingNo;
  DonorPage({this.email, this.gotReqNo, this.UnitNo, this.GetingNo});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var StoreMessage = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Details"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = widget.gotReqNo; i <= widget.GetingNo - 1; i++)
              Container(
                child: Column(
                  children: [
                    Text('Donor ${i + 1} Name'),
                    TextField(
                      controller: _nameController,
                    ),
                    Text("Donor ${i + 1} PhNo"),
                    TextField(
                      controller: _phoneController,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_nameController.text != "" &&
                              _phoneController.text != "") {
                            StoreMessage.collection("Donors")
                                .doc(widget.email)
                                .collection("Donors ${i + 1}")
                                .doc(_nameController.text)
                                .set({
                              "Name": _nameController.text,
                              "PhNo": _phoneController.text
                            }).then((value) {
                              _nameController.clear();
                              _phoneController.clear();
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
                        child: Text('post')),
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
