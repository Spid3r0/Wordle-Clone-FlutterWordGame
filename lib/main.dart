import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle_clone/wordle/screen.dart';



void main() {

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner:  false,
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => Screen(),
      },

    );
  }
}

