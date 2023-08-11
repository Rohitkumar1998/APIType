import 'package:example/ExampleFour.dart';
import 'package:example/exampleTHree.dart';
import 'package:example/exampletwo.dart';
import 'package:example/fifth.dart';
import 'package:example/home_sceen.dart';
import 'package:example/signup.dart';
import 'package:example/uploadImage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UploadImageSceen()
        //  SignUpApi()
        //  FifthExample()
        // ExampleFour()
        //  ExampleThree()
        // ExampleTwo()
        //HomeScreen()
        );
  }
}
