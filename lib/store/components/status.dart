import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:people_counter/models/status_point.dart';
import 'package:people_counter/utils/constants.dart';

int max = 30;

class Status extends StatefulWidget {
  final int store;

  Status({@required this.store});

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
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
          .where('store', isEqualTo: widget.store)
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
        if (snapshot.data.docs.length == 0) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final status = StatusPoint.fromSnapshot(snapshot.data.docs.first);
        return Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: GaugeChart.withData(status.inside, max)),
            Positioned.fill(
              child: Center(
                child: Text(
                  status.inside.toString(),
                  style: TextStyle(
                      color: status.inside > max - 10 ? kRed : kBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 48),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withData(int inside, int total) {
    return new GaugeChart(
      _createSampleData(inside, total),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 30,
          startAngle: 4 / 5 * pi,
          arcLength: 7 / 5 * pi,
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData(
      int filled, int total) {
    int unfilled = total - filled;
    if (unfilled < 0) {
      unfilled = 0;
    }
    final data = [
      new GaugeSegment('Occupied', filled),
      new GaugeSegment('Unoccupied', unfilled),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
