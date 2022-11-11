import 'dart:io';

import 'package:blood_donation/bottomnavigation_bar/bottomnavigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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

  TextEditingController _EmailController = TextEditingController();

  TextEditingController _PhoneNoController = TextEditingController();

  TextEditingController _AddressController = TextEditingController();

  TextEditingController _BloodController = TextEditingController();

  TextEditingController _JobController = TextEditingController();

  TextEditingController _AgeController = TextEditingController();

  SendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile = FirebaseStorage.instance.ref().child("User").child(name);

    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).set({
      "Name": _NameController.text,
      "Email": _EmailController.text,
      "PhoneNumber": _PhoneNoController.text,
      "Address": _AddressController.text,
      "Age": _AgeController.text,
      "Blood": _BloodController.text,
      "Occupation": _JobController.text,
      "img": url,
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
                'Bio of the User',
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
                      'Submit to continue',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.redAccent[200],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We will not share this with anyone',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
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
                        controller: _EmailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Someone@email.com'),
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
                      padding:
                          const EdgeInsets.only(right: 8, top: 30, left: 8),
                      child: TextFormField(
                        controller: _AgeController,
                        decoration: InputDecoration(
                            labelText: 'Age',
                            prefixIcon: Icon(
                              Icons.person_pin_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Eg: 24'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 30, left: 8),
                      child: TextFormField(
                        controller: _JobController,
                        decoration: InputDecoration(
                            labelText: 'Occupation',
                            prefixIcon: Icon(
                              Icons.work_rounded,
                              color: Colors.redAccent[200],
                              size: 40,
                            ),
                            hintText: 'Eg: Business'),
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
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            if (_NameController.text != "" &&
                                _EmailController.text != "" &&
                                _BloodController.text != "" &&
                                _JobController.text != "" &&
                                _PhoneNoController.text != "" &&
                                _AddressController.text != "") {
                              if (file == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("Please Select Your profile Photo"),
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
                          child: Text('   Submit   ')),
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
