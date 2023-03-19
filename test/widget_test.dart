import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post_data.dart';

void main() {
  test('Post object extracts correct values from named constructor 1', () {
    String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/wasteagram-2565d.appspot.com/o/1156697240.jpg2023-03-19%2003%3A08%3A45.771952?alt=media&token=0833f6f0-6de4-49c9-9690-6441a6e03e01';
    String dateTime = 'dateTime';
    int number = 3;
    double longitude = 2.123;
    double latitude = 1.321;
    
    final postData = PostData.fromProcessed(imageUrl, dateTime, number, longitude, latitude);
    expect(postData.imageUrl, imageUrl);
    expect(postData.dateTime, dateTime);
    expect(postData.number, number);
    expect(postData.longitude, longitude);
    expect(postData.latitude, latitude);

  });

  test('Post object extracts correct values from named constructor 2', () {
    String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/wasteagram-2565d.appspot.com/o/1156697240.jpg2023-03-19%2003%3A08%3A45.771952?alt=media&token=0833f6f0-6de4-49c9-9690-6441a6e03e01';
    String dateTime = 'dateTime';
    int number = 4;
    double longitude = 4.123;
    double latitude = 4.321;
    
    final postData = PostData.fromProcessed(imageUrl, dateTime, number, longitude, latitude);
    expect(postData.imageUrl, imageUrl);
    expect(postData.dateTime, dateTime);
    expect(postData.number, number);
    expect(postData.longitude, longitude);
    expect(postData.latitude, latitude);

  });
}
