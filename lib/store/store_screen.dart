import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:people_counter/models/activity.dart';
import 'package:people_counter/store/components/status.dart';

import 'components/activity_item.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _listKey = GlobalKey<AnimatedListState>();
  List<Activity> listItems = [];
  final int startIndex = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            splashRadius: Material.defaultSplashRadius / 2,
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Margin Free',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder(
          future: _firestore
              .collection('activity')
              .orderBy('time', descending: true)
              .limit(10)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              List<QueryDocumentSnapshot> docs = snapshot.data.docs;
              docs.forEach((doc) {
                bool contains = false;
                listItems.forEach((element) {
                  if (element.id == doc.id) {
                    contains = true;
                    return;
                  }
                });
                if (!contains) {
                  listItems.add(Activity.fromSnapshot(doc));
                }
              });
              return StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('activity')
                    .orderBy('time', descending: true)
                    .limit(1)
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
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(8),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Recent Activity',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Center(
                          child: Text(
                            'No recent Activity',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    );
                  }
                  final activity = snapshot.data.docs.first;
                  bool contains = false;
                  listItems.forEach((element) {
                    if (element.id == activity.id) {
                      contains = true;
                      return;
                    }
                  });
                  if (!contains) {
                    listItems.insert(0, Activity.fromSnapshot(activity));
                    if (_listKey.currentState != null) {
                      _listKey.currentState.insertItem(startIndex);
                    }
                  }
                  return AnimatedList(
                    key: _listKey,
                    physics: BouncingScrollPhysics(),
                    initialItemCount: listItems.length + startIndex,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index, animation) {
                      if (index == 0) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Status());
                      } else if (index == 1) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Recent Activity',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        );
                      }
                      return SizeTransition(
                        sizeFactor: animation,
                        child: FadeTransition(
                            opacity: animation,
                            child: ActivityItem(listItems[index - startIndex])),
                      );
                    },
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
