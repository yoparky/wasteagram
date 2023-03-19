import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  late String imageUrl;
  late String dateTime;
  late int number;
  late double longitude;
  late double latitude;

  PostData(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    var post = snapshot.data!.docs[index];
    imageUrl = post['imageUrl'];
    dateTime = post['dateTime'];
    number = post['number'];
    longitude = post['longitude'];
    latitude = post['latitude'];
  }
  PostData.fromProcessed(this.imageUrl, this.dateTime, this.number, this.longitude, this.latitude);

}