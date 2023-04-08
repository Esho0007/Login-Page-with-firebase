import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign in as:' + user.email!),
            MaterialButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            color: Colors.pinkAccent,
              child: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
