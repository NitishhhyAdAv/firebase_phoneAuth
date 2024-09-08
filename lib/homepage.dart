import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;
  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOmepage'),),
      body: Center(child: Text("${user!.phoneNumber}",style: const TextStyle(fontSize: 16,),
      ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (()=>signout()),
      child: const Icon(Icons.login_rounded),
    ),
    );
  }
}
