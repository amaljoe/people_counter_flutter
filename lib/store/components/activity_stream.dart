import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:people_counter/Store/components/activity_item.dart';

class ActivityStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('activity')
          .orderBy('time', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final activities = snapshot.data.docs;
        List<ActivityItem> activityItems = [];
        for (var activity in activities) {
          final Timestamp timestamp = activity.data()['time'];
          ActivityItem activityItem = ActivityItem(
            left: activity.data()['activity'] == 'leave',
            time: DateTime.fromMicrosecondsSinceEpoch(
                    timestamp.microsecondsSinceEpoch)
                .subtract(Duration(hours: 5, minutes: 30)),
            num: activity.data()['number'],
          );
          activityItems.add(activityItem);
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: activityItems,
          ),
        );
      },
    );
  }
}
