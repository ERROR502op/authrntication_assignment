import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Myphone extends StatefulWidget {
  const Myphone({super.key});
  static String verify = '';

  @override
  State<Myphone> createState() => _MyphoneState();
}

class _MyphoneState extends State<Myphone> {
  TextEditingController contrycode = TextEditingController();
  var phone = '';
  bool isLoading = false;

  @override
  void initState() {
    contrycode.text = '+91';
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'image/auth3.webp',
                  height: 300,
                  width: 300,
                ),
              ),
              Text(
                'Phone Verification',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We need to regidter your phone before getting started ',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: 40,
                        child: TextField(
                          controller: contrycode,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: ''),
                        )),
                    Text(
                      '|',
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: ((value) {
                        phone = value;
                      }),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Phone'),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (() async {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds: 5), () {
                      setState(() {
                        isLoading = false;
                      });
                    });
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${contrycode.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        Myphone.verify = verificationId;
                        Navigator.pushNamed(context, 'otp');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    // Navigator.pushNamed(context, 'otp');
                  }),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Send the code'),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 30, 163, 123),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
