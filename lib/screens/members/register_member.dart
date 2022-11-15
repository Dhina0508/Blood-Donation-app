import 'dart:io';

import 'package:blood_donation/bottomnavigation_bar/bottomnavigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

class RegisterMembers extends StatefulWidget {
  RegisterMembers({Key? key}) : super(key: key);

  @override
  State<RegisterMembers> createState() => _RegisterMembersState();
}

class _RegisterMembersState extends State<RegisterMembers> {
  String? link;
  ImagePicker image = ImagePicker();
  File? file;

  String url = "";
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  TextEditingController _NameController = TextEditingController();

  TextEditingController _PhoneNoController = TextEditingController();

  TextEditingController _AddressController = TextEditingController();

  TextEditingController _BloodController = TextEditingController();
  TextEditingController _dobcontroller = TextEditingController();
  var enable = "";

  SendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile = FirebaseStorage.instance.ref().child("Members").child(name);

    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Members_Details").doc();
    return _CollectionReference.set({
      "Name": _NameController.text,
      "PhoneNumber": _PhoneNoController.text,
      "Address": _AddressController.text,
      "DOB": _dobcontroller.text,
      "Blood": _BloodController.text,
      "Time": DateTime.now(),
      "img": url,
      "id": _CollectionReference.id,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Details Of The User Has Been Added"),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.of(context).pop();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigatorBar()));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.redAccent[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bio of the Club Members',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Ink(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(210, 223, 52, 52),
              Color.fromARGB(210, 234, 161, 161),
              Color.fromARGB(210, 234, 161, 161),
              Color.fromARGB(210, 223, 52, 52),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Submit to Store Details',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.redAccent[200],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: file == null
                            ? AssetImage("images/profile.png")
                            : FileImage(File(file!.path)) as ImageProvider,
                        radius: 50,
                      ),
                    ),
                    Text(
                      'Click to add Image',
                      style: TextStyle(fontSize: 11),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 30, left: 8),
                      child: TextFormField(
                        controller: _NameController,
                        decoration: InputDecoration(
                            labelText: 'Full name',
                            prefixIcon: Icon(
                              Icons.account_box_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Enter your Name'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 30, left: 8),
                      child: TextFormField(
                        controller: _BloodController,
                        decoration: InputDecoration(
                            labelText: 'Blood Group',
                            prefixIcon: Icon(
                              Icons.bloodtype_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Eg: B+ve'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8, top: 20, left: 8),
                      child: TextField(
                        controller: _dobcontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            labelText: 'Select DOB'),
                        onTap: () async {
                          DateTime? picketdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2200));
                          if (picketdate != null) {
                            setState(() {
                              _dobcontroller.text =
                                  DateFormat('dd-MM-yyyy').format(picketdate);
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30.0, right: 8, left: 8),
                      child: TextFormField(
                        controller: _PhoneNoController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.phone_android_rounded,
                            color: Colors.redAccent[200],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 30, left: 8),
                      child: TextFormField(
                        controller: _AddressController,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            prefixIcon: Icon(
                              Icons.house_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Your address'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 30.0, left: 8),
                      child: enable == ""
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                if (_NameController.text != "" &&
                                    _BloodController.text != "" &&
                                    _PhoneNoController.text != "" &&
                                    _AddressController.text != "" &&
                                    file != null) {
                                  setState(() {
                                    enable = "1";
                                  });
                                  if (file == null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Please Select Your profile Photo"),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.black,
                                    ));
                                  }
                                  SendUserDataToDB();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(" Details cannot be empty"),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.black,
                                  ));
                                }
                              },
                              child: Text('   Submit   '))
                          : Text("Submitting...."),
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
