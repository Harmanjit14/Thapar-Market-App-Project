import 'package:TMart/colorFile.dart';
import 'package:TMart/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget with ColorFile{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thapar Market',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primaryColor: charcoal,
        scaffoldBackgroundColor: Colors.white
        
        
      ),
      home:HomeScreen(),
    );
  }
}

