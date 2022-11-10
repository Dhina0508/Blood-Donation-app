import 'package:blood_donation/auth/otp.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneNoVerification extends StatefulWidget {
  PhoneNoVerification({Key? key}) : super(key: key);

  @override
  State<PhoneNoVerification> createState() => _PhoneNoVerificationState();
}

class _PhoneNoVerificationState extends State<PhoneNoVerification> {
  String dialCodeDigits = "+91";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Ink(
              child: Container(
                padding: EdgeInsets.all(7),
                child: Text(
                  'BLOOD DONATION',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: "IN",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: ["+91"],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(dialCodeDigits),
                    )),
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpPage(
                              phone: _controller.text,
                              codeDigits: dialCodeDigits)));
                },
                child: Text('Next'),
              ),
            )
          ]),
        )),
      ),
    );
  }
}
