import 'package:flutter/material.dart';
import 'package:people_counter/models/activity.dart';
import 'package:people_counter/utils/constants.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem(
    this.activity, {
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
                color: activity.left ? kLightRed : kLightBlue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.directions_walk_rounded,
              color: activity.left ? kRed : kBlue,
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
                  activity.num.toString() +
                      (activity.num == 1 ? ' person ' : ' people ') +
                      (activity.left ? 'left' : 'entered') +
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
                '${activity.time.hour % 12}:${activity.time.minute > 9 ? activity.time.minute : '0' + activity.time.minute.toString()} ' +
                    (activity.time.hour > 12 ? 'PM' : 'AM'),
                style: TextStyle(fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }
}
