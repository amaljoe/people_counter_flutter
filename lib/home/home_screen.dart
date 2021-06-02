import 'package:flutter/material.dart';
import 'package:people_counter/home/store_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              StoreItem(id: 1, name: "Store 1", offers: [
                'Upto 20% off for laundry essentials',
                'get something for something',
                'Buy 2l bottle of pepsi get 750ml free'
              ]),
              StoreItem(id: 2, name: "Store 2", offers: [
                'Buy 1 get 1 offer on 1L pack of Tropicana mango juice',
                '2 masks free with a box of 10 surgical masks',
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
