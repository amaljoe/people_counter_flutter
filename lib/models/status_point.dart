import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StatusPoint {
  DateTime time;
  int inside;

  StatusPoint({@required this.inside, @required this.time});

  factory StatusPoint.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.data()['time'];
    return StatusPoint(
      inside: snapshot.data()['inside'],
      time:
          DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch)
              .subtract(Duration(hours: 5, minutes: 30)),
    );
  }

  factory StatusPoint.fromJson(Map json) {
    final Timestamp timestamp = json['time'];
    return StatusPoint(
      inside: json['inside'],
      time:
          DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch)
              .subtract(Duration(hours: 5, minutes: 30)),
    );
  }
}
