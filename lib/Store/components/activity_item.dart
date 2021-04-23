import 'package:flutter/material.dart';
import 'package:people_counter/utils/constants.dart';

class ActivityItem extends StatelessWidget {
  final bool left;
  final String time;
  final int num;

  const ActivityItem({
    this.left = false,
    @required this.num,
    @required this.time,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: left ? kLightRed : kLightBlue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.directions_walk_rounded,
              color: left ? kRed : kBlue,
              size: 40,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  num.toString() +
                      (num == 1 ? ' person ' : ' people ') +
                      (left ? 'left' : 'entered') +
                      ' the store',
                  style: TextStyle(fontSize: 18, height: 1.1),
                ),
              ],
            ),
          ),
          SizedBox(width: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.schedule_rounded),
              SizedBox(height: 4),
              Text(
                '3:15 PM',
                style: TextStyle(fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }
}
