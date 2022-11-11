import 'package:flutter/material.dart';

class AdminBloodProfile extends StatefulWidget {
  var value;

  AdminBloodProfile({@required this.value});

  @override
  State<AdminBloodProfile> createState() => _AdminBloodProfileState();
}

class _AdminBloodProfileState extends State<AdminBloodProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Requested By: " + widget.value['Your_name'],
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cinzel'),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(children: [
        Center(
            child: Image.asset(
          'images/blood.png',
          color: Colors.white.withOpacity(0.2),
          colorBlendMode: BlendMode.modulate,
        )),
        SafeArea(child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Patient Name : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['Name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Blood Needed : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.value['Blood_Group'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Requested Date : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.value['Date'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'About the person: ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.value['discription'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Hospital Name : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['hospital_name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Hospital Address : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['hospital_address'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Requestor Name : ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.value['Your_name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Requestor Contact Number : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.value['PhoneNumber'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // launchwp(
                                    //     number: ("+91" +
                                    //         widget.value['PhoneNumber']),
                                    //     bloodgroup:
                                    //         (widget.value['Blood_Group']));
                                    // String id = widget.value['id'];
                                    // print(id);
                                    // final docUser = FirebaseFirestore.instance
                                    //     .collection("Common_Db")
                                    //     .doc(id.toString());
                                    // docUser.delete();
                                    // Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '   Chat   ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  // minWidth: MediaQuery.of(context).size.width,
                                  // color: Colors.deepOrange,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () =>
                                      [Navigator.of(context).pop()],
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.not_interested_rounded,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Decline',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  // minWidth: MediaQuery.of(context).size.width,
                                  // color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )));
        }))
      ]),
    );
  }
}
