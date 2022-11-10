import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var loginuser = FirebaseAuth.instance.currentUser;

class chatScreen extends StatefulWidget {
  var chatroomid;
  var name;

  chatScreen({this.chatroomid, this.name});
  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  TextEditingController _MessageController = new TextEditingController();
  final storemessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginuser = user;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Chats")
                    .doc(widget.chatroomid)
                    .collection("messages")
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      primary: true,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: loginuser!.email == x['User']
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              SafeArea(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: loginuser!.email == x['User']
                                              ? Colors.redAccent[100]
                                              : Colors.lightBlueAccent[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          x['Messgaes'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                              Text(
                                x['User'],
                                style: TextStyle(fontSize: 8),
                              )
                            ],
                          ),
                        );
                      });
                }),
          )),
          Card(
            color: Colors.amber[100],
            child: TextFormField(
              controller: _MessageController,
              textAlignVertical: TextAlignVertical.center,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "Send A Message",
                  suffix: IconButton(
                      onPressed: () {
                        if (_MessageController.text.isNotEmpty) {
                          storemessage
                              .collection("Chats")
                              .doc(widget.chatroomid)
                              .collection("messages")
                              .doc()
                              .set({
                            "Messgaes": _MessageController.text.trim(),
                            "User": loginuser!.email.toString(),
                            'time': DateTime.now()
                          });
                          _MessageController.clear();
                        }
                      },
                      icon: Icon(Icons.send))),
            ),
          ),
        ],
      ),
    );
  }
}
