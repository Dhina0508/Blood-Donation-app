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
                              return CardItem(
                                ItemTitle: ItemTitle,
                                image: image,
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
  CardItem({this.ItemTitle, this.image});

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
          trailing: Text('price'),
          onTap: () => [],
        ),
      ),
    );
  }
}
