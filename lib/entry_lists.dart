import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'post_form_scaffold.dart';


class EntryLists extends StatefulWidget {
  const EntryLists({Key? key}) : super(key: key);

  @override
  EntryListsState createState() => EntryListsState();
}

class EntryListsState extends State<EntryLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('wasteagram').orderBy('timeStamp', descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return ListTile(
                        title: Text(post['dateTime']),
                        trailing: Text(post['number'].toString()),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  
                        JournalDetails(post['number'], post['dateTime'], post['imageUrl'], post['latitude'],post['longitude'])));}
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: const NewEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
 * As an example I have added functionality to add an entry to the collection
 * if the button is pressed
 */
class NewEntryButton extends StatelessWidget {
  const NewEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  FormRoute()));
          // DateTime now = DateTime.now();
          // String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
          // FirebaseFirestore.instance
          //     .collection('wasteagram')
          //     .add({'name': 'Big Tinks', 'number': 22, 'dateTime' : formattedDate, 'timeStamp' : FieldValue.serverTimestamp()});
        });
  }
}
//
// Details page
//
class JournalDetails extends StatelessWidget {
  JournalDetails(this.number, this.date, this.imageUrl, this.latitude, this.longitude, {super.key});

  int number;
  String date;
  String imageUrl;
  double latitude;
  double longitude;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Entry Details'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('\n$date\n', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 28)),
              Image.network(imageUrl),
              Text('\nMaterial Wasted : $number\n'),
              Text('\nlatitude : $latitude\n'),
              Text('\nlongitude : $longitude\n'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: Text('Back to Entry List'))
            ]
          )
        )
      )
    );
  }
  
}