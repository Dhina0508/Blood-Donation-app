import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../bottomnavigation_bar/bottomnavigationbar.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigatorBar()));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  TextEditingController _EmailController = TextEditingController();

  TextEditingController _PhoneNoController = TextEditingController();

  TextEditingController _AddressController = TextEditingController();

  TextEditingController _BloodController = TextEditingController();

  TextEditingController _JobController = TextEditingController();

  TextEditingController _AgeController = TextEditingController();
  TextEditingController _phnoController = new TextEditingController();
  TextEditingController _Professionontroller = new TextEditingController();
  TextEditingController _LocationController = new TextEditingController();
  TextEditingController _NameController = new TextEditingController();

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

  showtoast() {
    Fluttertoast.showToast(
        msg: "Details Cannot Be Empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  UpdateImage() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile = FirebaseStorage.instance.ref().child("User").child(name);

    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    var currentuser = _auth.currentUser;

    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({"img": url});
  }

  UpdatePhoneNo() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "PhoneNumber": _phnoController.text,
    });
  }

  UpadateEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "Email": _EmailController.text,
    });
  }

  UpadateAge() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "Age": _AgeController.text,
    });
  }

  UpdateBlood() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "Blood": _BloodController.text,
    });
  }

  UpdateProfession() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "Occupation": _Professionontroller.text,
    });
  }

  UpdateName() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email)
        .update({"Name": _NameController.text});
  }

  UpdateLocation() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("User_Bio_Data");
    return _CollectionReference.doc(currentuser!.email).update({
      "Address": _LocationController.text,
    });
  }

  var name = '';
  var PhNo = '';
  var Email = '';
  var Blood = '';
  var Profession = '';
  var location = '';
  var photo = '';
  var age = '';
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("User_Bio_Data");

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 202, 191, 191),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Profile',
            style: TextStyle(
                fontFamily: 'Cinzel', fontSize: 25, color: Colors.black),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Ink(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 236, 5, 5),
                    Color.fromARGB(234, 131, 56, 188),
                    Color.fromARGB(235, 90, 31, 146),
                    Color.fromARGB(235, 51, 11, 120),
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
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
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
                                  : FileImage(File(file!.path))
                                      as ImageProvider,
                              radius: 50,
                            ),
                          ),
                          Text('Click to add Image'),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                top: 30.0, right: 8, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30, left: 8),
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
                            padding: const EdgeInsets.only(
                                right: 8, top: 30.0, left: 8),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_NameController.text != "" &&
                                      _EmailController.text != "" &&
                                      _BloodController.text != "" &&
                                      _JobController.text != "" &&
                                      _PhoneNoController.text != "" &&
                                      _AddressController.text != "") {
                                    SendUserDataToDB();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Error : Details cannot be empty"),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
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
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return SafeArea(
                  minimum: EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        photo == '1'
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: file == null
                                          ? AssetImage("images/profile1.png")
                                          : FileImage(File(file!.path))
                                              as ImageProvider,
                                      radius: 70,
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          photo = '';
                                        });
                                        UpdateImage();
                                      },
                                      child: Text('Update'))
                                ],
                              )
                            : GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    "${data['img']}",
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    photo = '1';
                                  });
                                },
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Text(
                            "${data['Name']}",
                            style: const TextStyle(
                                fontFamily: 'Josefinsans',
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            setState(() {
                              name = '1';
                            });
                          },
                        ),
                        name == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Your Name'),
                                      controller: _NameController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_NameController.text != '') {
                                            setState(() {
                                              name = '';
                                            });
                                            UpdateName();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              name = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.drive_file_rename_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  PhNo = '1';
                                });
                              },
                            ),
                            leading: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            title: Text("${data['PhoneNumber']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Josefinsans')),
                          ),
                        ),
                        PhNo == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Contact Number'),
                                      controller: _phnoController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_phnoController.text != '') {
                                            setState(() {
                                              PhNo = '';
                                            });
                                            UpdatePhoneNo();
                                          } else {
                                            setState(() {
                                              PhNo = '';
                                            });
                                            showtoast();
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Email = '1';
                                  });
                                }),
                            leading: Icon(
                              Icons.email,
                              color: Colors.brown,
                            ),
                            title: Text("${data['Email']}",
                                style: TextStyle(
                                  fontFamily: 'Josefinsans',
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Email == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Your Email id'),
                                      controller: _EmailController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_EmailController.text != '') {
                                            setState(() {
                                              Email = '';
                                            });
                                            UpadateEmail();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              Email = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    age = '1';
                                  });
                                }),
                            leading: Icon(
                              Icons.child_care,
                              color: Colors.black,
                            ),
                            title: Text("${data['Age']}",
                                style: TextStyle(
                                  fontFamily: 'Josefinsans',
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        age == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Update Your Age'),
                                      controller: _AgeController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_AgeController.text != '') {
                                            setState(() {
                                              age = '';
                                            });
                                            UpadateAge();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              age = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.drive_file_rename_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  Blood = '1';
                                });
                              },
                            ),
                            leading: Icon(
                              Icons.bloodtype,
                              color: Colors.red,
                            ),
                            title: Text("${data['Blood']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Josefinsans')),
                          ),
                        ),
                        Blood == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Your blood Group'),
                                      controller: _BloodController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_BloodController.text != '') {
                                            setState(() {
                                              Blood = '';
                                            });
                                            UpdateBlood();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              Blood = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.drive_file_rename_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  Profession = '1';
                                });
                              },
                            ),
                            leading: Icon(
                              Icons.accessibility_rounded,
                              color: Colors.brown,
                            ),
                            title: Text("${data['Occupation']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Josefinsans')),
                          ),
                        ),
                        Profession == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Your Occupation'),
                                      controller: _Professionontroller,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_Professionontroller.text != '') {
                                            setState(() {
                                              Profession = '';
                                            });
                                            UpdateProfession();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              Profession = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.drive_file_rename_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  location = '1';
                                });
                              },
                            ),
                            leading: Icon(
                              Icons.location_on_sharp,
                              color: Colors.red,
                            ),
                            title: Text("${data['Address']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Josefinsans')),
                          ),
                        ),
                        location == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Card(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Update Your Address'),
                                      controller: _LocationController,
                                    )),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_LocationController.text != '') {
                                            setState(() {
                                              location = '';
                                            });
                                            UpdateLocation();
                                          } else {
                                            showtoast();
                                            setState(() {
                                              location = '';
                                            });
                                          }
                                        },
                                        child: Text('Update'))
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
            }

            return Center(
                child: Text(
              "loading...",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ));
          },
        ));
  }
}
//  Text("User Name: ${data['Name']}"),
//                 Container(child: Text("User Email: ${data['Email']}")),
//                 Text("User Blood Group: ${data['Blood']}"),
//                 Text("User Occupation: ${data['Occupation']}"),
//                 Text("User PhNo: ${data['PhoneNumber']}"),
//                 Text("User Address: ${data['Address']}"),
