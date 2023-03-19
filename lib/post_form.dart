import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({super.key});

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {

  File? image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  late LocationData locationData;
  

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }

  Future<String> uploadImage() async {
    Reference sr = storage.ref().child(Path.basename(image!.path) + DateTime.now().toString());
    await sr.putFile(image!); 
    return await sr.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;

    if (image == null) {
      return Center(
        child: ElevatedButton(
          child: Text('Select Photo'),
          onPressed: () { getImage(); },
        )
      );
    } else {
      return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(image!),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      button: false,
                      enabled: true,
                      onTapHint: 'Text form to enter the number of items wasted',
                      child: TextFormField(
                        autofocus:true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Number of items wasted',
                          border: OutlineInputBorder()
                        ),
                        onSaved: (value) {
                          number = int.parse(value!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a number';
                          } else {
                            return null;
                          }
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Semantics(
                        button: true,
                        enabled: true,
                        onTapHint: 'Make new entry and upload to database',
                        child: ElevatedButton(
                          child: Text('Post Image'),
                          style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              retrieveLocation();
                              String url = await uploadImage();
                              DateTime now = DateTime.now();
                              String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
                              
                              FirebaseFirestore.instance
                                  .collection('wasteagram')
                                  .add({'imageUrl': url, 'number': number, 'dateTime' : formattedDate, 
                                        'timeStamp' : FieldValue.serverTimestamp(), 
                                        'latitude' : locationData.latitude, 'longitude' : locationData.longitude});
                              Navigator.pop(context);                          
                            }
                          }
                        ),
                      ),
                    )
                  ]
                )
              )
            ],
          ),
        )
      );
    }
  }
}