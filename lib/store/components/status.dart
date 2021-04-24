import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:people_counter/models/status_point.dart';
import 'package:people_counter/utils/status_graph.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final int max = 0;
  final _firestore = FirebaseFirestore.instance;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('status')
          .orderBy('time', descending: true)
          .endBefore([DateTime.now().add(Duration(hours: 5, minutes: 20))])
          .limit(11)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        print(snapshot.data.docs.length);
        if (snapshot.data.docs.length < 2) {
          return Center(
            child: Text(
              'Not enough data',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        List<StatusPoint> statusPoints = [];
        snapshot.data.docs.forEach((doc) {
          final pt = StatusPoint.fromSnapshot(doc);
          statusPoints.add(pt);
        });
        final statusGraph = StatusGraph(statusPoints: statusPoints, max: max);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Number of people in the store: ${statusPoints.first.inside}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.70,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Color(0xff232d37)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(
                    mainData(statusGraph), // Optional
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  LineChartData mainData(StatusGraph statusGraph) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return statusGraph.yAxis[0];
              case 5:
                return statusGraph.yAxis[1];
              case 8:
                return statusGraph.yAxis[2];
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return statusGraph.xAxis[0];
              case 3:
                return statusGraph.xAxis[1];
              case 5:
                return statusGraph.xAxis[2];
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          preventCurveOverShooting: false,
          spots: statusGraph.spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
