import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screen/show_data.dart';
import 'navbar_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);
  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final dataController = TextEditingController();
  final priceController = TextEditingController();
  ImagePicker image = ImagePicker();
  File? file;
  String Url = "";
  getImages()async{
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  Future UploadFile()async{
    // String? Url;
    var imageFile = FirebaseStorage.instance.ref().child('images').child('jpeg');
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    Url = await snapshot.ref.getDownloadURL();
    // return Url;
    print(Url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Center(child: Text('Add Data')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        getImages();
                      },
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: file == null
                            ?AssetImage("")
                            :FileImage(File(file!.path)) as ImageProvider,

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: dataController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Item Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: priceController,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                          hintText: 'Item Price'
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        onPressed: ()async{
                          await UploadFile();
                          FirebaseFirestore.instance.collection('data').add({
                            'Name' : dataController.text.toString(),
                            'Price': priceController.text.toString(),
                            'ImageUrl' : Url,
                          });
                          print('Data Added');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowdataScreen()));
                    },
                        child: Text('Add Data'))
                  ],
                ),
                ),
              ],
            ),
      ),
    );
  }
}
