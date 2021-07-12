import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color primaryColor = Colors.deepPurpleAccent;
  Color secondaryColor = Colors.blue.shade700;
  Color logoGreen = Colors.pinkAccent;

  TextEditingController nameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  late Map<String, dynamic> productToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("products");
  addProduct() {
    productToAdd = {
      "name": nameController.text,
      "imageUrl": imageUrlController.text,
    };

    collectionReference
        .add(productToAdd)
        .whenComplete(() => print('Added to the Database'));
  }

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),

            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
                child: Text(
              'Upload Image with its name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            )),
            SizedBox(
              height: 50,
            ),
            _buildTextField(nameController, 'Name'),
            SizedBox(
              height: 20,
            ),
            _buildTextField(imageUrlController, 'Image Url'),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: logoGreen,
              ),
              onPressed: () {
                addProduct();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Upload'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
