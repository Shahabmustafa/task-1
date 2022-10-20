import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'navbar_screen.dart';

class ShowdataScreen extends StatefulWidget {
  const ShowdataScreen({Key? key}) : super(key: key);

  @override
  State<ShowdataScreen> createState() => _ShowdataScreenState();
}

class _ShowdataScreenState extends State<ShowdataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Center(child: Text("Show Data")),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 3,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              QueryDocumentSnapshot x = snapshot.data!.docs[index];
              if(snapshot.hasData){
                return
                        Card(
                          child: Image.network(x["ImageUrl"],fit: BoxFit.fill,));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
          },
          );
        },
      ),
    );
  }
}
