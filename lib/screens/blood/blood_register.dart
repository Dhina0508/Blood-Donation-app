import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class bloodreg extends StatefulWidget {
  bloodreg({Key? key}) : super(key: key);

  @override
  State<bloodreg> createState() => _registerState();
}

class _registerState extends State<bloodreg> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _HospitalNameController = TextEditingController();
  TextEditingController _HospitalAddressController = TextEditingController();

  TextEditingController _bloodController = TextEditingController();

  TextEditingController _PhoneNoController = TextEditingController();

  TextEditingController _AddressController = TextEditingController();

  TextEditingController _DiscriptionController = TextEditingController();

  TextEditingController _YourNameController = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();

  // SendUserDataToDB() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentuser = _auth.currentUser;

  //   final _CollectionReference =
  //       FirebaseFirestore.instance.collection("Blood_Req_List").doc();

  //   return _CollectionReference.set({
  //     "id": _CollectionReference.id,
  //     "Name": _NameController.text,
  //     "Blood_Group": _bloodController.text,
  //     "PhoneNumber": _PhoneNoController.text,
  //     "Address": _AddressController.text,
  //     "discription": _DiscriptionController.text,
  //   }).then((value) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Details Of The User Has Been Added"),
  //       behavior: SnackBarBehavior.floating,
  //     ));
  //     Navigator.of(context).pop();
  //   }).catchError((onError) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("ERROR ${onError.toString()}"),
  //       behavior: SnackBarBehavior.floating,
  //     ));
  //   });
  // }

  CommonDb() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Common_Db").doc();
    return _CollectionReference.set({
      "about": "blood",
      "id": _CollectionReference.id,
      "Name": _NameController.text,
      "Blood_Group": value == 'Others' ? _bloodController.text : value,
      "PhoneNumber": _PhoneNoController.text,
      "Address": _AddressController.text,
      "hospital_name": _HospitalNameController.text,
      "hospital_address": _HospitalAddressController.text,
      "Your_name": _YourNameController.text,
      "discription": _DiscriptionController.text,
      "Date": _datecontroller.text,
      "Time": DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Details Of The User Has Been Added"),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.of(context).pop();
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  final sectors = [
    "O +ve",
    "O -ve",
    "A +ve",
    "A1 +ve",
    "B +ve",
    "B -ve",
    "AB +ve",
    "AB -ve",
    "Others"
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Fill up the Details',
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Submit to Post Request',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.redAccent[200],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.bloodtype,
                          color: Colors.red,
                          size: 40,
                        ),
                        title: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                hint: Text(
                                  'Select Blood Group',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.grey),
                                ),
                                value: value,
                                style: TextStyle(color: Colors.black),
                                iconSize: 16 * 2,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                items: sectors.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(() {
                                      this.value = value;
                                    })),
                          ),
                        ),
                      ),
                      value == 'Others'
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 8, left: 8),
                              child: TextFormField(
                                controller: _bloodController,
                                decoration: InputDecoration(
                                  labelText: 'Blood Group',
                                  prefixIcon: Icon(
                                    Icons.bloodtype,
                                    color: Colors.redAccent[200],
                                    size: 40,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      value == 'Others'
                          ? Container()
                          : Divider(
                              color: Colors.black,
                              indent: 8,
                              endIndent: 8,
                            ),
                      Padding(
                        padding: EdgeInsets.only(right: 8, top: 20, left: 8),
                        child: TextField(
                          controller: _datecontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.redAccent[200],
                                size: 40,
                              ),
                              labelText: 'Select Date'),
                          onTap: () async {
                            DateTime? picketdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2200));
                            if (picketdate != null) {
                              setState(() {
                                _datecontroller.text =
                                    DateFormat('dd-MM-yyyy').format(picketdate);
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _NameController,
                          decoration: InputDecoration(
                              labelText: 'Patient Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.redAccent[200],
                                size: 40,
                              ),
                              hintText: 'Enter Name'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _AddressController,
                          decoration: InputDecoration(
                              labelText: 'Patient Address',
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
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _DiscriptionController,
                          decoration: InputDecoration(
                              labelText: 'About patient',
                              prefixIcon: Icon(
                                Icons.bed_rounded,
                                color: Colors.redAccent[200],
                                size: 40,
                              ),
                              hintText: 'About patient'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _HospitalNameController,
                          decoration: InputDecoration(
                              labelText: 'Hospital Name',
                              prefixIcon: Icon(
                                Icons.local_hospital,
                                color: Colors.redAccent[200],
                                size: 35,
                              ),
                              hintText: 'Patient admitted Hospital Name'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _HospitalAddressController,
                          decoration: InputDecoration(
                              labelText: 'Hospital Address',
                              prefixIcon: Icon(
                                Icons.add_home_work,
                                color: Colors.redAccent[200],
                                size: 35,
                              ),
                              hintText: 'Patient admitted Hospital Address'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 30, left: 8),
                        child: TextFormField(
                          controller: _YourNameController,
                          decoration: InputDecoration(
                              labelText: 'Your Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.red,
                                size: 40,
                              ),
                              hintText: 'Name of the Requesting Person'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 8, left: 8),
                        child: TextFormField(
                          controller: _PhoneNoController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: ' Your Whatsapp Number',
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
                            const EdgeInsets.only(right: 8, top: 30.0, left: 8),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_NameController.text != '' &&
                                  _PhoneNoController.text != '' &&
                                  _datecontroller != '' &&
                                  _AddressController.text != '' &&
                                  _DiscriptionController.text != '') {
                                // SendUserDataToDB();
                                CommonDb();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("Error : Details cannot be empty"),
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
          ),
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}
