import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final int max = 0;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('status')
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
        if (snapshot.data.docs.isEmpty) {
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        final status = snapshot.data.docs.first;
        final int inside = status['inside'];
        return Text(status.data().toString());
      },
    );
  }
}
