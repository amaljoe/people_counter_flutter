import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:people_counter/home/home_screen.dart';
import 'package:people_counter/splash_screen.dart';
import 'package:people_counter/store/store_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff232d37)));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crowd Analyser',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SplashScreen();
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return HomeScreen();
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return SplashScreen();
          },
        ));
  }
}

// Mjpeg(
//   isLive: true,
//   stream: 'http://10.0.2.2:3000/video_feed',
