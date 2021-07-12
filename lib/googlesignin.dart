// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignIn extends StatefulWidget {
//   const GoogleSignIn({Key? key}) : super(key: key);

//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }

// class _GoogleSignInState extends State<GoogleSignIn> {
//   GoogleSignIn googleAuth = new GoogleSignIn();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: MaterialButton(
//           onPressed: () {
//             googleAuth.signIn().then((result) {
//               result.authentication.then((googleKey) {
//                 FirebaseAuth.instance
//                     .signInWithGoogle(
//                         idToken: googleKey.idToken,
//                         accessToken: googleKey.accessToken)
//                     .then((signedInUser) {
//                   print('Signed In as ${signedInUser.displayName}');
//                   Navigator.of(context).pushReplacementNamed('/MyhomePage');
//                 }).catchError((e) {
//                   print(e);
//                 });
//               }).catchError((e) {
//                 print(e);
//               });
//             }).catchError((e) {
//               print(e);
//             });
//           },
//           child: Text("Login with Google"),
//           color: Colors.red,
//           textColor: Colors.white,
//           elevation: 7.0,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final _firestore = Firestore.instance;
import 'package:flutter/material.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_firebase/googleUser.dart';
import 'package:learn_firebase/homeandSignout.dart';
// import 'package:learn_firebase/main.dart';

final _firestore = FirebaseFirestore.instance;

class Google extends StatelessWidget {
  const Google({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: Colors.white,
        child: Text('SignIn With Google'),
        onPressed: () {
          signInWithGoogle().then((onValue) {
            _firestore
                .collection('users')
                .doc('auth')
                .collection('gusers')
                .add({'email': email, 'image': imageUl, 'name': name});
          }).catchError((e) {
            print(e);
          }).then((onValue) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }).catchError((e) {
            print(e);
          });
        },
      ),
    );
  }
}
