import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_firebase/homepage.dart';
import 'package:learn_firebase/searchfromFirebase/getdatafromdatabase.dart';
//import 'package:learn_firebase/main.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot? snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return ListView.builder(
        itemCount: snapshotData!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(HomePage(),
                  transition: Transition.downToUp,
                  arguments: snapshotData!.docs[index]);
            },
            child: ListTile(
              leading: CircleAvatar(

                  // backgroundImage:  NetworkImage(
                  //     snapshotData!.docs[index].data()!['images'],
                  //   )
                  // backgroundImage:
                  //   AssetImage(snapshotData!.docs[index].data()['']),
                  //AssetImage(snapshotData!.docs[index].data()!['images']),
                  ),
              title: Text(
                snapshotData!.docs[index]['caption'],
                style: TextStyle(color: Colors.white),
              ),

              // Text(
              //  snapshotData!.docs[index].data()['caption'],
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 22.0),
              // ),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.clear),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    },
                    icon: Icon(Icons.search));
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Search Courses',
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
        backgroundColor: Colors.black,
      ),
      body: isExecuted
          ? searchData()
          : Container(
              child: Center(
                child: Text(
                  'Search your Image',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}
