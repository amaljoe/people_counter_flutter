import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:people_counter/models/activity.dart';
import 'package:people_counter/store/components/status.dart';

import 'components/offer.dart';

class StoreScreen extends StatefulWidget {
  final int id;
  final String name;
  final List<String> offers;

  StoreScreen({this.id, this.name, this.offers});

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
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              widget.name,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: ListView.builder(
              itemCount: 2 + widget.offers.length,
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Status(store: widget.id));
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Offers',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return Offer(widget.offers[index - 2]);
              })),
    );
  }
}
