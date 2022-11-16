import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _InputText = "";
  String blood = "";
  var _InputAddress = "";
  String Address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: ((value) {
                  setState(() {
                    _InputText = value;
                  });
                }),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Members_Details')
                          .where("Blood", isEqualTo: _InputText)
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
                              String ItemTitle =
                                  snapshot.data?.docs[index]['Name'];
                              String image = snapshot.data?.docs[index]['img'];
                              String Group =
                                  snapshot.data?.docs[index]['Blood'];
                              String Area = snapshot.data?.docs[index]['Area'];
                              return CardItem(
                                ItemTitle: ItemTitle,
                                image: image,
                                group: Group,
                                Area: Area,
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  String? ItemTitle;
  String? image;
  String? group;
  String? Area;
  CardItem({this.ItemTitle, this.image, this.group, this.Area});

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
          onTap: () => [],
        ),
      ),
    );
  }
}
