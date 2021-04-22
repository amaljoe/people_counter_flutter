import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'People Counter',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          // Image.network(
          //    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/still-jpg-708x326-1588005068.jpg?crop=0.9209039548022598xw:1xh;center,top&resize=480:*'),
          // Mjpeg(
          //   isLive: true,
          //   stream: 'http://10.0.2.2:3000/video_feed',
          // ),
          Container(
            height: 500,
            child: WebView(
              initialUrl: 'http://10.0.2.2:3000/video_feed',
            ),
          ),
          Text('1 person left the store')
        ],
      ),
    );
  }
}
