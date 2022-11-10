import 'package:blood_donation/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  final String codeDigits;

  OtpPage({required this.phone, required this.codeDigits});
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinotpcontroller = TextEditingController();
  final FocusNode _pinotpfocusnode = FocusNode();
  String? VerificationCode;

  final BoxDecoration pinotpdecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhonenumber();
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ));
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            VerificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            VerificationCode = vID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
      appBar: AppBar(title: Text('OTP Verification')),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset('images/otp.jpg'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhonenumber();
                },
                child: Text(
                  "Verifying: ${widget.codeDigits}-${widget.phone}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(40),
              child: Pinput(
                closeKeyboardWhenCompleted: false,
                length: 6,
                focusNode: _pinotpfocusnode,
                controller: _pinotpcontroller,
                pinAnimationType: PinAnimationType.fade,
                onSubmitted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: VerificationCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid OTP"),
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(234, 239, 243, 1), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
