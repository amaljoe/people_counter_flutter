import 'package:flutter/material.dart';
import 'package:people_counter/utils/constants.dart';

class Offer extends StatelessWidget {
  final String text;

  const Offer(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: kLightBlue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.local_offer_rounded,
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
                  text,
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
