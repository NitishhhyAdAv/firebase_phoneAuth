import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:keep_notes/wrapp.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final dynamic vid;
  const OtpPage({super.key, required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = '';
  signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,
      smsCode: code,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.offAll(const Wrapper());
      });
    }on FirebaseAuthException catch (e){
      Get.snackbar('error',e.code);
    }catch (e){
      Get.snackbar('error',e.toString());
    }
    }  
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: ListView(
        shrinkWrap: true,
        children: [
         const Center(
              child: Text(
            "otp verification",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
         const  Padding(
            padding:  EdgeInsets.all(16.0),
            child: Text("enter Otp Sent to the number"),
          ),
         const  SizedBox(
            height: 20,
          ),
          textcode(),
         const  SizedBox(
            height: 80,
          ),
          button(),
        ],
      )),
    );
  }

  Widget textcode() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        ),
      ),
    );
  }

  Widget button() {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Verify ur Code'),
            ),
            ),
            );
  }
}
