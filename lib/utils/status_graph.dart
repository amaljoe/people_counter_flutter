import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_counter/models/status_point.dart';

class StatusGraph {
  List<StatusPoint> statusPoints = [];
  int max;
  int upper;
  DateTime startTime;
  DateTime endTime;
  List<String> xAxis;
  List<String> yAxis;
  List<FlSpot> spots = [];

  StatusGraph({@required this.statusPoints, this.max}) {
    startTime = statusPoints.last.time;
    endTime = statusPoints.first.time;
    _getUpperLimit();
    _findXAxis();
    _findYAxis();
    _getSpots();
  }

  void _findXAxis() {
    final Duration gap = endTime.difference(startTime);
    final Duration div = Duration(milliseconds: gap.inMilliseconds ~/ 11);
    final y1 = startTime.add(div * 2);
    final y2 = startTime.add(div * 5);
    final y3 = startTime.add(div * 8);
    yAxis = [getFormattedTime(y1), getFormattedTime(y2), getFormattedTime(y3)];
  }

  void _findYAxis() {
    final double div = upper / 6;
    final x1 = div * 1;
    final x2 = div * 3;
    final x3 = div * 5;
    xAxis = [
      x1.round().toString(),
      x2.round().toString(),
      x3.round().toString()
    ];
  }

  void _getSpots() {
    statusPoints.forEach((pt) {
      final Duration gap = endTime.difference(startTime);
      double dx = pt.time.difference(startTime).inMilliseconds /
          gap.inMilliseconds *
          11;
      double dy = pt.inside / upper * 6;
      spots.add(FlSpot(dx, dy));
    });
  }

  void _getUpperLimit() {
    upper = statusPoints.first.inside;
    statusPoints.forEach((pt) {
      if (pt.inside > upper) {
        upper = pt.inside;
      }
    });
    upper = upper ~/ 5 * 5;
    if (upper > 0) {
      upper += upper ~/ 2;
    } else {
      upper += 5;
    }
  }

  static String getFormattedTime(DateTime time) {
    int hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    return '$hour :${time.minute > 9 ? time.minute : '0' + time.minute.toString()} ' +
        (time.hour > 12 ? 'PM' : 'AM');
  }
}
