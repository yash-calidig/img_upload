import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_firebase/googlesignin.dart';
import 'package:learn_firebase/searchfromFirebase/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Google(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? sampleImage;
  TextEditingController captionController = TextEditingController();
  // var compressImagePath = ''.obs;
  // var compressImageSize = ''.obs;
  // var selectedImagePath = ''.obs;
  // var selectedImageSize = ''.obs;

  late Map<String, dynamic> dataToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("data");
  addData() {
    dataToAdd = {
      "caption": captionController.text,
    };

    collectionReference
        .add(dataToAdd)
        .whenComplete(() => print('Added to the Database'));
  }

  Future getImage(ImageSource source) async {
    PickedFile tempImage = await ImagePicker()
        .getImage(source: source, imageQuality: 50) as PickedFile;

    File selected = File(tempImage.path);
    setState(() {
      sampleImage = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Upload'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: new Center(
          child:
              sampleImage == null ? Text(' Select an Image') : enableUpload(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new FloatingActionButton(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            tooltip: 'Add Image',
            child: new Icon(Icons.photo_album),
          ),
          new FloatingActionButton(
            onPressed: () {
              getImage(ImageSource.camera);
            },
            tooltip: 'Add Image',
            child: new Icon(Icons.add_a_photo),
          ),
          new FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            tooltip: 'Add Image',
            child: new Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(
            sampleImage!,
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: captionController,
            decoration: InputDecoration(
              labelText: 'caption',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child('images/${captionController.text}');

              final UploadTask task = firebaseStorageRef.putFile(sampleImage!);
              addData();
              print(sampleImage!.path);
            },
            child: Text('Upload'),
            style: ElevatedButton.styleFrom(
                //textStyle: ,

                ),
          )
        ],
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     if (firebaseUser != null) {
//       return MyHomePage();
//     }
//     return GoogleSign();
//   }
// }
