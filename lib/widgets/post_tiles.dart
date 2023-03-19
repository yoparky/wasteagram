import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class PostTiles extends StatefulWidget {
  const PostTiles({super.key});

  @override
  State<PostTiles> createState() => _PostTilesState();
}

class _PostTilesState extends State<PostTiles> {

  File? image;

  Future getImage() async {

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (content, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return ListTile(
                title: Text(post['name']),
                subtitle: Text(post['votes'].toString())
              );
            }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }

      }
    );
  }
}