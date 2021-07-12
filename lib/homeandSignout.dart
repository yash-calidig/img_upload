import 'package:flutter/material.dart';
import 'package:learn_firebase/googleUser.dart';
import 'package:learn_firebase/main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              color: Colors.white,
              child: Text("Image Upload"),
              onPressed: () {
                signOutGoogle();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
            MaterialButton(
              color: Colors.white,
              child: Text("Sign Out"),
              onPressed: () {
                signOutGoogle();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
