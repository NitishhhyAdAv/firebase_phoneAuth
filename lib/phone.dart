import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:keep_notes/otppage.dart';
import 'package:keep_notes/wrapp.dart';

class PhoneHome extends StatefulWidget {
  const PhoneHome({super.key});

  @override
  State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  TextEditingController phonenumber = TextEditingController();
  sendcode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${phonenumber.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
  await FirebaseAuth.instance.signInWithCredential(credential);
  Get.offAll(const Wrapper());
},

          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error Occured', e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(
              OtpPage(
                vid: vid,
              ),
            );
          },
          codeAutoRetrievalTimeout: (vid) {});
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occured', e.code);
    } catch (e) {
      Get.snackbar('error occured', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              "Ur Number",
              style: TextStyle(fontSize: 28),
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6)),
          const SizedBox(
            height: 20,
          ),
          phonetext(),
          const SizedBox(
            height: 40,
          ),
          button()
        ],
      ),
    );
  }

  Widget phonetext() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: TextField(
        controller: phonenumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefix:const  Text("+91"),
            prefixIcon: const Icon(Icons.phone),
            labelText: "Enter phone number",
            hintStyle: TextStyle(color: Colors.blue[200]),
            labelStyle: const TextStyle(color: Colors.black87),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            )),
      ),
    );
  }

  Widget button() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          sendcode();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[400],
          padding: const EdgeInsets.all(17.0),
        ),
        child: const Text(
          'Recieve Otp',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
