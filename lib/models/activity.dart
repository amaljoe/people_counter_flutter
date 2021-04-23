import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Activity {
  String id;
  int num;
  bool left;
  DateTime time;

  Activity(
      {@required this.id,
      @required this.left,
      @required this.time,
      @required this.num});

  factory Activity.fromSnapshot(QueryDocumentSnapshot activity) {
    final Timestamp timestamp = activity.data()['time'];
    return Activity(
      id: activity.id,
      left: activity.data()['activity'] == 'leave',
      time:
          DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch)
              .subtract(Duration(hours: 5, minutes: 30)),
      num: activity.data()['number'],
    );
  }
}
