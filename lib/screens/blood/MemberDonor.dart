import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Member_Donor extends StatefulWidget {
  var email;
  var UnitNo;
  var gotReqNo;
  var GetingNo;
  var id;
  var val;
  var blood;
  Member_Donor(
      {this.email,
      this.gotReqNo,
      this.blood,
      this.UnitNo,
      this.GetingNo,
      this.id,
      this.val});

  @override
  State<Member_Donor> createState() => _Member_DonorState();
}

class _Member_DonorState extends State<Member_Donor> {
  DeleteRequest(@required id) {
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
    });
  }

  AcceptRequest(@required id) async {
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Members_Details");
    return _CollectionReference.doc(id)
        .update({"Status": "Donated"}).then((value) {
      if (widget.GetingNo == 0) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        Navigator.of(context).pop();
      }
    });
  }

  RemoveRequest(@required id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Blood_Wait_list");
    return _CollectionReference.doc(id)
        .update({"Status": "Completed", "user": ""}).then((value) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Members' + " (" + widget.GetingNo.toString() + ")"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Flexible(
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
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        print(widget.blood);
                        if (widget.blood == x['Blood'] &&
                            x['admin'] ==
                                FirebaseAuth.instance.currentUser!.email &&
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        var gotNo = widget.gotReqNo;

                                        setState(() {
                                          widget.gotReqNo = widget.gotReqNo + 1;
                                          widget.GetingNo = widget.GetingNo - 1;
                                          print(widget.gotReqNo);
                                          FirebaseFirestore.instance
                                              .collection("Donors")
                                              .doc(widget.email)
                                              .collection("Donors")
                                              .doc("Donors ${gotNo + 1}")
                                              .set({
                                            "SI no": "${gotNo + 1}",
                                            "Name": x['Name'],
                                            "PhNo": x['PhoneNumber'],
                                            "Time": DateTime.now()
                                          }).then((value) {
                                            FirebaseFirestore.instance
                                                .collection("Blood_Wait_list")
                                                .doc(widget.id)
                                                .update({
                                              "GotUnits": "${gotNo + 1}"
                                            });
                                            setState(() {
                                              gotNo = gotNo + 1;
                                            });
                                            AcceptRequest(x['id']);
                                          });
                                          if (widget.GetingNo == 0) {
                                            if (widget.gotReqNo ==
                                                widget.UnitNo) {
                                              RemoveRequest(widget.id);
                                            }
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      )),
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
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              onTap: () => [
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Members_Page(
                                //             value: snapshot.data!.docs[i])))
                              ],
                            ),
                          );
                        }
                        return Container();
                      });
                }),
          ),
        ],
      ),
    );
  }
}
