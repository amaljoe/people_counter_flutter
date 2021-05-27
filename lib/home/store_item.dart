import 'package:flutter/material.dart';
import 'package:people_counter/store/store_screen.dart';
import 'package:people_counter/utils/constants.dart';

class StoreItem extends StatelessWidget {
  final String name;
  final int id;
  final List<String> offers;

  StoreItem({@required this.id, @required this.name, @required this.offers});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    StoreScreen(id: id, name: name, offers: offers)));
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: kLightBlue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.store,
              color: kBlue,
              size: 30,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, height: 1.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
