import 'package:flutter/material.dart';

import 'DonorPage.dart';

class OtherDonor extends StatefulWidget {
  var email;
  var UnitNo;
  var gotReqNo;
  var GetingNo;
  var id;
  var val;
  var i;
  OtherDonor(
      {this.email,
      this.gotReqNo,
      this.UnitNo,
      this.GetingNo,
      this.id,
      this.i,
      this.val});

  @override
  State<OtherDonor> createState() => _OtherDonorState();
}

class _OtherDonorState extends State<OtherDonor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Donors'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = widget.gotReqNo, v = widget.gotReqNo;
                i <= (widget.GetingNo - 1) + widget.gotReqNo;
                i++)
              post(
                GetingNo: widget.GetingNo,
                UnitNo: widget.UnitNo,
                email: widget.email,
                gotReqNo: widget.gotReqNo,
                id: widget.id,
                val: widget.val,
                i: i,
              )
          ],
        ),
      ),
    );
  }
}
