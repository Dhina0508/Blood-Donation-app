import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final blood_type = [
    "O +ve",
    "O -ve",
    "A +ve",
    "A1 +ve",
    "B +ve",
    "B -ve",
    "AB +ve",
    "AB -ve",
  ];
  String? _InputText;
  // var _InputText = "";
  String blood = "";
  var _InputAddress = "";
  String Address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Search Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TextFormField(
              //   onChanged: ((value) {
              //     setState(() {
              //       _InputText = value;
              //     });
              //   }),
              //   decoration: InputDecoration(
              //       hintText: 'Search by Blood Group',
              //       suffixIcon: Icon(Icons.search)),
              // ),
              ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        hint: Text(
                          'Select Blood Group',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        value: _InputText,
                        style: TextStyle(color: Colors.black),
                        iconSize: 16 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: blood_type.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() {
                              this._InputText = value;
                            })),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Members_Details')
                          .where('Blood', isEqualTo: _InputText)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data?.docs[index]['admin'] ==
                                  FirebaseAuth.instance.currentUser!.email) {
                                String ItemTitle =
                                    snapshot.data?.docs[index]['Name'];
                                String image =
                                    snapshot.data?.docs[index]['img'];
                                String Group =
                                    snapshot.data?.docs[index]['Blood'];
                                String Area =
                                    snapshot.data?.docs[index]['Area'];
                                String Phno =
                                    snapshot.data?.docs[index]['PhoneNumber'];
                                return CardItem(
                                  ItemTitle: ItemTitle,
                                  image: image,
                                  group: Group,
                                  Area: Area,
                                );
                              }
                              return Container();
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String _InputText) => DropdownMenuItem(
      value: _InputText,
      child: Text(
        _InputText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}

class CardItem extends StatefulWidget {
  String? ItemTitle;
  String? image;
  String? group;
  String? Area;
  String? PhNo;
  CardItem({this.ItemTitle, this.image, this.group, this.Area, this.PhNo});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(widget.ItemTitle!),
          leading: Image.network(widget.image!),
          trailing: Text(
            widget.group!,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Area :" + widget.Area!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            final number = widget.PhNo;
            launch('tel:$number');
          },
        ),
      ),
    );
  }
}
